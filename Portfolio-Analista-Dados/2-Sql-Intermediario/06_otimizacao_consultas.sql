-- 09 - OTIMIZAÇÃO DE CONSULTAS
-- Modulo: 02_sql_server_avancado
-- Pre-requisito: 08_triggers_auditoria.sql

USE RoadmapEngenhariaDados;
GO

PRINT '=== OTIMIZAÇÃO DE CONSULTAS ==='

-- 1. CRIAR ÍNDICES
PRINT '1. Criando índices...'
GO

-- Índice na chave estrangeira
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_vendas_cliente')
    CREATE INDEX idx_vendas_cliente ON vendas(cliente_id);
GO

-- Índice na data
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_vendas_data')
    CREATE INDEX idx_vendas_data ON vendas(data_venda);
GO

-- Índice composto
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_vendas_cliente_data')
    CREATE INDEX idx_vendas_cliente_data ON vendas(cliente_id, data_venda);
GO

PRINT 'Índices criados!'

-- 2. CONSULTAS OTIMIZADAS
PRINT '2. Consultas otimizadas...'

GO

-- Consulta usando índice
SELECT 
    c.nome,
    COUNT(v.venda_id) as total_vendas
FROM clientes c
JOIN vendas v ON c.cliente_id = v.cliente_id
WHERE v.data_venda BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY c.nome;

-- Consulta com filtro em coluna indexada
SELECT *
FROM vendas
WHERE cliente_id = 1 AND data_venda >= '2024-01-01';

-- 3. ANALISE DE PERFORMANCE
PRINT '3. Analisando performance...'

-- Ver estatísticas simples
PRINT 'Estatísticas das tabelas:'
SELECT 
    t.name as tabela,
    p.rows as registros
FROM sys.tables t
JOIN sys.partitions p ON t.object_id = p.object_id
WHERE t.name IN ('clientes', 'produtos', 'vendas')
    AND p.index_id IN (0,1);
GO

PRINT '=== OTIMIZAÇÃO CONCLUIDA ==='