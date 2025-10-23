
## Resumo Sql Básico ( Views, Triggers e Funções SQL ) : // By Jehann Câmara
## Objetivo: aprender a criar camadas de abstração reutilizáveis e automação de eventos no banco.

## Views (Visões SQL):
    Uma View é uma consulta armazenada no banco de dados, que se comporta como uma tabela virtual.
    Ela não guarda dados fisicamente (salvo se for materializada), mas mostra dados prontos de consultas complexas.
    Um “atalho para consultas” ou uma “camada de apresentação” — muito útil em projetos de BI e Data Analytics.

    Exemplo:

        CREATE VIEW vw_TotalVendasPorCategoria AS
        SELECT 
            c.Nome AS Categoria,
            SUM(v.Valor) AS TotalVendas
        FROM Vendas v
        JOIN Produtos p ON v.ID_Produto = p.ID_Produto
        JOIN Categorias c ON c.ID_Categoria = p.ID_Categoria
        GROUP BY c.Nome;

    Depois de criada, você pode consultar como se fosse uma tabela:

        SELECT * FROM vw_TotalVendasPorCategoria;
    
    *As views não armazenam dados, portanto refletem sempre os dados atuais da tabela base.*

## Triggers (Gatilhos SQL):
    Um Trigger é um evento automático que dispara uma ação quando ocorre uma modificação em uma tabela (INSERT, UPDATE, DELETE).
    É como um sensor que detecta mudanças no banco e reage automaticamente — útil para auditorias, logs ou cálculos automáticos.

    Exemplo: registrar log de alterações em vendas:

            CREATE TABLE Log_Vendas (
                ID_Log INT IDENTITY(1,1) PRIMARY KEY,
                ID_Venda INT,
                Acao NVARCHAR(20),
                DataLog DATETIME DEFAULT GETDATE()
            );
    
    Agora criamos o gatilho:

        CREATE TRIGGER trg_LogAlteracoesVendas
            ON Vendas
            AFTER INSERT, UPDATE, DELETE
            AS
            BEGIN
                SET NOCOUNT ON;

                IF EXISTS (SELECT * FROM inserted)
                    INSERT INTO Log_Vendas (ID_Venda, Acao)
                    SELECT ID_Venda, 'INSERT/UPDATE' FROM inserted;

                IF EXISTS (SELECT * FROM deleted)
                    INSERT INTO Log_Vendas (ID_Venda, Acao)
                    SELECT ID_Venda, 'DELETE' FROM deleted;
            END;

## Tipos de Triggers:
    AFTER : Executa depois do evento (mais comum)
    INSTEAD OF: Substitui o comportamento padrão do evento
    DDL Trigger : Executa após comandos DDL (CREATE, ALTER, DROP) — usado para auditoria de schema

## Funções SQL (User-Defined Functions – UDFs):
    Uma função definida pelo usuário (UDF) é um bloco de código SQL que retorna um valor único ou uma tabela, podendo ser reutilizado em consultas.

    Tipos de Funções:
        Escalar: Retorna Um único valor.
        Inline Table-Valued:Retorna Uma tabela derivada de um SELECT.
        Multi-Statement Table-Valued: Retorna uma Tabela construída passo a passo.

    Exemplo Função Escalar:

        CREATE FUNCTION fn_TicketMedioCliente(@ID_Cliente INT)
            RETURNS DECIMAL(10,2)
            AS
            BEGIN
                DECLARE @TicketMedio DECIMAL(10,2);
    
                SELECT @TicketMedio = AVG(Valor)
                FROM Vendas
                WHERE ID_Cliente = @ID_Cliente;

                RETURN @TicketMedio;
            END;
        
    Uso:
        SELECT Nome, dbo.fn_TicketMedioCliente(ID_Cliente) AS TicketMedio
        FROM Clientes;

    Exemplo Função Inline (tabela):
        CREATE FUNCTION fn_VendasPorMes(@Ano INT)
            RETURNS TABLE
            AS
            RETURN
            (
                SELECT 
                    MONTH(DataVenda) AS Mes,
                    SUM(Valor) AS TotalVendas
                FROM Vendas
                WHERE YEAR(DataVenda) = @Ano
                GROUP BY MONTH(DataVenda)
            );
    Uso:
        SELECT * FROM dbo.fn_VendasPorMes(2025);




