
/*
Autor: Jehann Câmara
Módulo: Views, Triggers e Funções (SQL Intermediário)
Compatibilidade: SQL Server (T-SQL). Observações para PostgreSQL em comentários.

Pré-requisitos:
- Mesmas tabelas do módulo anterior (cte_window_examples.sql): Categorias, Produtos, Clientes, Vendas.
- Caso ainda não possua, rode o setup desse arquivo primeiro.

Sumário:
1) VIEWS
   1.1) View de agregação por categoria
   1.2) View de fato de vendas (camada para BI)
   1.3) View de segurança (ocultando colunas sensíveis)
2) TRIGGERS
   2.1) AFTER INSERT/UPDATE/DELETE para log de alterações
   2.2) INSTEAD OF UPDATE em VIEW (validação de negócio)
   2.3) DDL TRIGGER para auditar criação/alteração de objetos
3) FUNÇÕES (UDF)
   3.1) Escalar: ticket médio por cliente
   3.2) Inline table-valued: vendas por mês (para gráficos)
   3.3) Multi-statement table-valued: Top N produtos por categoria
4) EXERCÍCIOS PROPOSTOS
*/

/* =============================================================
=                           1) VIEWS                           =
============================================================= */

USE estudos_analista_dados

-- 1.1) View de agregação por categoria
IF OBJECT_ID('dbo.vw_TotalVendasPorCategoria', 'V') IS NOT NULL
    DROP VIEW dbo.vw_TotalVendasPorCategoria;
GO
CREATE VIEW dbo.vw_TotalVendasPorCategoria
AS
SELECT 
    c.Nome AS Categoria,
    SUM(v.Valor) AS TotalVendas
FROM dbo.Vendas v
JOIN dbo.Produtos p ON p.ID_Produto = v.ID_Produto
JOIN dbo.Categorias c ON c.ID_Categoria = p.ID_Categoria
GROUP BY c.Nome;
GO

-- Teste:
-- SELECT * FROM dbo.vw_TotalVendasPorCategoria ORDER BY TotalVendas DESC;


-- 1.2) View de fato de vendas (camada pronta para BI)
IF OBJECT_ID('dbo.vw_FatoVendas', 'V') IS NOT NULL
    DROP VIEW dbo.vw_FatoVendas;
GO
CREATE VIEW dbo.vw_FatoVendas
AS
SELECT
    v.ID_Venda,
    v.DataVenda,
    v.ID_Cliente,
    cli.Nome     AS Cliente,
    cli.Regiao   AS Regiao,
    v.ID_Produto,
    p.Nome       AS Produto,
    p.ID_Categoria,
    cat.Nome     AS Categoria,
    v.Quantidade,
    v.Valor
FROM dbo.Vendas v
JOIN dbo.Clientes   cli ON cli.ID_Cliente   = v.ID_Cliente
JOIN dbo.Produtos   p   ON p.ID_Produto     = v.ID_Produto
JOIN dbo.Categorias cat ON cat.ID_Categoria = p.ID_Categoria;
GO

-- Teste:
-- SELECT TOP (50) * FROM dbo.vw_FatoVendas ORDER BY DataVenda DESC;


-- 1.3) View de segurança (ocultando colunas sensíveis)
IF OBJECT_ID('dbo.vw_ClientesPublico', 'V') IS NOT NULL
    DROP VIEW dbo.vw_ClientesPublico;
GO
CREATE VIEW dbo.vw_ClientesPublico
AS
SELECT ID_Cliente, Nome, Regiao
FROM dbo.Clientes;
GO

-- Teste:
-- SELECT * FROM dbo.vw_ClientesPublico;


/* =============================================================
=                          2) TRIGGERS                         =
============================================================= */

-- 2.0) Tabela de log para auditoria de vendas
IF OBJECT_ID('dbo.Log_Vendas', 'U') IS NOT NULL
    DROP TABLE dbo.Log_Vendas;
GO
CREATE TABLE dbo.Log_Vendas (
    ID_Log     INT IDENTITY(1,1) PRIMARY KEY,
    ID_Venda   INT NULL,
    Acao       NVARCHAR(20) NOT NULL,
    DataLog    DATETIME     NOT NULL DEFAULT(GETDATE())
);
GO

-- 2.1) AFTER INSERT/UPDATE/DELETE: registra alterações na tabela Vendas
IF OBJECT_ID('dbo.trg_LogVendas_AUDIT', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_LogVendas_AUDIT;
GO
CREATE TRIGGER dbo.trg_LogVendas_AUDIT
ON dbo.Vendas
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted)
        INSERT INTO dbo.Log_Vendas (ID_Venda, Acao)
        SELECT ID_Venda, 'INSERT/UPDATE' FROM inserted;

    IF EXISTS (SELECT 1 FROM deleted)
        INSERT INTO dbo.Log_Vendas (ID_Venda, Acao)
        SELECT ID_Venda, 'DELETE' FROM deleted;
END;
GO

-- 2.2) INSTEAD OF UPDATE em VIEW: validação de regra
IF OBJECT_ID('dbo.trg_vwClientesPublico_InsteadOfUpdate', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_vwClientesPublico_InsteadOfUpdate;
GO
CREATE TRIGGER dbo.trg_vwClientesPublico_InsteadOfUpdate
ON dbo.vw_ClientesPublico
INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(Regiao)
    BEGIN
        RAISERROR('Atualizacao de Regiao nao permitida via vw_ClientesPublico. Use a tabela base dbo.Clientes.', 16, 1);
        RETURN;
    END

    UPDATE c
       SET c.Nome = i.Nome
    FROM dbo.Clientes c
    JOIN inserted i ON i.ID_Cliente = c.ID_Cliente;
END;
GO

-- 2.3) DDL TRIGGER: auditar criação/alteração de objetos
IF OBJECT_ID('dbo.Log_DDL', 'U') IS NOT NULL
    DROP TABLE dbo.Log_DDL;
GO
CREATE TABLE dbo.Log_DDL (
    ID_Log   INT IDENTITY(1,1) PRIMARY KEY,
    Evento   NVARCHAR(200),
    Objeto   NVARCHAR(200),
    DataLog  DATETIME DEFAULT GETDATE()
);
GO

IF OBJECT_ID('trg_DDL_AUDIT', 'TR') IS NOT NULL
    DROP TRIGGER trg_DDL_AUDIT ON DATABASE;
GO
CREATE TRIGGER trg_DDL_AUDIT
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE, CREATE_PROCEDURE, ALTER_PROCEDURE, DROP_PROCEDURE, CREATE_VIEW, ALTER_VIEW, DROP_VIEW
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @event XML = EVENTDATA();
    INSERT INTO dbo.Log_DDL (Evento, Objeto)
    SELECT 
        @event.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(200)'),
        @event.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(200)');
END;
GO


/* =============================================================
=                          3) FUNÇÕES                          =
============================================================= */

-- 3.1) Função Escalar: ticket médio por cliente
IF OBJECT_ID('dbo.fn_TicketMedioCliente', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_TicketMedioCliente;
GO
CREATE FUNCTION dbo.fn_TicketMedioCliente(@ID_Cliente INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Ticket DECIMAL(10,2);
    SELECT @Ticket = AVG(v.Valor)
    FROM dbo.Vendas v
    WHERE v.ID_Cliente = @ID_Cliente;
    RETURN @Ticket;
END;
GO

-- 3.2) Inline Table-Valued Function: vendas por mês (para gráficos)
IF OBJECT_ID('dbo.fn_VendasPorMes', 'IF') IS NOT NULL
    DROP FUNCTION dbo.fn_VendasPorMes;
GO
CREATE FUNCTION dbo.fn_VendasPorMes(@Ano INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        MONTH(DataVenda) AS Mes,
        SUM(Valor)       AS TotalVendas,
        COUNT(*)         AS QtdVendas
    FROM dbo.Vendas
    WHERE YEAR(DataVenda) = @Ano
    GROUP BY MONTH(DataVenda)
);
GO

-- 3.3) Multi-Statement Table-Valued Function: Top N produtos por categoria
IF OBJECT_ID('dbo.fn_TopN_ProdutosPorCategoria', 'TF') IS NOT NULL
    DROP FUNCTION dbo.fn_TopN_ProdutosPorCategoria;
GO
CREATE FUNCTION dbo.fn_TopN_ProdutosPorCategoria(@TopN INT)
RETURNS @tabela TABLE (
    Categoria   NVARCHAR(100),
    Produto     NVARCHAR(150),
    Faturamento DECIMAL(18,2),
    Posicao     INT
)
AS
BEGIN
    ;WITH FaturamentoProduto AS (
        SELECT
            cat.Nome AS Categoria,
            p.Nome   AS Produto,
            SUM(v.Valor) AS Faturamento
        FROM dbo.Vendas v
        JOIN dbo.Produtos p   ON p.ID_Produto     = v.ID_Produto
        JOIN dbo.Categorias cat ON cat.ID_Categoria = p.ID_Categoria
        GROUP BY cat.Nome, p.Nome
    ),
    RankPorCategoria AS (
        SELECT
            Categoria,
            Produto,
            Faturamento,
            ROW_NUMBER() OVER (PARTITION BY Categoria ORDER BY Faturamento DESC) AS rn
        FROM FaturamentoProduto
    )
    INSERT INTO @tabela (Categoria, Produto, Faturamento, Posicao)
    SELECT Categoria, Produto, Faturamento, rn
    FROM RankPorCategoria
    WHERE rn <= @TopN;

    RETURN;
END;
GO


/* =============================================================
=                     4) EXERCÍCIOS PROPOSTOS                  =
============================================================= */

-- EX 1) Crie uma VIEW chamada vw_ClientesAtivosComVendas
--      que liste clientes com pelo menos 1 venda no último ano.
--      Dica: use EXISTS ou JOIN com Vendas filtrando por DataVenda.

-- EX 2) Crie um TRIGGER AFTER INSERT em Clientes que registre
--      a criação de novos clientes em uma tabela de log (Log_Clientes).

-- EX 3) Crie uma FUNCTION escalar fn_TotalGastoCliente(@ID_Cliente INT)
--      que retorne o total (SUM Valor) gasto por um cliente.

-- EX 4) Crie uma FUNCTION inline fn_VendasPorCategoria(@Ano INT)
--      que retorne Categoria, TotalVendas e QtdVendas por ano.

-- EX 5) (Desafio) Crie uma VIEW vw_KPI_Mensal com:
--      Ano, Mes, TotalVendas, QtdVendas, TicketMedio (Total/Qtd).
--      Dica: reutilize fn_VendasPorMes e/ou agregue diretamente de Vendas.


