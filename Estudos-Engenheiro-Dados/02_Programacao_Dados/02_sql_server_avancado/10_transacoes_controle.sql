/*
ROADMAP ENGENHARIA DE DADOS - MÊS 2
Script: 10_transacoes_controle.sql
Data: 11/10/2025
Descrição: Controle de transações ACID, concorrência e isolamento
*/

PRINT 'INICIANDO SCRIPT: CONTROLE DE TRANSAÇÕES';
GO

USE master;
GO

-- CONFIGURAÇÃO INICIAL
IF DB_ID('RoadmapEngenhariaDados') IS NULL
BEGIN
    CREATE DATABASE RoadmapEngenhariaDados;
    PRINT 'Banco de dados RoadmapEngenhariaDados criado.';
END
ELSE
BEGIN
    PRINT 'Banco de dados RoadmapEngenhariaDados já existe.';
END
GO

USE RoadmapEngenhariaDados;
GO

-- PREPARAÇÃO DO AMBIENTE
PRINT 'PREPARANDO AMBIENTE PARA TRANSAÇÕES';
GO

-- Criar tabela para demonstração de transações
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ContasBancarias')
BEGIN
    CREATE TABLE ContasBancarias (
        ContaID INT PRIMARY KEY IDENTITY(1,1),
        ClienteNome NVARCHAR(100) NOT NULL,
        Saldo DECIMAL(10,2) NOT NULL DEFAULT 0,
        DataCriacao DATETIME DEFAULT GETDATE(),
        UltimaAtualizacao DATETIME DEFAULT GETDATE()
    );
    PRINT 'Tabela ContasBancarias criada.';
END
ELSE
BEGIN
    PRINT 'Tabela ContasBancarias já existe.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Transacoes')
BEGIN
    CREATE TABLE Transacoes (
        TransacaoID INT PRIMARY KEY IDENTITY(1,1),
        ContaOrigemID INT NULL,
        ContaDestinoID INT NULL,
        Valor DECIMAL(10,2) NOT NULL,
        TipoTransacao NVARCHAR(20) NOT NULL,
        DataTransacao DATETIME DEFAULT GETDATE(),
        Status NVARCHAR(20) DEFAULT 'Pendente'
    );
    PRINT 'Tabela Transacoes criada.';
END
ELSE
BEGIN
    PRINT 'Tabela Transacoes já existe.';
END
GO

-- Inserir dados de exemplo se a tabela estiver vazia
IF NOT EXISTS (SELECT * FROM ContasBancarias)
BEGIN
    INSERT INTO ContasBancarias (ClienteNome, Saldo) VALUES
    ('João Silva', 1000.00),
    ('Maria Santos', 500.00),
    ('Pedro Oliveira', 1500.00);
    PRINT 'Dados de exemplo inseridos em ContasBancarias.';
END
ELSE
BEGIN
    PRINT 'Dados já existem em ContasBancarias.';
END
GO

PRINT 'DEMONSTRACAO 1: TRANSAÇÃO SIMPLES COM COMMIT';
GO

PRINT 'Saldo inicial das contas:';
SELECT ContaID, ClienteNome, Saldo FROM ContasBancarias;
GO

PRINT 'Iniciando transação de transferência';
GO

BEGIN TRY
    BEGIN TRANSACTION;
    
    PRINT 'Debitando R$ 100 da conta de João';
    UPDATE ContasBancarias 
    SET Saldo = Saldo - 100,
        UltimaAtualizacao = GETDATE()
    WHERE ContaID = 1;
    
    PRINT 'Creditando R$ 100 na conta de Maria';
    UPDATE ContasBancarias 
    SET Saldo = Saldo + 100,
        UltimaAtualizacao = GETDATE()
    WHERE ContaID = 2;
    
    PRINT 'Registrando a transação';
    INSERT INTO Transacoes (ContaOrigemID, ContaDestinoID, Valor, TipoTransacao, Status)
    VALUES (1, 2, 100.00, 'Transferência', 'Concluída');
    
    COMMIT TRANSACTION;
    PRINT 'TRANSAÇÃO COMMITADA: Transferência realizada com sucesso';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'TRANSAÇÃO FALHOU: ' + ERROR_MESSAGE();
    PRINT 'Rollback executado - nenhuma alteração foi persistida';
END CATCH;
GO

PRINT 'Saldo após transferência:';
SELECT ContaID, ClienteNome, Saldo FROM ContasBancarias;
GO

PRINT 'DEMONSTRACAO 2: TRANSAÇÃO COM ROLLBACK POR ERRO';
GO

PRINT 'Simulando transação com erro de saldo insuficiente';
GO

BEGIN TRY
    BEGIN TRANSACTION;
    
    PRINT 'Tentando debitar R$ 5000 da conta de Maria';
    UPDATE ContasBancarias 
    SET Saldo = Saldo - 5000,
        UltimaAtualizacao = GETDATE()
    WHERE ContaID = 2;
    
    -- Verificar se o saldo ficou negativo
    IF EXISTS (SELECT 1 FROM ContasBancarias WHERE ContaID = 2 AND Saldo < 0)
    BEGIN
        RAISERROR('Saldo insuficiente para realizar a transação', 16, 1);
    END;
    
    PRINT 'Registrando transação';
    INSERT INTO Transacoes (ContaOrigemID, Valor, TipoTransacao, Status)
    VALUES (2, 5000.00, 'Saque', 'Concluída');
    
    COMMIT TRANSACTION;
    PRINT 'TRANSAÇÃO COMMITADA';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'TRANSAÇÃO FALHOU: ' + ERROR_MESSAGE();
    PRINT 'Rollback executado - saldo mantido inalterado';
END CATCH;
GO

PRINT 'Verificando que o saldo não foi alterado:';
SELECT ContaID, ClienteNome, Saldo FROM ContasBancarias WHERE ContaID = 2;
GO

PRINT 'DEMONSTRACAO 3: SAVEPOINT E ROLLBACK PARCIAL';
GO

PRINT 'Demonstrando uso de SAVEPOINT para rollback parcial';
GO

BEGIN TRANSACTION;
    
    PRINT 'Operação 1 - Update simples';
    UPDATE ContasBancarias SET UltimaAtualizacao = GETDATE() WHERE ContaID = 1;
    
    PRINT 'Criando SAVEPOINT';
    SAVE TRANSACTION PontoSalvo;
    
    PRINT 'Operação 2 - Tentativa de update problemático';
    UPDATE ContasBancarias SET Saldo = -100 WHERE ContaID = 3;
    
    PRINT 'Rollback para SAVEPOINT (desfaz apenas operação 2)';
    ROLLBACK TRANSACTION PontoSalvo;
    
    PRINT 'Operação 3 - Update válido após rollback parcial';
    UPDATE ContasBancarias SET UltimaAtualizacao = GETDATE() WHERE ContaID = 3;
    
COMMIT TRANSACTION;
PRINT 'TRANSAÇÃO COMMITADA com rollback parcial';
GO

PRINT 'Verificando que apenas as operações válidas persistiram:';
SELECT ContaID, ClienteNome, Saldo, UltimaAtualizacao FROM ContasBancarias;
GO

PRINT 'DEMONSTRACAO 4: NÍVEIS DE ISOLAMENTO';
GO

PRINT 'Demonstrando diferentes níveis de isolamento';
GO

-- Teste READ COMMITTED (padrão)
PRINT 'Testando ISOLATION LEVEL READ COMMITTED';
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;
    SELECT 
        ContaID, 
        ClienteNome, 
        Saldo,
        'READ COMMITTED' as NivelIsolamento
    FROM ContasBancarias;
COMMIT TRANSACTION;
GO

-- Teste REPEATABLE READ
PRINT 'Testando ISOLATION LEVEL REPEATABLE READ';
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRANSACTION;
    SELECT 
        ContaID, 
        ClienteNome, 
        Saldo,
        'REPEATABLE READ' as NivelIsolamento
    FROM ContasBancarias;
COMMIT TRANSACTION;
GO

-- Teste SERIALIZABLE
PRINT 'Testando ISOLATION LEVEL SERIALIZABLE';
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;
    SELECT 
        ContaID, 
        ClienteNome, 
        Saldo,
        'SERIALIZABLE' as NivelIsolamento
    FROM ContasBancarias;
COMMIT TRANSACTION;
GO

-- Voltar para o nível padrão
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
GO

PRINT 'DEMONSTRACAO 5: TRANSAÇÃO DISTRIBUÍDA SIMULADA';
GO

PRINT 'Simulando transação distribuída entre duas operações';
GO

BEGIN TRY
    BEGIN TRANSACTION;
    
    PRINT 'Operação local - Atualizando conta origem';
    UPDATE ContasBancarias 
    SET Saldo = Saldo - 50,
        UltimaAtualizacao = GETDATE()
    WHERE ContaID = 1;
    
    PRINT 'Operação remota - Inserindo registro de transação';
    INSERT INTO Transacoes (ContaOrigemID, Valor, TipoTransacao, Status)
    VALUES (1, 50.00, 'Pagamento', 'Concluída');
    
    -- Simulando validação de consistência
    IF (SELECT Saldo FROM ContasBancarias WHERE ContaID = 1) < 0
    BEGIN
        RAISERROR('Saldo negativo detectado após operação', 16, 1);
    END;
    
    COMMIT TRANSACTION;
    PRINT 'TRANSAÇÃO DISTRIBUÍDA COMMITADA com sucesso';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'TRANSAÇÃO DISTRIBUÍDA FALHOU: ' + ERROR_MESSAGE();
    PRINT 'Rollback completo executado';
END CATCH;
GO

PRINT 'RESUMO DAS TRANSAÇÕES REALIZADAS';
GO

PRINT 'Histórico de transações:';
SELECT 
    TransacaoID,
    ContaOrigemID,
    ContaDestinoID,
    Valor,
    TipoTransacao,
    Status,
    DataTransacao
FROM Transacoes 
ORDER BY DataTransacao DESC;
GO

PRINT 'Saldo final das contas:';
SELECT ContaID, ClienteNome, Saldo FROM ContasBancarias;
GO

PRINT 'SCRIPT DE TRANSAÇÕES CONCLUÍDO';
GO