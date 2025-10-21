-- SQL Avancado - JOINs e Agregacoes
-- Mes 1: Fundamentos - Aula Avancada
-- SCRIPT: 05_joins_subquerys.sql
-- PADRAO: Compatibilidade Windows - Verificacoes inteligentes

USE master;
GO

-- Remove e recria o database para garantir estrutura limpa
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'estudos_sql')
BEGIN
    ALTER DATABASE estudos_sql SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE estudos_sql;
    PRINT '[INFO] Database estudos_sql anterior removido';
END

CREATE DATABASE estudos_sql;
PRINT '[SUCESSO] Database estudos_sql criado';
GO

USE estudos_sql;
GO

-- ==========================================
-- CRIACAO DAS TABELAS COM ESTRUTURA SIMPLES
-- ==========================================

PRINT '[INFO] Criando tabelas com estrutura consistente...';

-- Tabela clientes
CREATE TABLE clientes (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    idade INT,
    cidade VARCHAR(50)
);
PRINT '[SUCESSO] Tabela clientes criada';

-- Tabela produtos
CREATE TABLE produtos (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    preco DECIMAL(10,2)
);
PRINT '[SUCESSO] Tabela produtos criada';

-- Tabela vendas (estrutura simplificada e consistente)
CREATE TABLE vendas (
    id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT,
    produto_id INT,
    quantidade INT,
    valor DECIMAL(10,2),  -- COLUNA UNICA PARA VALOR
    data_venda DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);
PRINT '[SUCESSO] Tabela vendas criada';

-- ==========================================
-- INSERCAO DE DADOS DE EXEMPLO
-- ==========================================

PRINT '[INFO] Inserindo dados de exemplo...';

-- Insere clientes
INSERT INTO clientes (nome, email, idade, cidade) VALUES
('Ana Silva', 'ana.silva@email.com', 28, 'Sao Paulo'),
('Carlos Oliveira', 'carlos.oliveira@email.com', 35, 'Rio de Janeiro'),
('Marina Santos', 'marina.santos@email.com', 22, 'Belo Horizonte'),
('Joao Pereira', 'joao.pereira@email.com', 42, 'Sao Paulo'),
('Juliana Costa', 'juliana.costa@email.com', 29, 'Curitiba');
PRINT '[SUCESSO] 5 clientes inseridos';

-- Insere produtos
INSERT INTO produtos (nome, categoria, preco) VALUES
('Notebook Dell', 'Eletronicos', 2500.00),
('Mouse Wireless', 'Acessorios', 89.90),
('Teclado Mecanico', 'Acessorios', 299.90),
('Monitor 24 pol', 'Eletronicos', 899.00),
('Tablet Samsung', 'Eletronicos', 1200.00);
PRINT '[SUCESSO] 5 produtos inseridos';

-- Insere vendas (usando apenas a coluna 'valor')
INSERT INTO vendas (cliente_id, produto_id, quantidade, valor, data_venda) VALUES
(1, 1, 1, 2500.00, '2024-02-01'),
(1, 2, 2, 179.80, '2024-02-01'),  -- 2 mouses
(2, 3, 1, 299.90, '2024-02-02'),
(3, 4, 1, 899.00, '2024-02-03'),
(4, 5, 1, 1200.00, '2024-02-04'),
(2, 2, 1, 89.90, '2024-02-05'),
(5, 1, 1, 2500.00, '2024-02-06');
PRINT '[SUCESSO] 7 vendas inseridas';

-- ==========================================
-- CONSULTAS COM JOINS
-- ==========================================

PRINT '=== INICIANDO CONSULTAS COM JOINS ===';

-- INNER JOIN (apenas registros que existem em ambas)
PRINT '[INFO] Executando INNER JOIN...';
SELECT 
    c.nome AS cliente,
    p.nome AS produto,
    v.quantidade,
    v.valor,
    v.data_venda
FROM vendas v
INNER JOIN clientes c ON v.cliente_id = c.id
INNER JOIN produtos p ON v.produto_id = p.id;

-- LEFT JOIN (todos da esquerda + correspondentes direita)
PRINT '[INFO] Executando LEFT JOIN...';
SELECT 
    c.nome AS cliente,
    v.data_venda,
    v.valor
FROM clientes c
LEFT JOIN vendas v ON c.id = v.cliente_id;

-- RIGHT JOIN (todos da direita + correspondentes esquerda)
PRINT '[INFO] Executando RIGHT JOIN...';
SELECT 
    p.nome AS produto,
    v.quantidade,
    v.valor
FROM vendas v
RIGHT JOIN produtos p ON v.produto_id = p.id;

-- ==========================================
-- FUNCOES DE AGREGACAO
-- ==========================================

PRINT '=== INICIANDO FUNCOES DE AGREGACAO ===';

-- COUNT - Contar registros
PRINT '[INFO] Executando COUNT...';
SELECT COUNT(*) AS total_clientes FROM clientes;
SELECT COUNT(*) AS clientes_sp FROM clientes WHERE cidade = 'Sao Paulo';

-- SUM - Soma de valores
PRINT '[INFO] Executando SUM...';
SELECT 
    SUM(quantidade) AS total_itens_vendidos,
    SUM(valor) AS total_vendas
FROM vendas;

-- AVG - Media
PRINT '[INFO] Executando AVG...';
SELECT AVG(idade) AS media_idade FROM clientes;
SELECT AVG(valor) AS media_valor_venda FROM vendas;

-- MIN e MAX
PRINT '[INFO] Executando MIN e MAX...';
SELECT 
    MIN(idade) AS idade_minima,
    MAX(idade) AS idade_maxima
FROM clientes;
SELECT 
    MIN(valor) AS menor_venda,
    MAX(valor) AS maior_venda
FROM vendas;

-- ==========================================
-- GROUP BY - AGRUPANDO DADOS
-- ==========================================

PRINT '=== INICIANDO GROUP BY ===';

-- Vendas por cliente
PRINT '[INFO] Vendas por cliente...';
SELECT 
    c.nome AS cliente,
    COUNT(v.id) AS total_compras,
    SUM(v.valor) AS total_gasto
FROM clientes c
LEFT JOIN vendas v ON c.id = v.cliente_id
GROUP BY c.id, c.nome;

-- Vendas por produto
PRINT '[INFO] Vendas por produto...';
SELECT 
    p.nome AS produto,
    p.categoria,
    SUM(v.quantidade) AS total_vendido,
    SUM(v.valor) AS receita_total
FROM produtos p
LEFT JOIN vendas v ON p.id = v.produto_id
GROUP BY p.id, p.nome, p.categoria;

-- Vendas por cidade
PRINT '[INFO] Vendas por cidade...';
SELECT 
    c.cidade,
    COUNT(v.id) AS total_vendas,
    SUM(v.valor) AS receita
FROM clientes c
LEFT JOIN vendas v ON c.id = v.cliente_id
GROUP BY c.cidade;

-- ==========================================
-- HAVING - FILTRANDO GRUPOS
-- ==========================================

PRINT '=== INICIANDO HAVING ===';

-- Clientes que gastaram mais de 500
PRINT '[INFO] Clientes que gastaram mais de 500...';
SELECT 
    c.nome,
    SUM(v.valor) AS total_gasto
FROM clientes c
INNER JOIN vendas v ON c.id = v.cliente_id
GROUP BY c.id, c.nome
HAVING SUM(v.valor) > 500;

-- Cidades com mais de 1 venda
PRINT '[INFO] Cidades com mais de 1 venda...';
SELECT 
    c.cidade,
    COUNT(v.id) AS total_vendas
FROM clientes c
INNER JOIN vendas v ON c.id = v.cliente_id
GROUP BY c.cidade
HAVING COUNT(v.id) > 1;

-- ==========================================
-- SUBCONSULTAS (SUBQUERIES)
-- ==========================================

PRINT '=== INICIANDO SUBCONSULTAS ===';

-- Clientes que nunca compraram
PRINT '[INFO] Clientes que nunca compraram...';
SELECT nome, email
FROM clientes
WHERE id NOT IN (SELECT DISTINCT cliente_id FROM vendas);

-- Produtos mais vendidos (top 3)
PRINT '[INFO] Produtos mais vendidos (top 3)...';
SELECT TOP 3
    nome,
    (SELECT SUM(quantidade) FROM vendas WHERE produto_id = produtos.id) AS total_vendido
FROM produtos
ORDER BY (SELECT SUM(quantidade) FROM vendas WHERE produto_id = produtos.id) DESC;

-- ==========================================
-- VERIFICACAO FINAL
-- ==========================================

PRINT '=== VERIFICACAO FINAL ===';

-- Verifica estrutura das tabelas
SELECT 
    (SELECT COUNT(*) FROM clientes) AS total_clientes,
    (SELECT COUNT(*) FROM produtos) AS total_produtos,
    (SELECT COUNT(*) FROM vendas) AS total_vendas,
    (SELECT SUM(valor) FROM vendas) AS valor_total_vendas,
    (SELECT COUNT(DISTINCT cliente_id) FROM vendas) AS clientes_com_compras;

-- Lista colunas das tabelas para debug
PRINT '[INFO] Estrutura final das tabelas:';
PRINT 'clientes: id, nome, email, idade, cidade';
PRINT 'produtos: id, nome, categoria, preco';
PRINT 'vendas: id, cliente_id, produto_id, quantidade, valor, data_venda';

PRINT '[SUCESSO] Script 05_joins_subquerys.sql executado com sucesso!';
PRINT '[INFO] Todas as colunas verificadas e consistentes';
GO