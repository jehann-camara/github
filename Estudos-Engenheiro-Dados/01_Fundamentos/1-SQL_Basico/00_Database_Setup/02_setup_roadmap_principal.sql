-- SCRIPT 02 - SETUP PRINCIPAL DATABASE RoadmapEngenhariaDados
-- SEGUNDO script a ser executado - Database completo para Meses 2-7
-- PADRAO: Compatibilidade Windows - Setup completo

PRINT '==========================================';
PRINT 'INICIANDO SETUP ROADMAP PRINCIPAL (02/03)';
PRINT '==========================================';

USE master;
GO

-- 1. REMOVER DATABASE EXISTENTE (SE HOUVER)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'RoadmapEngenhariaDados')
BEGIN
    PRINT '[INFO] Removendo database RoadmapEngenhariaDados existente...';
    ALTER DATABASE RoadmapEngenhariaDados SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RoadmapEngenhariaDados;
    PRINT '[SUCESSO] Database anterior removido';
END
ELSE
BEGIN
    PRINT '[INFO] Nenhum database RoadmapEngenhariaDados encontrado. Criando novo...';
END
GO

-- 2. CRIAR NOVO DATABASE
PRINT '[INFO] Criando database RoadmapEngenhariaDados...';
CREATE DATABASE RoadmapEngenhariaDados;
GO

PRINT '[INFO] Configurando database RoadmapEngenhariaDados...';
USE RoadmapEngenhariaDados;
GO

-- 3. CRIAR SCHEMAS
PRINT '[INFO] Criando schemas...';
GO
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
CREATE SCHEMA util;
GO

-- 4. CRIAR TABELAS BRONZE (DADOS BRUTOS)
PRINT '[INFO] Criando tabelas bronze layer...';
GO

CREATE TABLE bronze.clientes (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    idade INT,
    cidade VARCHAR(50),
    estado CHAR(2),
    data_cadastro DATE DEFAULT GETDATE(),
    ativo BIT DEFAULT 1,
    data_criacao DATETIME2 DEFAULT GETDATE()
);
GO

CREATE TABLE bronze.produtos (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    subcategoria VARCHAR(50),
    preco_custo DECIMAL(10,2),
    preco_venda DECIMAL(10,2),
    estoque INT DEFAULT 0,
    data_criacao DATETIME2 DEFAULT GETDATE()
);
GO

CREATE TABLE bronze.vendas (
    id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2),
    valor_total DECIMAL(10,2),
    data_venda DATE NOT NULL,
    canal_venda VARCHAR(20),
    data_criacao DATETIME2 DEFAULT GETDATE(),
    CONSTRAINT fk_vendas_cliente FOREIGN KEY (cliente_id) REFERENCES bronze.clientes(id),
    CONSTRAINT fk_vendas_produto FOREIGN KEY (produto_id) REFERENCES bronze.produtos(id)
);
GO

-- 5. CRIAR TABELAS UTIL (LOGS E PARAMETROS)
PRINT '[INFO] Criando tabelas utilitarias...';
GO

CREATE TABLE util.processamento_logs (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    processo VARCHAR(100) NOT NULL,
    descricao VARCHAR(500),
    status VARCHAR(20) NOT NULL,
    linhas_processadas INT,
    data_inicio DATETIME2 NOT NULL,
    data_fim DATETIME2,
    duracao_segundos AS DATEDIFF(SECOND, data_inicio, ISNULL(data_fim, GETDATE())),
    erro_mensagem VARCHAR(1000)
);
GO

CREATE TABLE util.parametros_sistema (
    id INT PRIMARY KEY IDENTITY(1,1),
    chave VARCHAR(50) UNIQUE NOT NULL,
    valor VARCHAR(500),
    descricao VARCHAR(200),
    data_atualizacao DATETIME2 DEFAULT GETDATE()
);
GO

-- 6. CRIAR TABELAS GOLD (MODELO DIMENSIONAL)
PRINT '[INFO] Criando tabelas gold layer...';
GO

CREATE TABLE gold.dim_clientes (
    cliente_key INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    idade INT,
    faixa_etaria VARCHAR(20),
    cidade VARCHAR(50),
    estado CHAR(2),
    data_cadastro DATE,
    cliente_ativo BIT,
    data_carregamento DATETIME2 DEFAULT GETDATE()
);
GO

CREATE TABLE gold.dim_produtos (
    produto_key INT PRIMARY KEY IDENTITY(1,1),
    produto_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    subcategoria VARCHAR(50),
    preco_venda DECIMAL(10,2),
    data_carregamento DATETIME2 DEFAULT GETDATE()
);
GO

CREATE TABLE gold.dim_tempo (
    data_key INT PRIMARY KEY,
    data_completa DATE NOT NULL,
    dia INT,
    mes INT,
    ano INT,
    trimestre INT,
    nome_mes VARCHAR(20),
    nome_dia_semana VARCHAR(20),
    fim_de_semana BIT,
    feriado BIT DEFAULT 0
);
GO

CREATE TABLE gold.fato_vendas (
    venda_key BIGINT PRIMARY KEY IDENTITY(1,1),
    cliente_key INT NOT NULL,
    produto_key INT NOT NULL,
    data_key INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    data_venda DATE NOT NULL,
    data_carregamento DATETIME2 DEFAULT GETDATE()
);
GO

-- 7. INSERIR DADOS BRONZE
PRINT '[INFO] Inserindo dados bronze layer...';
GO

INSERT INTO bronze.clientes (nome, email, idade, cidade, estado) VALUES
('Ana Silva', 'ana.silva@email.com', 28, 'Sao Paulo', 'SP'),
('Carlos Oliveira', 'carlos.oliveira@email.com', 35, 'Rio de Janeiro', 'RJ'),
('Marina Santos', 'marina.santos@email.com', 22, 'Belo Horizonte', 'MG');
GO

INSERT INTO bronze.produtos (nome, categoria, subcategoria, preco_custo, preco_venda) VALUES
('Notebook Dell i5', 'Eletronicos', 'Computadores', 2000.00, 2500.00),
('Mouse Wireless', 'Acessorios', 'Perifericos', 50.00, 89.90),
('Teclado Mecanico', 'Acessorios', 'Perifericos', 150.00, 299.90);
GO

INSERT INTO bronze.vendas (cliente_id, produto_id, quantidade, valor_unitario, valor_total, data_venda, canal_venda) VALUES
(1, 1, 1, 2500.00, 2500.00, '2024-02-01', 'Online'),
(1, 2, 2, 89.90, 179.80, '2024-02-01', 'Online'),
(2, 3, 1, 299.90, 299.90, '2024-02-02', 'Loja Fisica');
GO

-- 8. INSERIR DADOS DIMENSIONAIS
PRINT '[INFO] Inserindo dados dimensionais...';
GO

INSERT INTO gold.dim_tempo (data_key, data_completa, dia, mes, ano, trimestre, nome_mes, nome_dia_semana, fim_de_semana) VALUES
(20240201, '2024-02-01', 1, 2, 2024, 1, 'Fevereiro', 'Quinta-feira', 0),
(20240202, '2024-02-02', 2, 2, 2024, 1, 'Fevereiro', 'Sexta-feira', 0);
GO

INSERT INTO util.parametros_sistema (chave, valor, descricao) VALUES
('EMAIL_NOTIFICACAO', 'admin@empresa.com', 'Email para notificacoes'),
('DIAS_RETENCAO_LOGS', '30', 'Dias para manter logs');
GO

-- 9. CRIAR VIEWS SILVER
PRINT '[INFO] Criando views silver layer...';
GO

CREATE VIEW silver.vw_vendas_detalhadas AS
SELECT 
    v.id as venda_id,
    c.nome as cliente_nome,
    c.cidade as cliente_cidade,
    p.nome as produto_nome,
    p.categoria as produto_categoria,
    v.quantidade,
    v.valor_unitario,
    v.valor_total,
    v.data_venda,
    v.canal_venda
FROM bronze.vendas v
INNER JOIN bronze.clientes c ON v.cliente_id = c.id
INNER JOIN bronze.produtos p ON v.produto_id = p.id;
GO

-- 10. CRIAR STORED PROCEDURES
PRINT '[INFO] Criando stored procedures...';
GO

CREATE PROCEDURE util.usp_registrar_log
    @processo VARCHAR(100),
    @descricao VARCHAR(500) = NULL,
    @status VARCHAR(20) = 'SUCESSO',
    @linhas_processadas INT = NULL,
    @erro_mensagem VARCHAR(1000) = NULL
AS
BEGIN
    INSERT INTO util.processamento_logs (processo, descricao, status, linhas_processadas, data_inicio, data_fim, erro_mensagem)
    VALUES (@processo, @descricao, @status, @linhas_processadas, GETDATE(), GETDATE(), @erro_mensagem);
END;
GO

-- 11. VERIFICACAO FINAL
PRINT '[INFO] Realizando verificacao final...';
GO

SELECT 
    (SELECT COUNT(*) FROM bronze.clientes) AS total_clientes_bronze,
    (SELECT COUNT(*) FROM bronze.produtos) AS total_produtos_bronze,
    (SELECT COUNT(*) FROM bronze.vendas) AS total_vendas_bronze,
    (SELECT COUNT(*) FROM gold.dim_tempo) AS total_datas_gold;
GO

PRINT '==========================================';
PRINT '[SUCESSO] SETUP ROADMAP PRINCIPAL CONCLUIDO (02/03)';
PRINT '==========================================';
PRINT 'RESUMO:';
PRINT '   • Database: RoadmapEngenhariaDados';
PRINT '   • Schemas: 4 (bronze, silver, gold, util)';
PRINT '   • Tabelas: 10 tabelas criadas';
PRINT '   • Views: 1 view silver layer';
PRINT '   • Procedures: 1 procedure utilitaria';
PRINT '';
PRINT 'PROXIMO: Execute 03_verificar_setup_completo.sql';
PRINT '==========================================';
GO