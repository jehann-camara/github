-- 06 - CONSULTAS AVANÇADAS BASICAS
-- Modulo: 02_sql_server_avancado

USE RoadmapEngenhariaDados;
GO

PRINT '=== CONSULTAS AVANÇADAS ==='

-- 1. CRIAR TABELAS SIMPLES
PRINT '1. Criando tabelas...'

IF OBJECT_ID('vendas', 'U') IS NOT NULL
    DROP TABLE vendas;

IF OBJECT_ID('clientes', 'U') IS NOT NULL
    DROP TABLE clientes;

IF OBJECT_ID('produtos', 'U') IS NOT NULL
    DROP TABLE produtos;

-- Tabela clientes
CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(50)
);

-- Tabela produtos
CREATE TABLE produtos (
    produto_id INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2)
);

-- Tabela vendas
CREATE TABLE vendas (
    venda_id INT PRIMARY KEY,
    cliente_id INT,
    produto_id INT,
    data_venda DATE,
    quantidade INT,
    valor_total DECIMAL(10,2)
);

-- 2. INSERIR DADOS
PRINT '2. Inserindo dados...'

INSERT INTO clientes VALUES 
(1, 'João Silva', 'São Paulo'),
(2, 'Maria Santos', 'Rio de Janeiro'),
(3, 'Pedro Oliveira', 'Belo Horizonte');

INSERT INTO produtos VALUES
(1, 'Notebook', 2500.00),
(2, 'Mouse', 80.00),
(3, 'Teclado', 200.00);

INSERT INTO vendas VALUES
(1, 1, 1, '2024-01-15', 1, 2500.00),
(2, 1, 2, '2024-01-16', 2, 160.00),
(3, 2, 3, '2024-01-17', 1, 200.00),
(4, 3, 1, '2024-01-18', 1, 2500.00);

PRINT 'Dados inseridos!'

-- 3. CONSULTAS COM JUNÇÕES
PRINT '3. Consultas com junções...'

-- JOIN simples
SELECT 
    v.venda_id,
    c.nome as cliente,
    p.nome as produto,
    v.data_venda,
    v.valor_total
FROM vendas v
JOIN clientes c ON v.cliente_id = c.cliente_id
JOIN produtos p ON v.produto_id = p.produto_id;

-- LEFT JOIN
SELECT 
    c.nome,
    COUNT(v.venda_id) as total_vendas
FROM clientes c
LEFT JOIN vendas v ON c.cliente_id = v.cliente_id
GROUP BY c.nome;

-- 4. SUBCONSULTAS BASICAS
PRINT '4. Subconsultas...'

-- Subconsulta WHERE
SELECT nome
FROM clientes
WHERE cliente_id IN (
    SELECT cliente_id 
    FROM vendas 
    WHERE valor_total > 1000
);

-- Subconsulta FROM
SELECT 
    cliente,
    total_gasto
FROM (
    SELECT 
        c.nome as cliente,
        SUM(v.valor_total) as total_gasto
    FROM clientes c
    JOIN vendas v ON c.cliente_id = v.cliente_id
    GROUP BY c.nome
) as resumo;

-- 5. CTE SIMPLES
PRINT '5. CTE...';

WITH vendas_cliente AS (
    SELECT 
        c.nome,
        COUNT(v.venda_id) as qtd_vendas
    FROM clientes c
    LEFT JOIN vendas v ON c.cliente_id = v.cliente_id
    GROUP BY c.nome
)
SELECT * FROM vendas_cliente;

PRINT '=== CONSULTAS CONCLUIDAS ==='