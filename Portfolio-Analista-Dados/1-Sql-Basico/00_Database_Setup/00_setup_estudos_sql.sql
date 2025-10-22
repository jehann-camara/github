-- SQL Basico - CREATE DATABASE e TABELAS
-- Mes 1: Fundamentos
-- SCRIPT FINAL CORRIGIDO

USE master;
GO

-- 1. Remove o database se existir (com tratamento de erro)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'estudos_sql')
BEGIN
    ALTER DATABASE estudos_sql SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE estudos_sql;
    PRINT '[SUCESSO] Database estudos_sql anterior removido';
END

-- 2. Cria o database
CREATE DATABASE estudos_sql;
PRINT '[SUCESSO] Database estudos_sql criado';
GO

-- 3. Usa o database criado
USE estudos_sql;
GO

-- 4. Cria tabela clientes (apenas se nao existir apos criar o database)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'clientes')
BEGIN
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
END

-- 5. Cria tabela produtos
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'produtos')
BEGIN
    CREATE TABLE produtos (
        id INT PRIMARY KEY IDENTITY(1,1),
        nome VARCHAR(100) NOT NULL,
        categoria VARCHAR(50),
        preco_unitario DECIMAL(10,2),
        estoque INT
    );
    PRINT '[SUCESSO] Tabela produtos criada';
END

-- 6. Cria tabela pedidos
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'pedidos')
BEGIN
    CREATE TABLE pedidos (
        id INT PRIMARY KEY IDENTITY(1,1),
        cliente_id INT,
        produto_id INT,
        quantidade INT,
        valor_total DECIMAL(10,2),
        data_pedido DATE,
        FOREIGN KEY (cliente_id) REFERENCES clientes(id),
        FOREIGN KEY (produto_id) REFERENCES produtos(id)
    );
    PRINT '[SUCESSO] Tabela pedidos criada';
END

-- 7. Cria tabela users
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'users')
BEGIN
    --CREATE TABLE users (
    --    id INT PRIMARY KEY IDENTITY(1,1),
    --    nome varchar(100)        
    --);
    CREATE TABLE users (
        id INT PRIMARY KEY IDENTITY(1,1),
        nome varchar(100) UNIQUE NOT NULL        
    );
    PRINT '[SUCESSO] Tabela users criada';
END

-- ==========================================
-- INSERINDO DADOS DE EXEMPLO
-- ==========================================

-- Limpa dados existentes antes de inserir
DELETE FROM pedidos;
DELETE FROM produtos;
DELETE FROM clientes;
DELETE FROM users;

-- Limpar os dados com truncate
TRUNCATE TABLE users

-- Insere clientes
INSERT INTO clientes (nome, email, idade, cidade, data_cadastro) VALUES
('Ana Silva', 'ana.silva@email.com', 28, 'Sao Paulo', '2024-01-15'),
('Carlos Oliveira', 'carlos.oliveira@email.com', 35, 'Rio de Janeiro', '2024-01-20'),
('Marina Santos', 'marina.santos@email.com', 22, 'Belo Horizonte', '2024-02-01'),
('Joao Pereira', 'joao.pereira@email.com', 42, 'Sao Paulo', '2024-02-10'),
('Juliana Costa', 'juliana.costa@email.com', 29, 'Curitiba', '2024-02-15'),
('Ricardo Alves', 'ricardo.alves@email.com', 31, 'Porto Alegre', '2024-02-20');
PRINT '[SUCESSO] Dados de clientes inseridos';

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
('Fone Bluetooth', 'Audio', 199.90, 30);
PRINT '[SUCESSO] Dados de produtos inseridos';

-- Insere pedidos
INSERT INTO pedidos (cliente_id, produto_id, quantidade, valor_total, data_pedido) VALUES
(1, 1, 1, 2500.00, '2024-02-01'),
(1, 2, 2, 179.80, '2024-02-02'),
(2, 3, 1, 299.90, '2024-02-03'),
(3, 4, 1, 899.00, '2024-02-05'),
(4, 5, 1, 650.00, '2024-02-08'),
(5, 6, 1, 1200.00, '2024-02-10'),
(2, 7, 1, 159.90, '2024-02-12'),
(3, 8, 1, 1500.00, '2024-02-15'),
(1, 9, 1, 199.90, '2024-02-18');
PRINT '[SUCESSO] Dados de pedidos inseridos';

-- Alter table COM NOT NULL
ALTER TABLE users add email varchar (100) NOT NULL;

-- Alterar tabela com Unique para email
ALTER TABLE users ADD CONSTRAINT unique_tb_users UNIQUE (email)

-- A constraint unique_tb_users não permite email duplicado
INSERT INTO users (nome, email) VALUES
('Jehann', 'exemploemail@gmail.com'),
('João', 'exemploemail@hotmail.com'),
('Maria', 'exemploemail@kmail.com'),
('José', 'exemploemail@yahoo.com'),
('Joãozinho', 'exemploemail@outlook.com');
PRINT '[SUCESSO] Dados de users inseridos';

-- Verificacao final
PRINT '=== VERIFICACAO FINAL ===';
SELECT 
    (SELECT COUNT(*) FROM clientes) AS total_clientes,
    (SELECT COUNT(*) FROM produtos) AS total_produtos,
    (SELECT COUNT(*) FROM pedidos) AS total_pedidos,
     (SELECT COUNT(*) FROM users) AS total_users;
     (SELECT * FROM users)

     --EXEC sp_help users -- ou atalho alt + f1 clicando no nome da tabela 

PRINT '[FIM] Script executado com sucesso!';