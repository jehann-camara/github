
/*
Autor: Jehann Câmara
Projeto: Formação Analista de Dados Júnior
Tema: SQL Intermediário — CTE e Funções Janela (Window Functions)
Compatibilidade: SQL Server (T-SQL). Notas para PostgreSQL incluídas em comentários.

Como usar:
1) Execute a seção "SETUP DO AMBIENTE" para criar as tabelas e dados fictícios.
2) Em seguida, rode cada exercício. Cada um inclui:
   - Objetivo
   - Query modelo (com comentários didáticos)
   - Sugestões de variação

Notas de compatibilidade:
- SQL Server usa TOP; PostgreSQL usa LIMIT.
- Para datas, GETDATE() (SQL Server) ↔ CURRENT_DATE (Postgres).
- CONCAT em SQL Server pode usar + quando NVARCHAR; aqui usaremos CONCAT() por clareza.
- Para Postgres, remova [dbo]. e troque tipos NVARCHAR por VARCHAR se desejar.
*/

/*==============================================================
=            SETUP DO AMBIENTE (Database, Tabelas e Dados)               =
==============================================================*/

-- Configurar ambiente
IF DB_ID('estudos_analista_dados') IS NULL
BEGIN
    CREATE DATABASE estudos_analista_dados;
    PRINT 'Banco de dados estudos_analista_dados criado.';
END
ELSE
BEGIN
    PRINT 'Banco de dados estudos_analista_dados já existe.';
END
GO

USE estudos_analista_dados;
GO

IF OBJECT_ID('dbo.Vendas', 'U') IS NOT NULL DROP TABLE dbo.Vendas;
IF OBJECT_ID('dbo.Produtos', 'U') IS NOT NULL DROP TABLE dbo.Produtos;
IF OBJECT_ID('dbo.Clientes', 'U') IS NOT NULL DROP TABLE dbo.Clientes;
IF OBJECT_ID('dbo.Categorias', 'U') IS NOT NULL DROP TABLE dbo.Categorias;
IF OBJECT_ID('dbo.Regioes', 'U') IS NOT NULL DROP TABLE dbo.Regioes;

CREATE TABLE dbo.Categorias (
    ID_Categoria INT IDENTITY(1,1) PRIMARY KEY,
    Nome NVARCHAR(100) NOT NULL
);

CREATE TABLE dbo.Produtos (
    ID_Produto INT IDENTITY(1,1) PRIMARY KEY,
    Nome NVARCHAR(150) NOT NULL,
    ID_Categoria INT NOT NULL,
    Preco DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Produtos_Categorias FOREIGN KEY (ID_Categoria) REFERENCES dbo.Categorias(ID_Categoria)
);

CREATE TABLE dbo.Clientes (
    ID_Cliente INT IDENTITY(1,1) PRIMARY KEY,
    Nome NVARCHAR(150) NOT NULL,
    Regiao NVARCHAR(50) NOT NULL
);

CREATE TABLE dbo.Regioes (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Nome NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE dbo.Vendas (
    ID_Venda INT IDENTITY(1,1) PRIMARY KEY,
    ID_Cliente INT NOT NULL,
    ID_Produto INT NOT NULL,
    Quantidade INT NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    DataVenda DATE NOT NULL,
    CONSTRAINT FK_Vendas_Clientes FOREIGN KEY (ID_Cliente) REFERENCES dbo.Clientes(ID_Cliente),
    CONSTRAINT FK_Vendas_Produtos FOREIGN KEY (ID_Produto) REFERENCES dbo.Produtos(ID_Produto)
);

/*------------------------------
-- Inserção de dados de exemplo
------------------------------*/
INSERT INTO dbo.Categorias (Nome) VALUES
(N'Eletrônicos'), (N'Livros'), (N'Casa'), (N'Roupas');

INSERT INTO dbo.Produtos (Nome, ID_Categoria, Preco) VALUES
(N'Smartphone A', 1, 1500.00),
(N'Notebook B', 1, 3500.00),
(N'Fone C', 1, 200.00),
(N'Livro SQL', 2, 80.00),
(N'Livro Python', 2, 120.00),
(N'Panela X', 3, 220.00),
(N'Cafeteira Y', 3, 450.00),
(N'Camiseta Z', 4, 60.00),
(N'Jaqueta W', 4, 300.00);

INSERT INTO dbo.Regioes (Nome) VALUES (N'Nordeste'), (N'Sudeste'), (N'Sul'), (N'Centro-Oeste'), (N'Norte');
/* NOTA: A tabela Regioes existe apenas para referência demonstrativa. */

INSERT INTO dbo.Clientes (Nome, Regiao) VALUES
(N'Ana', N'Nordeste'),
(N'Bruno', N'Sudeste'),
(N'Carla', N'Sul'),
(N'Diego', N'Norte'),
(N'Elisa', N'Sudeste'),
(N'Fabio', N'Centro-Oeste'),
(N'Gabi', N'Nordeste'),
(N'Henrique', N'Norte');

/* Vendas — 12 meses de dados simples e variados */
;WITH d AS (
    SELECT CAST(DATEADD(DAY, v.n, DATEFROMPARTS(YEAR(GETDATE())-1, 10, 1)) AS DATE) AS dt
    FROM (SELECT TOP (365) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n
          FROM sys.all_objects) v
)
INSERT INTO dbo.Vendas (ID_Cliente, ID_Produto, Quantidade, Valor, DataVenda)
SELECT
    (ABS(CHECKSUM(NEWID())) % 8) + 1 AS ID_Cliente,
    (ABS(CHECKSUM(NEWID())) % 9) + 1 AS ID_Produto,
    (ABS(CHECKSUM(NEWID())) % 5) + 1 AS Quantidade,
    /* Valor aproximado = Preco * Quantidade com variação */
    CAST(((ABS(CHECKSUM(NEWID())) % 100)/100.0 + 0.75) * p.Preco * ((ABS(CHECKSUM(NEWID())) % 5) + 1) AS DECIMAL(10,2)) AS Valor,
    dt AS DataVenda
FROM d
CROSS APPLY (SELECT TOP 1 * FROM dbo.Produtos ORDER BY NEWID()) p;

/* Índices simples para melhorar algumas consultas */
CREATE INDEX IX_Vendas_DataVenda ON dbo.Vendas (DataVenda);
CREATE INDEX IX_Vendas_Cliente ON dbo.Vendas (ID_Cliente);
CREATE INDEX IX_Vendas_Produto ON dbo.Vendas (ID_Produto);

/*==============================================================
=            EXERCÍCIOS DE CTE E WINDOW FUNCTIONS              =
==============================================================*/

/*--------------------------------------------------------------
EXERCÍCIO 1 — CTE de agregação por categoria
Objetivo: Somar o total de vendas por categoria usando CTE.
--------------------------------------------------------------*/
WITH VendasPorCategoria AS (
    SELECT
        p.ID_Categoria,
        c.Nome AS Categoria,
        SUM(v.Valor) AS TotalCategoria
    FROM dbo.Vendas v
    JOIN dbo.Produtos p ON p.ID_Produto = v.ID_Produto
    JOIN dbo.Categorias c ON c.ID_Categoria = p.ID_Categoria
    GROUP BY p.ID_Categoria, c.Nome
)
SELECT *
FROM VendasPorCategoria
ORDER BY TotalCategoria DESC;
/* Variação: filtrar categorias com TotalCategoria > 100000. */


/*--------------------------------------------------------------
EXERCÍCIO 2 — Múltiplas CTEs em etapas
Objetivo: Calcular o total por cliente e filtrar "alta receita".
--------------------------------------------------------------*/
WITH TotaisPorCliente AS (
    SELECT ID_Cliente, SUM(Valor) AS TotalCliente
    FROM dbo.Vendas
    GROUP BY ID_Cliente
),
ClientesAltaReceita AS (
    SELECT ID_Cliente, TotalCliente
    FROM TotaisPorCliente
    WHERE TotalCliente > 200000
)
SELECT c.Nome, car.TotalCliente
FROM ClientesAltaReceita car
JOIN dbo.Clientes c ON c.ID_Cliente = car.ID_Cliente
ORDER BY car.TotalCliente DESC;
/* Variação: mude o threshold e adicione a coluna Regiao. */


/*--------------------------------------------------------------
EXERCÍCIO 3 — ROW_NUMBER por categoria (Top N por grupo)
Objetivo: Selecionar os Top 3 produtos por faturamento dentro de cada categoria.
--------------------------------------------------------------*/
WITH FaturamentoProduto AS (
    SELECT
        p.ID_Produto,
        p.Nome AS Produto,
        p.ID_Categoria,
        c.Nome AS Categoria,
        SUM(v.Valor) AS Faturamento
    FROM dbo.Vendas v
    JOIN dbo.Produtos p ON p.ID_Produto = v.ID_Produto
    JOIN dbo.Categorias c ON c.ID_Categoria = p.ID_Categoria
    GROUP BY p.ID_Produto, p.Nome, p.ID_Categoria, c.Nome
),
RankPorCategoria AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY ID_Categoria ORDER BY Faturamento DESC) AS rn
    FROM FaturamentoProduto
)
SELECT Categoria, Produto, Faturamento, rn
FROM RankPorCategoria
WHERE rn <= 3
ORDER BY Categoria, rn;
/* Variação: use RANK() para permitir empates. */


/*--------------------------------------------------------------
EXERCÍCIO 4 — SUM OVER com PARTITION (totais lado a lado)
Objetivo: Exibir cada venda e o total de vendas da sua categoria na mesma linha.
--------------------------------------------------------------*/
SELECT
    v.ID_Venda,
    c.Nome AS Categoria,
    p.Nome AS Produto,
    v.Valor,
    SUM(v.Valor) OVER (PARTITION BY c.ID_Categoria) AS TotalCategoria
FROM dbo.Vendas v
JOIN dbo.Produtos p ON p.ID_Produto = v.ID_Produto
JOIN dbo.Categorias c ON c.ID_Categoria = p.ID_Categoria
ORDER BY c.Nome, v.ID_Venda;
/* Variação: adicionar COUNT(*) OVER (PARTITION BY Categoria). */


/*--------------------------------------------------------------
EXERCÍCIO 5 — Running total (acumulado) por cliente
Objetivo: Calcular o total acumulado de vendas por cliente ao longo do tempo.
--------------------------------------------------------------*/
WITH VendasCliente AS (
    SELECT
        v.ID_Cliente,
        v.DataVenda,
        v.Valor
    FROM dbo.Vendas v
)
SELECT
    vc.ID_Cliente,
    cl.Nome AS Cliente,
    vc.DataVenda,
    vc.Valor,
    SUM(vc.Valor) OVER (
        PARTITION BY vc.ID_Cliente
        ORDER BY vc.DataVenda
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS AcumuladoCliente
FROM VendasCliente vc
JOIN dbo.Clientes cl ON cl.ID_Cliente = vc.ID_Cliente
ORDER BY vc.ID_Cliente, vc.DataVenda;
/* Variação: reiniciar o acumulado por mês usando PARTITION por (ID_Cliente, YEAR(DataVenda), MONTH(DataVenda)). */


/*--------------------------------------------------------------
EXERCÍCIO 6 — Média móvel de 7 dias
Objetivo: Suavizar a série temporal com média móvel.
--------------------------------------------------------------*/
WITH Serie AS (
    SELECT
        DataVenda,
        SUM(Valor) AS ValorDia
    FROM dbo.Vendas
    GROUP BY DataVenda
)
SELECT
    DataVenda,
    ValorDia,
    AVG(ValorDia) OVER (
        ORDER BY DataVenda
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS MediaMovel7d
FROM Serie
ORDER BY DataVenda;
/* Variação: tente janelas de 3, 14 e 30 dias. */


/*--------------------------------------------------------------
EXERCÍCIO 7 — LAG / LEAD (comparação temporal)
Objetivo: Comparar o valor do dia com o dia anterior e calcular variação %.
--------------------------------------------------------------*/
WITH Serie AS (
    SELECT
        DataVenda,
        SUM(Valor) AS ValorDia
    FROM dbo.Vendas
    GROUP BY DataVenda
)
SELECT
    DataVenda,
    ValorDia,
    LAG(ValorDia) OVER (ORDER BY DataVenda) AS ValorAnterior,
    CAST(
        CASE 
            WHEN LAG(ValorDia) OVER (ORDER BY DataVenda) = 0 THEN NULL
            ELSE (ValorDia - LAG(ValorDia) OVER (ORDER BY DataVenda)) * 100.0 
                 / NULLIF(LAG(ValorDia) OVER (ORDER BY DataVenda), 0)
        END
    AS DECIMAL(10,2)) AS VariacaoPercentual
FROM Serie
ORDER BY DataVenda;
/* Variação: substitua LAG por LEAD para comparar com o próximo dia. */


/*--------------------------------------------------------------
EXERCÍCIO 8 — NTILE (quartis de clientes por faturamento)
Objetivo: Segmentar clientes em 4 faixas (quartis) de acordo com o total gasto.
--------------------------------------------------------------*/
WITH Totais AS (
    SELECT ID_Cliente, SUM(Valor) AS TotalCliente
    FROM dbo.Vendas
    GROUP BY ID_Cliente
)
SELECT
    c.Nome AS Cliente,
    t.TotalCliente,
    NTILE(4) OVER (ORDER BY t.TotalCliente) AS Quartil
FROM Totais t
JOIN dbo.Clientes c ON c.ID_Cliente = t.ID_Cliente
ORDER BY Quartil, TotalCliente;
/* Variação: usar NTILE(10) para decílios ou NTILE(5) para quintis. */


/*--------------------------------------------------------------
EXERCÍCIO 9 — Mínima data de compra com MIN OVER
Objetivo: Mostrar a primeira compra de cada cliente ao lado de cada venda.
--------------------------------------------------------------*/
SELECT
    v.ID_Cliente,
    c.Nome AS Cliente,
    v.DataVenda,
    v.Valor,
    MIN(v.DataVenda) OVER (PARTITION BY v.ID_Cliente) AS PrimeiraCompra
FROM dbo.Vendas v
JOIN dbo.Clientes c ON c.ID_Cliente = v.ID_Cliente
ORDER BY v.ID_Cliente, v.DataVenda;
/* Variação: calcule também dias desde a primeira compra: DATEDIFF(DAY, PrimeiraCompra, DataVenda). */


/*--------------------------------------------------------------
EXERCÍCIO 10 — CTE Recursiva (gerar calendário mensal)
Objetivo: Construir uma tabela de meses dos últimos 12 meses e juntar à série de vendas.
--------------------------------------------------------------*/
;WITH Meses AS (
    SELECT CAST(DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) AS DATE) AS InicioMes, 1 AS n
    UNION ALL
    SELECT DATEADD(MONTH, -1, InicioMes), n + 1
    FROM Meses
    WHERE n < 12
),
VendasMensais AS (
    SELECT
        CAST(DATEFROMPARTS(YEAR(DataVenda), MONTH(DataVenda), 1) AS DATE) AS InicioMes,
        SUM(Valor) AS TotalMes
    FROM dbo.Vendas
    GROUP BY CAST(DATEFROMPARTS(YEAR(DataVenda), MONTH(DataVenda), 1) AS DATE)
)
SELECT
    m.InicioMes,
    ISNULL(vm.TotalMes, 0) AS TotalMes
FROM Meses m
LEFT JOIN VendasMensais vm ON vm.InicioMes = m.InicioMes
ORDER BY m.InicioMes DESC
OPTION (MAXRECURSION 100);
/* Variação: troque 12 por 24 para 2 anos. Em Postgres, use generate_series(). */

-- Fim do arquivo.
