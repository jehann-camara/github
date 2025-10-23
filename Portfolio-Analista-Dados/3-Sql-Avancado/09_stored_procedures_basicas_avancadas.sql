
/*
Autor: Jehann Câmara
Tema: SQL Intermediário — Stored Procedures (com CTE e Window Functions)
Compatibilidade: SQL Server (T-SQL). Observações para PostgreSQL em comentários.

Pré-requisitos:
- Este arquivo assume as tabelas do ambiente criadas no arquivo 'cte_window_examples.sql':
  Categorias, Produtos, Clientes, Regioes, Vendas.
  Se ainda não criou, execute o setup daquele arquivo primeiro.
*/

/* =============================================================
=         BOAS PRÁTICAS GERAIS PARA PROCEDURES (T-SQL)         =
============================================================= */
/*
- Use SET NOCOUNT ON para reduzir mensagens "N rows affected".
- Prefira parâmetros com nomes claros e tipos compatíveis com as colunas.
- Em parâmetros opcionais, use NULL como padrão e trate com '(@p IS NULL OR coluna = @p)'.
- Centralize regras de negócio e análises repetidas em procedures reutilizáveis.
- Para consultas analíticas maiores, combine CTEs + Window Functions dentro da procedure.
- Controle de segurança: conceda EXECUTE ao papel/usuário apropriado em vez de permissões diretas nas tabelas.
*/

/* =============================================================
=  PROCEDURE 1 — ListarClientes (exemplo básico sem parâmetros) =
============================================================= */

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

IF OBJECT_ID('dbo.ListarClientes', 'P') IS NOT NULL
    DROP PROCEDURE dbo.ListarClientes;
GO
CREATE PROCEDURE dbo.ListarClientes
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ID_Cliente, Nome, Regiao
    FROM dbo.Clientes
    ORDER BY Nome;
END;
GO

/* Execução:
EXEC dbo.ListarClientes;
*/

/* =============================================================
=  PROCEDURE 2 — TotalVendasPorCliente (com parâmetro simples)  =
============================================================= */
IF OBJECT_ID('dbo.TotalVendasPorCliente', 'P') IS NOT NULL
    DROP PROCEDURE dbo.TotalVendasPorCliente;
GO
CREATE PROCEDURE dbo.TotalVendasPorCliente
    @ID_Cliente INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.Nome AS Cliente,
        SUM(v.Valor) AS TotalVendas,
        COUNT(*) AS QtdVendas
    FROM dbo.Vendas v
    JOIN dbo.Clientes c ON c.ID_Cliente = v.ID_Cliente
    WHERE v.ID_Cliente = @ID_Cliente
    GROUP BY c.Nome;
END;
GO

/* Execução:
EXEC dbo.TotalVendasPorCliente @ID_Cliente = 3;
*/

/* =====================================================================
=  PROCEDURE 3 — RelatorioVendas (parâmetros opcionais com filtros)     =
===================================================================== */
IF OBJECT_ID('dbo.RelatorioVendas', 'P') IS NOT NULL
    DROP PROCEDURE dbo.RelatorioVendas;
GO
CREATE PROCEDURE dbo.RelatorioVendas
    @DataInicio DATE = NULL,
    @DataFim DATE = NULL,
    @Categoria NVARCHAR(100) = NULL,
    @Regiao NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        cat.Nome AS Categoria,
        cli.Regiao,
        SUM(v.Valor) AS Total,
        COUNT(*) AS QtdVendas
    FROM dbo.Vendas v
    JOIN dbo.Produtos p   ON p.ID_Produto   = v.ID_Produto
    JOIN dbo.Categorias cat ON cat.ID_Categoria = p.ID_Categoria
    JOIN dbo.Clientes cli ON cli.ID_Cliente = v.ID_Cliente
    WHERE
        (@DataInicio IS NULL OR v.DataVenda >= @DataInicio)
        AND (@DataFim IS NULL OR v.DataVenda <= @DataFim)
        AND (@Categoria IS NULL OR cat.Nome = @Categoria)
        AND (@Regiao IS NULL OR cli.Regiao = @Regiao)
    GROUP BY cat.Nome, cli.Regiao
    ORDER BY Total DESC;
END;
GO

/* Execução (exemplos):
EXEC dbo.RelatorioVendas;
EXEC dbo.RelatorioVendas @DataInicio='2025-01-01', @DataFim='2025-03-31';
EXEC dbo.RelatorioVendas @Categoria='Eletrônicos';
EXEC dbo.RelatorioVendas @Regiao='Nordeste', @Categoria='Livros';
*/

/* ===================================================================================
=  PROCEDURE 4 — RankingClientesMensal (CTE + Window Functions para ranking mensal)  =
=================================================================================== */
IF OBJECT_ID('dbo.RankingClientesMensal', 'P') IS NOT NULL
    DROP PROCEDURE dbo.RankingClientesMensal;
GO
CREATE PROCEDURE dbo.RankingClientesMensal
    @Mes INT,
    @Ano INT,
    @TopN INT = NULL -- se informado, retorna apenas os Top N
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH VendasMes AS (
        SELECT 
            v.ID_Cliente,
            SUM(v.Valor) AS Total
        FROM dbo.Vendas v
        WHERE MONTH(v.DataVenda) = @Mes
          AND YEAR(v.DataVenda)  = @Ano
        GROUP BY v.ID_Cliente
    ),
    Ranking AS (
        SELECT
            vm.ID_Cliente,
            vm.Total,
            RANK() OVER (ORDER BY vm.Total DESC) AS Posicao
        FROM VendasMes vm
    )
    SELECT TOP (CASE WHEN @TopN IS NULL THEN 2147483647 ELSE @TopN END)
        r.Posicao,
        c.Nome AS Cliente,
        r.Total
    FROM Ranking r
    JOIN dbo.Clientes c ON c.ID_Cliente = r.ID_Cliente
    ORDER BY r.Posicao ASC, r.Total DESC;
END;
GO

/* Execução (exemplos):
EXEC dbo.RankingClientesMensal @Mes=9, @Ano=2025;
EXEC dbo.RankingClientesMensal @Mes=9, @Ano=2025, @TopN=5;
*/

/* ========================================================================================
=  PROCEDURE 5 — ContarVendasCliente (parâmetro de saída / OUTPUT parameter)              =
======================================================================================== */
IF OBJECT_ID('dbo.ContarVendasCliente', 'P') IS NOT NULL
    DROP PROCEDURE dbo.ContarVendasCliente;
GO
CREATE PROCEDURE dbo.ContarVendasCliente
    @ID_Cliente INT,
    @QtdVendas INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT @QtdVendas = COUNT(*) 
    FROM dbo.Vendas 
    WHERE ID_Cliente = @ID_Cliente;
END;
GO

/* Execução com OUTPUT:
DECLARE @q INT;
EXEC dbo.ContarVendasCliente @ID_Cliente = 3, @QtdVendas = @q OUTPUT;
SELECT @q AS TotalVendasDoCliente3;
*/

/* =============================================================
=                EXTRAS — ALTER / DROP / Segurança             =
============================================================= */
/*
-- Atualizar uma procedure:
ALTER PROCEDURE dbo.ListarClientes
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ID_Cliente, Nome, Regiao
    FROM dbo.Clientes
    WHERE Regiao <> 'Centro-Oeste' -- Exemplo de filtro
    ORDER BY Nome;
END;

-- Excluir:
DROP PROCEDURE dbo.ListarClientes;

-- Conceder permissão de execução (exemplo para usuário 'analistaBI'):
GRANT EXECUTE ON dbo.RelatorioVendas TO analistaBI;
*/
