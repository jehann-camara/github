-- SCRIPT UNICO - SETUP COMPLETO DATABASE ESTUDOS_SQL
-- Mes 1: Fundamentos
-- PADRAO: Compatibilidade Windows - Setup completo em um script

USE master;
GO

-- Remove database existente se necessario
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'estudos_sql')
BEGIN
    ALTER DATABASE estudos_sql SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE estudos_sql;
    PRINT '[INFO] Database estudos_sql anterior removido';
END

-- Cria database
CREATE DATABASE estudos_sql;
PRINT '[SUCESSO] Database estudos_sql criado';
GO

USE estudos_sql;
GO

-- ==========================================
-- 1. CRIACAO DAS TABELAS
-- ==========================================

-- Tabela clientes
CREATE TABLE clientes (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    idade INT,
    cidade VARCHAR(50),
    data_cadastro DATE,
    ativo BIT DEFAULT 1
);
PRINT '[SUCESSO] Tabela clientes criada';

-- Tabela produtos
CREATE TABLE produtos (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    preco_unitario DECIMAL(10,2),
    estoque INT,
    data_cadastro DATE DEFAULT GETDATE()
);
PRINT '[SUCESSO] Tabela produtos criada';

-- Tabela pedidos
CREATE TABLE pedidos (
    id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT,
    produto_id INT,
    quantidade INT,
    valor_total DECIMAL(10,2),
    data_pedido DATE,
    status VARCHAR(20) DEFAULT 'Pendente',
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);
PRINT '[SUCESSO] Tabela pedidos criada';

-- Tabela vendas (para exemplos de JOINs)
CREATE TABLE vendas (
    id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT,
    produto_id INT,
    quantidade INT,
    data_venda DATE,
    valor_unitario DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);
PRINT '[SUCESSO] Tabela vendas criada';

-- ==========================================
-- 2. POPULACAO COM DADOS DE EXEMPLO
-- ==========================================

-- Insere clientes
INSERT INTO clientes (nome, email, idade, cidade, data_cadastro) VALUES
('Ana Silva', 'ana.silva@email.com', 28, 'Sao Paulo', '2024-01-15'),
('Carlos Oliveira', 'carlos.oliveira@email.com', 35, 'Rio de Janeiro', '2024-01-20'),
('Marina Santos', 'marina.santos@email.com', 22, 'Belo Horizonte', '2024-02-01'),
('Joao Pereira', 'joao.pereira@email.com', 42, 'Sao Paulo', '2024-02-10'),
('Juliana Costa', 'juliana.costa@email.com', 29, 'Curitiba', '2024-02-15'),
('Ricardo Alves', 'ricardo.alves@email.com', 31, 'Porto Alegre', '2024-02-20'),
('Fernanda Lima', 'fernanda.lima@email.com', 26, 'Sao Paulo', '2024-02-25'),
('Pedro Martins', 'pedro.martins@email.com', 38, 'Rio de Janeiro', '2024-03-01');
PRINT '[SUCESSO] 8 clientes inseridos';

-- Insere produtos
INSERT INTO produtos (nome, categoria, preco_unitario, estoque) VALUES
('Notebook Dell', 'Informatica', 2500.00, 10),
('Mouse Wireless', 'Informatica', 89.90, 25),
('Teclado Mecanico', 'Informatica', 299.90, 15),
('Monitor 24 pol', 'Informatica', 899.00, 8),
('Impressora Laser', 'Informatica', 650.00, 5),
('Tablet Samsung', 'Informatica', 1200.00, 12),
('Webcam HD', 'Informatica', 159.90, 20),
('Smartphone Android', 'Telefonia', 1500.00, 15),
('Fone Bluetooth', 'Audio', 199.90, 30),
('SSD 500GB', 'Armazenamento', 299.90, 18);
PRINT '[SUCESSO] 10 produtos inseridos';

-- Insere pedidos
INSERT INTO pedidos (cliente_id, produto_id, quantidade, valor_total, data_pedido, status) VALUES
(1, 1, 1, 2500.00, '2024-02-01', 'Entregue'),
(1, 2, 2, 179.80, '2024-02-02', 'Entregue'),
(2, 3, 1, 299.90, '2024-02-03', 'Entregue'),
(3, 4, 1, 899.00, '2024-02-05', 'Processando'),
(4, 5, 1, 650.00, '2024-02-08', 'Entregue'),
(5, 6, 1, 1200.00, '2024-02-10', 'Entregue'),
(2, 7, 1, 159.90, '2024-02-12', 'Cancelado'),
(3, 8, 1, 1500.00, '2024-02-15', 'Entregue'),
(1, 9, 1, 199.90, '2024-02-18', 'Entregue'),
(6, 10, 2, 599.80, '2024-02-20', 'Processando'),
(4, 2, 1, 89.90, '2024-02-22', 'Entregue'),
(7, 3, 1, 299.90, '2024-02-25', 'Pendente');
PRINT '[SUCESSO] 12 pedidos inseridos';

-- Insere vendas
INSERT INTO vendas (cliente_id, produto_id, quantidade, data_venda, valor_unitario) VALUES
(1, 1, 1, '2024-02-01', 2500.00),
(1, 2, 2, '2024-02-01', 89.90),
(2, 3, 1, '2024-02-02', 299.90),
(3, 4, 1, '2024-02-03', 899.00),
(4, 5, 1, '2024-02-04', 650.00),
(2, 2, 1, '2024-02-05', 89.90),
(5, 1, 1, '2024-02-06', 2500.00),
(6, 7, 3, '2024-02-07', 159.90),
(7, 8, 1, '2024-02-08', 1500.00),
(8, 9, 2, '2024-02-09', 199.90);
PRINT '[SUCESSO] 10 vendas inseridas';

-- ==========================================
-- 3. VERIFICACAO FINAL
-- ==========================================

PRINT '=== VERIFICACAO FINAL DO SETUP ===';

-- Contagem de registros
SELECT 
    (SELECT COUNT(*) FROM clientes) AS total_clientes,
    (SELECT COUNT(*) FROM produtos) AS total_produtos,
    (SELECT COUNT(*) FROM pedidos) AS total_pedidos,
    (SELECT COUNT(*) FROM vendas) AS total_vendas;

-- Resumo financeiro
SELECT 
    SUM(valor_total) AS valor_total_pedidos,
    SUM(v.quantidade * valor_unitario) AS valor_total_vendas,
    AVG(valor_total) AS valor_medio_pedido
FROM pedidos p
FULL OUTER JOIN vendas v ON p.cliente_id = v.cliente_id AND p.produto_id = v.produto_id;

-- Clientes por cidade
SELECT 
    cidade,
    COUNT(*) AS total_clientes
FROM clientes
GROUP BY cidade
ORDER BY total_clientes DESC;

PRINT '[FIM] Setup completo do database estudos_sql concluido com sucesso!';