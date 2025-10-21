/*
ROADMAP ENGENHARIA DE DADOS - M�S 2
Script: 10_transacoes_controle.sql
Data: 11/10/2025
Descri��o: Controle de transa��es ACID, concorr�ncia e isolamento
*/

PRINT 'INICIANDO SCRIPT: CONTROLE DE TRANSA��ES';
GO

USE master;
GO

-- CONFIGURA��O INICIAL
IF DB_ID('RoadmapEngenhariaDados') IS NULL
BEGIN
    CREATE DATABASE RoadmapEngenhariaDados;
    PRINT 'Banco de dados RoadmapEngenhariaDados criado.';
END
ELSE
BEGIN
    PRINT 'Banco de dados RoadmapEngenhariaDados j� existe.';
END
GO

USE RoadmapEngenhariaDados;
GO

-- PREPARA��O DO AMBIENTE
PRINT 'PREPARANDO AMBIENTE PARA TRANSA��ES';
GO

-- Criar tabela para demonstra��o de transa��es
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
    PRINT 'Tabela ContasBancarias j� existe.';
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
    PRINT 'Tabela Transacoes j� existe.';
END
GO

-- Inserir dados de exemplo se a tabela estiver vazia
IF NOT EXISTS (SELECT * FROM ContasBancarias)
BEGIN
    INSERT INTO ContasBancarias (ClienteNome, Saldo) VALUES
    ('Jo�o Silva', 1000.00),
    ('Maria Santos', 500.00),
    ('Pedro Oliveira', 1500.00);
    PRINT 'Dados de exemplo inseridos em ContasBancarias.';
END
ELSE
BEGIN
    PRINT 'Dados j� existem em ContasBancarias.';
END
GO

PRINT 'DEMONSTRACAO 1: TRANSA��O SIMPLES COM COMMIT';
GO

PRINT 'Saldo inicial das contas:';
SELECT ContaID, ClienteNome, Saldo FROM ContasBancarias;
GO

PRINT 'Iniciando transa��o de transfer�ncia';
GO

BEGIN TRY
    BEGIN TRANSACTION;
    
    PRINT 'Debitando R$ 100 da conta de Jo�o';
    UPDATE ContasBancarias 
    SET Saldo = Saldo - 100,
        UltimaAtualizacao = GETDATE()
    WHERE ContaID = 1;
    
    PRINT 'Creditando R$ 100 na conta de Maria';
    UPDATE ContasBancarias 
    SET Saldo = Saldo + 100,
        UltimaAtualizacao = GETDATE()
    WHERE ContaID = 2;
    
    PRINT 'Registrando a transa��o';
    INSERT INTO Transacoes (ContaOrigemID, ContaDestinoID, Valor, TipoTransacao, Status)
    VALUES (1, 2, 100.00, 'Transfer�ncia', 'Conclu�da');
    
    COMMIT TRANSACTION;
    PRINT 'TRANSA��O COMMITADA: Transfer�ncia realizada com sucesso';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'TRANSA��O FALHOU: ' + ERROR_MESSAGE();
    PRINT 'Rollback executado - nenhuma altera��o foi persistida';
END CATCH;
GO

PRINT 'Saldo ap�s transfer�ncia:';
SELECT ContaID, ClienteNome, Saldo FROM ContasBancarias;
GO

PRINT 'DEMONSTRACAO 2: TRANSA��O COM ROLLBACK POR ERRO';
GO

PRINT 'Simulando transa��o com erro de saldo insuficiente';
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
        RAISERROR('Saldo insuficiente para realizar a transa��o', 16, 1);
    END;
    
    PRINT 'Registrando transa��o';
    INSERT INTO Transacoes (ContaOrigemID, Valor, TipoTransacao, Status)
    VALUES (2, 5000.00, 'Saque', 'Conclu�da');
    
    COMMIT TRANSACTION;
    PRINT 'TRANSA��O COMMITADA';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'TRANSA��O FALHOU: ' + ERROR_MESSAGE();
    PRINT 'Rollback executado - saldo mantido inalterado';
END CATCH;
GO

PRINT 'Verificando que o saldo n�o foi alterado:';
SELECT ContaID, ClienteNome, Saldo FROM ContasBancarias WHERE ContaID = 2;
GO

PRINT 'DEMONSTRACAO 3: SAVEPOINT E ROLLBACK PARCIAL';
GO

PRINT 'Demonstrando uso de SAVEPOINT para rollback parcial';
GO

BEGIN TRANSACTION;
    
    PRINT 'Opera��o 1 - Update simples';
    UPDATE ContasBancarias SET UltimaAtualizacao = GETDATE() WHERE ContaID = 1;
    
    PRINT 'Criando SAVEPOINT';
    SAVE TRANSACTION PontoSalvo;
    
    PRINT 'Opera��o 2 - Tentativa de update problem�tico';
    UPDATE ContasBancarias SET Saldo = -100 WHERE ContaID = 3;
    
    PRINT 'Rollback para SAVEPOINT (desfaz apenas opera��o 2)';
    ROLLBACK TRANSACTION PontoSalvo;
    
    PRINT 'Opera��o 3 - Update v�lido ap�s rollback parcial';
    UPDATE ContasBancarias SET UltimaAtualizacao = GETDATE() WHERE ContaID = 3;
    
COMMIT TRANSACTION;
PRINT 'TRANSA��O COMMITADA com rollback parcial';
GO

PRINT 'Verificando que apenas as opera��es v�lidas persistiram:';
SELECT ContaID, ClienteNome, Saldo, UltimaAtualizacao FROM ContasBancarias;
GO

PRINT 'DEMONSTRACAO 4: N�VEIS DE ISOLAMENTO';
GO

PRINT 'Demonstrando diferentes n�veis de isolamento';
GO

-- Teste READ COMMITTED (padr�o)
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

-- Voltar para o n�vel padr�o
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
GO

PRINT 'DEMONSTRACAO 5: TRANSA��O DISTRIBU�DA SIMULADA';
GO

PRINT 'Simulando transa��o distribu�da entre duas opera��es';
GO

BEGIN TRY
    BEGIN TRANSACTION;
    
    PRINT 'Opera��o local - Atualizando conta origem';
    UPDATE ContasBancarias 
    SET Saldo = Saldo - 50,
        UltimaAtualizacao = GETDATE()
    WHERE ContaID = 1;
    
    PRINT 'Opera��o remota - Inserindo registro de transa��o';
    INSERT INTO Transacoes (ContaOrigemID, Valor, TipoTransacao, Status)
    VALUES (1, 50.00, 'Pagamento', 'Conclu�da');
    
    -- Simulando valida��o de consist�ncia
    IF (SELECT Saldo FROM ContasBancarias WHERE ContaID = 1) < 0
    BEGIN
        RAISERROR('Saldo negativo detectado ap�s opera��o', 16, 1);
    END;
    
    COMMIT TRANSACTION;
    PRINT 'TRANSA��O DISTRIBU�DA COMMITADA com sucesso';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'TRANSA��O DISTRIBU�DA FALHOU: ' + ERROR_MESSAGE();
    PRINT 'Rollback completo executado';
END CATCH;
GO

PRINT 'RESUMO DAS TRANSA��ES REALIZADAS';
GO

PRINT 'Hist�rico de transa��es:';
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

PRINT 'SCRIPT DE TRANSA��ES CONCLU�DO';
GO