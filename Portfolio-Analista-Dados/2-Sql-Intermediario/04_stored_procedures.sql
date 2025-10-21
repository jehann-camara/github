/*
ROADMAP ENGENHARIA DE DADOS - MÊS 2
Script: 07_stored_procedures.sql
Data: 11/10/2025
Descrição: Stored Procedures - Script corrigido e profissional
*/

USE RoadmapEngenhariaDados;
GO

PRINT '=== INICIANDO SCRIPT: STORED PROCEDURES ===';
GO

-- Configurar ambiente
IF DB_ID('RoadmapDB') IS NULL
BEGIN
    CREATE DATABASE RoadmapDB;
    PRINT 'Banco de dados RoadmapDB criado.';
END
ELSE
BEGIN
    PRINT 'Banco de dados RoadmapDB já existe.';
END
GO

USE RoadmapDB;
GO

-- Criar tabelas se não existirem
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Clientes')
BEGIN
    CREATE TABLE Clientes (
        ClienteID INT PRIMARY KEY IDENTITY(1,1),
        Nome NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100),
        DataCadastro DATETIME DEFAULT GETDATE()
    );
    PRINT 'Tabela Clientes criada.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Vendas')
BEGIN
    CREATE TABLE Vendas (
        VendaID INT PRIMARY KEY IDENTITY(1,1),
        ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
        Produto NVARCHAR(100) NOT NULL,
        Quantidade INT NOT NULL,
        Valor DECIMAL(10,2) NOT NULL,
        DataVenda DATETIME DEFAULT GETDATE()
    );
    PRINT 'Tabela Vendas criada.';
END
GO

-- Inserir dados de exemplo
IF NOT EXISTS (SELECT * FROM Clientes)
BEGIN
    INSERT INTO Clientes (Nome, Email) VALUES
    ('João Silva', 'joao@email.com'),
    ('Maria Santos', 'maria@email.com'),
    ('Pedro Oliveira', 'pedro@email.com');
    PRINT 'Dados de exemplo inseridos em Clientes.';
END
GO

IF NOT EXISTS (SELECT * FROM Vendas)
BEGIN
    INSERT INTO Vendas (ClienteID, Produto, Quantidade, Valor) VALUES
    (1, 'Notebook', 1, 2500.00),
    (1, 'Mouse', 2, 50.00),
    (2, 'Teclado', 1, 120.00),
    (3, 'Monitor', 1, 800.00);
    PRINT 'Dados de exemplo inseridos em Vendas.';
END
GO

PRINT '--- CRIAÇÃO DE STORED PROCEDURES ---';
GO

-- 1. PROCEDURE: Relatório de vendas por cliente
CREATE OR ALTER PROCEDURE sp_vendas_cliente
    @ClienteID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @ClienteID IS NULL
    BEGIN
        SELECT 
            c.Nome AS Cliente,
            v.Produto,
            v.Quantidade,
            v.Valor,
            v.DataVenda
        FROM Vendas v
        INNER JOIN Clientes c ON v.ClienteID = c.ClienteID
        ORDER BY c.Nome, v.DataVenda DESC;
        
        PRINT 'Relatório: TODOS os clientes';
    END
    ELSE
    BEGIN
        SELECT 
            c.Nome AS Cliente,
            v.Produto,
            v.Quantidade,
            v.Valor,
            v.DataVenda
        FROM Vendas v
        INNER JOIN Clientes c ON v.ClienteID = c.ClienteID
        WHERE c.ClienteID = @ClienteID
        ORDER BY v.DataVenda DESC;
        
        PRINT 'Relatório: Cliente ID ' + CAST(@ClienteID AS VARCHAR);
    END
END;
GO

PRINT 'Procedure sp_vendas_cliente criado/alterado.';
GO

-- 2. PROCEDURE: Inserir nova venda
CREATE OR ALTER PROCEDURE sp_inserir_venda
    @ClienteID INT,
    @Produto NVARCHAR(100),
    @Quantidade INT,
    @Valor DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        IF @ClienteID IS NULL OR NOT EXISTS (SELECT 1 FROM Clientes WHERE ClienteID = @ClienteID)
        BEGIN
            RAISERROR('ClienteID inválido.', 16, 1);
            RETURN -1;
        END;
        
        IF @Quantidade <= 0
        BEGIN
            RAISERROR('Quantidade deve ser > 0.', 16, 1);
            RETURN -1;
        END;
        
        IF @Valor <= 0
        BEGIN
            RAISERROR('Valor deve ser > 0.', 16, 1);
            RETURN -1;
        END;
        
        INSERT INTO Vendas (ClienteID, Produto, Quantidade, Valor)
        VALUES (@ClienteID, @Produto, @Quantidade, @Valor);
        
        PRINT 'Venda inserida. ID: ' + CAST(SCOPE_IDENTITY() AS VARCHAR);
        RETURN SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        PRINT 'Erro: ' + @ErrorMessage;
        RETURN -1;
    END CATCH;
END;
GO

PRINT 'Procedure sp_inserir_venda criado/alterado.';
GO

-- 3. PROCEDURE: Estatísticas de cliente
CREATE OR ALTER PROCEDURE sp_estatisticas_cliente
    @ClienteID INT,
    @TotalVendas DECIMAL(10,2) OUTPUT,
    @QuantidadeVendas INT OUTPUT,
    @UltimaVenda DATETIME OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        @TotalVendas = ISNULL(SUM(Valor * Quantidade), 0),
        @QuantidadeVendas = ISNULL(COUNT(*), 0),
        @UltimaVenda = ISNULL(MAX(DataVenda), GETDATE())
    FROM Vendas 
    WHERE ClienteID = @ClienteID;
    
    PRINT 'Estatísticas calculadas para ClienteID: ' + CAST(@ClienteID AS VARCHAR);
END;
GO

PRINT 'Procedure sp_estatisticas_cliente criado/alterado.';
GO

-- 4. PROCEDURE: Buscar cliente
CREATE OR ALTER PROCEDURE sp_buscar_cliente
    @Filtro NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF ISNUMERIC(@Filtro) = 1
    BEGIN
        SELECT * FROM Clientes 
        WHERE ClienteID = CAST(@Filtro AS INT);
        PRINT 'Busca por ID: ' + @Filtro;
    END
    ELSE
    BEGIN
        SELECT * FROM Clientes 
        WHERE Nome LIKE '%' + @Filtro + '%';
        PRINT 'Busca por Nome: ' + @Filtro;
    END
END;
GO

PRINT 'Procedure sp_buscar_cliente criado/alterado.';
GO

PRINT '--- TESTANDO PROCEDURES ---';
GO

-- Testar sp_vendas_cliente
PRINT 'Testando sp_vendas_cliente...';
EXEC sp_vendas_cliente;
EXEC sp_vendas_cliente @ClienteID = 1;
GO

-- Testar sp_inserir_venda
PRINT 'Testando sp_inserir_venda...';
DECLARE @Resultado INT;
EXEC @Resultado = sp_inserir_venda 
    @ClienteID = 2,
    @Produto = 'Tablet',
    @Quantidade = 1,
    @Valor = 450.00;
    
IF @Resultado > 0
    PRINT 'Venda criada com ID: ' + CAST(@Resultado AS VARCHAR);
ELSE
    PRINT 'Falha ao criar venda.';
GO

-- Testar sp_estatisticas_cliente
PRINT 'Testando sp_estatisticas_cliente...';
DECLARE @Total DECIMAL(10,2);
DECLARE @Qtd INT;
DECLARE @Ultima DATETIME;

EXEC sp_estatisticas_cliente 
    @ClienteID = 1,
    @TotalVendas = @Total OUTPUT,
    @QuantidadeVendas = @Qtd OUTPUT,
    @UltimaVenda = @Ultima OUTPUT;

PRINT 'Total: R$ ' + CAST(@Total AS VARCHAR);
PRINT 'Quantidade: ' + CAST(@Qtd AS VARCHAR);
PRINT 'Última Venda: ' + CONVERT(VARCHAR, @Ultima, 103);
GO

-- Testar sp_buscar_cliente
PRINT 'Testando sp_buscar_cliente...';
EXEC sp_buscar_cliente @Filtro = '1';
EXEC sp_buscar_cliente @Filtro = 'João';
GO

PRINT '--- VERIFICAÇÃO FINAL ---';
GO

-- Listar procedures criados
SELECT 
    name AS ProcedureName,
    create_date AS CreateDate,
    modify_date AS ModifyDate
FROM sys.procedures 
WHERE name LIKE 'sp_%'
ORDER BY name;
GO

PRINT '=== SCRIPT CONCLUÍDO COM SUCESSO ===';
PRINT 'Procedures disponíveis:';
PRINT '- sp_vendas_cliente';
PRINT '- sp_inserir_venda';
PRINT '- sp_estatisticas_cliente';
PRINT '- sp_buscar_cliente';
GO