-- 08 - TRIGGERS E AUDITORIA
-- Modulo: 02_sql_server_avancado
-- Pre-requisito: 07_stored_procedures.sql

USE RoadmapEngenhariaDados;
GO

PRINT '=== TRIGGERS E AUDITORIA ==='

-- 1. CRIAR TABELA DE AUDITORIA
PRINT '1. Criando tabela de auditoria...'

IF OBJECT_ID('auditoria_vendas', 'U') IS NOT NULL
    DROP TABLE auditoria_vendas;
GO

CREATE TABLE auditoria_vendas (
    id INT IDENTITY PRIMARY KEY,
    venda_id INT,
    acao VARCHAR(10),
    data_acao DATETIME,
    usuario VARCHAR(100)
);
GO

-- 2. TRIGGER PARA INSERT
PRINT '2. Trigger para INSERT...'

IF OBJECT_ID('tr_auditoria_insert', 'TR') IS NOT NULL
    DROP TRIGGER tr_auditoria_insert;
GO

CREATE TRIGGER tr_auditoria_insert
ON vendas
AFTER INSERT
AS
BEGIN
    INSERT INTO auditoria_vendas (venda_id, acao, data_acao, usuario)
    SELECT venda_id, 'INSERT', GETDATE(), SYSTEM_USER
    FROM inserted;
    
    PRINT 'Trigger de INSERT executada!';
END;
GO

-- 3. TRIGGER PARA UPDATE
PRINT '3. Trigger para UPDATE...'

IF OBJECT_ID('tr_auditoria_update', 'TR') IS NOT NULL
    DROP TRIGGER tr_auditoria_update;

GO

CREATE TRIGGER tr_auditoria_update
ON vendas
AFTER UPDATE
AS
BEGIN
    INSERT INTO auditoria_vendas (venda_id, acao, data_acao, usuario)
    SELECT venda_id, 'UPDATE', GETDATE(), SYSTEM_USER
    FROM inserted;
    
    PRINT 'Trigger de UPDATE executada!';
END;
GO

-- 4. TESTAR TRIGGERS
PRINT '4. Testando triggers...'
GO

-- Teste INSERT (deve acionar trigger)
INSERT INTO vendas VALUES (7, 3, 3, '2024-01-20', 2, 400.00);
GO

-- Teste UPDATE (deve acionar trigger)
UPDATE vendas SET valor_total = 600.00 WHERE venda_id = 5;
GO
-- Verificar auditoria
PRINT 'Registros de auditoria:'
SELECT * FROM auditoria_vendas;

PRINT '=== TRIGGERS CONCLUIDAS ==='