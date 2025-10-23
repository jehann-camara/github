## Resumo Sql básico-Intermediário // By Jehann Câmara

## Resumo Sql Básico
    SELECT * Escolhe e calcula as colunas do resultado *
    FROM * Lê as tabelas base *
    JOIN * Combina tabelas conforme as condições *
    WHERE * Filtra linhas individuais (antes de agrupamento) *
    GROUP BY * Agrupa as linhas em conjuntos *
    HAVING * Filtra grupos após o agrupamento *
    ORDER BY * Ordena o resultado final *
    LIMIT / TOP * Restringe o número de linhas mostradas * 

## Exemplo Prático (SQL Intermediário com JOIN + CTE + Função Janela)
    WITH VendasMensais AS (
        SELECT
            V.ClienteID,
            C.Nome,
            V.Mes,
            SUM(V.Valor) AS TotalMes
        FROM Vendas V
        JOIN Clientes C ON C.ID = V.ClienteID
        WHERE V.Ano = 2024
        GROUP BY V.ClienteID, C.Nome, V.Mes
    )
    SELECT
        Nome,
        Mes,
        TotalMes,
        AVG(TotalMes) OVER (PARTITION BY Nome) AS MediaCliente,
        RANK() OVER (PARTITION BY Mes ORDER BY TotalMes DESC) AS Posicao
    FROM VendasMensais
    WHERE TotalMes > 500
    ORDER BY Mes, Posicao;

## Ordem de Execução + Funções Janela
## As funções janela (OVER()) não substituem o GROUP BY, mas são calculadas depois que os dados são lidos, e antes do ORDER BY final.
    FROM → WHERE → GROUP BY → HAVING → WINDOW FUNCTIONS → SELECT → ORDER BY
## Exemplo:
    SELECT 
        Vendedor,
        Mes,
        SUM(Valor) OVER (PARTITION BY Vendedor) AS TotalVendedor,
        RANK() OVER (ORDER BY SUM(Valor) DESC) AS Posicao
    FROM Vendas;


## Resumo Visual Final:
    (1) FROM            → de onde vem os dados
    (2) JOIN             → combina tabelas
    (3) WHERE            → filtra linhas
    (4) GROUP BY         → agrupa registros
    (5) HAVING           → filtra grupos
    (6) WINDOW FUNCTIONS → cálculos analíticos linha a linha
    (7) SELECT           → escolhe colunas / cálculos
    (8) ORDER BY         → ordena resultados
    (9) LIMIT / TOP      → limita a saída final


## CTE – Common Table Expression ( Tabelça de expressão comum. )
    Uma CTE é uma consulta temporária nomeada, criada dentro de um comando SQL para organizar e reaproveitar subconsultas.

    Um “bloco lógico” que existe apenas enquanto a query é executada — como se fosse uma mini tabela virtual.
        WITH nome_da_CTE AS (
            -- Consulta base
            SELECT ...
            FROM ...
            WHERE ...
        )
        SELECT *
        FROM nome_da_CTE;

    Exemplo:
        WITH VendasPorCategoria AS (
            SELECT 
                Categoria,
                SUM(Valor) AS TotalVendas
            FROM Vendas
            GROUP BY Categoria
        )
        SELECT *
        FROM VendasPorCategoria
        WHERE TotalVendas > 10000;

## Exemplo com várias CTEs:
        WITH VendasTotais AS (
            SELECT ID_Cliente, SUM(Valor) AS Total
            FROM Vendas
            GROUP BY ID_Cliente
        ),
        ClientesFiltrados AS (
            SELECT ID_Cliente, Total
            FROM VendasTotais
            WHERE Total > 5000
        )
        SELECT c.Nome, cf.Total
        FROM ClientesFiltrados cf
        JOIN Clientes c ON c.ID = cf.ID_Cliente;


## Funções Janela (Window Functions):
    Uma Função Janela executa um cálculo sobre um conjunto de linhas relacionado à linha atual, sem agrupar os resultados.
    É como fazer uma análise linha a linha, mas olhando para o contexto (ou “janela”) ao redor de cada linha.

    exemplo:
        SELECT
            Categoria,
            Produto,
            Valor,
            SUM(Valor) OVER (PARTITION BY Categoria) AS TotalPorCategoria
        FROM Vendas;

        ( SUM(Valor) → soma os valores;)
        (OVER (...) → indica que é uma função janela, não um agrupamento total;)
        (PARTITION BY Categoria → cria “mini-grupos” (uma janela para cada categoria).)

        Resultado: Cada linha mostra o valor da venda e o total da categoria, lado a lado.
                    Isso não é possível com um simples GROUP BY sem perder o detalhe das linhas.

## Estrutura geral da janela
        FUNCAO_AGREGAÇÃO(coluna) 
        OVER (
            PARTITION BY coluna_agrupamento
            ORDER BY coluna_ordenacao
            ROWS BETWEEN ... AND ...
        )

        (PARTITION BY): Divide os dados em grupos independentes
        (ORDER BY): Define a ordem dentro de cada grupo
        (ROWS BETWEEN): Define o tamanho da janela de análise (opcional)

## Exemplo Window Functions – Média móvel de 3 dias
        SELECT
            Data,
            Valor,
            AVG(Valor) OVER (
                ORDER BY Data
                ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
            ) AS MediaMovel3Dias
        FROM Vendas;

    (Aqui, cada linha calcula a média considerando os 2 dias anteriores + o dia atual.)

## Outras funções janela muito usadas
    ROW_NUMBER() : Numera as linhas em cada partição
    RANK() : Cria ranking com empates
    DENSE_RANK() : Ranking contínuo sem saltos
    LAG() : Pega o valor da linha anterior
    LEAD() : Pega o valor da linha seguinte
    NTILE(4) : Divide dados em 4 grupos (quartis)


## O conceito estatístico de Quartil

    Na estatística, os quartis dividem um conjunto de dados ordenados em quatro partes iguais, cada uma contendo 25% dos valores.

        1º Quartil (Q1): até 25% dos valores (parte mais baixa)

        2º Quartil (Q2): até 50% (a mediana)

        3º Quartil (Q3): até 75%

        4º Quartil (Q4): os 25% mais altos

    Imagine 100 clientes ordenados pelo total gasto:

        Q1 → os 25 clientes que menos gastaram

        Q2 → os 25 seguintes

        Q3 → os próximos 25

        Q4 → os 25 que mais gastaram

    O que o SQL faz com NTILE(4)

        No SQL, usamos a função janela NTILE(n) para dividir os resultados em n grupos de tamanhos o mais próximos possível.

        Quando escrevemos:

        NTILE(4) OVER (ORDER BY t.TotalCliente) AS Quartil


    O SQL:

        Ordena as linhas pelo TotalCliente (do menor para o maior);

        Divide essas linhas em 4 grupos (n = 4);

        Atribui o número do grupo à nova coluna Quartil.


## O que é uma Stored Procedure?
    Uma Stored Procedure (ou Procedimento Armazenado) é um bloco de código SQL armazenado no banco de dados, que pode ser executado sob demanda como uma função.
    Ela é criada uma vez e pode ser executada várias vezes, economizando tempo e garantindo consistência.
    Uma “função SQL”, mas rodando no próprio banco, sem precisar escrever o mesmo comando toda hora.

        Exemplo simples:
            CREATE PROCEDURE ListarClientes
            AS
            BEGIN
                SELECT * FROM Clientes;
            END;
        
        Para executar: 
            EXEC ListarClientes;

## Estrutura básica de uma Procedure
        CREATE PROCEDURE nome_da_procedure
            @parametro1 TIPO,
            @parametro2 TIPO = valor_padrao
        AS
        BEGIN
            -- Corpo do código SQL
            SET NOCOUNT ON;  -- Evita mensagens de contagem de linhas (boa prática)
    
            SELECT ...;
        END;

        (CREATE PROCEDURE): Cria o procedimento
        (@parametro): Variável de entrada
        (AS / BEGIN / END): Delimita o bloco de comandos
        (SET NOCOUNT ON): Evita mensagens desnecessárias no retorno
        (EXEC): Executa a procedure criada

## Exemplo: total de vendas por cliente
        CREATE PROCEDURE TotalVendasPorCliente
            @ID_Cliente INT
        AS
        BEGIN
            SET NOCOUNT ON;

            SELECT 
                c.Nome,
                SUM(v.Valor) AS TotalVendas
            FROM Vendas v
            JOIN Clientes c ON c.ID_Cliente = v.ID_Cliente
            WHERE v.ID_Cliente = @ID_Cliente
            GROUP BY c.Nome;
        END;

        Para executar:
            EXEC TotalVendasPorCliente @ID_Cliente = 3;


## Procedures com múltiplos parâmetros e filtros opcionais:
        CREATE PROCEDURE RelatorioVendas
            @DataInicio DATE = NULL,
            @DataFim DATE = NULL,
            @Categoria NVARCHAR(100) = NULL
        AS
        BEGIN
            SET NOCOUNT ON;

            SELECT 
                c.Nome AS Categoria,
                SUM(v.Valor) AS Total
            FROM Vendas v
            JOIN Produtos p ON p.ID_Produto = v.ID_Produto
            JOIN Categorias c ON c.ID_Categoria = p.ID_Categoria
            WHERE
                (@DataInicio IS NULL OR v.DataVenda >= @DataInicio)
                AND (@DataFim IS NULL OR v.DataVenda <= @DataFim)
                AND (@Categoria IS NULL OR c.Nome = @Categoria)
            GROUP BY c.Nome
            ORDER BY Total DESC;
        END;

        Para executar:
            EXEC RelatorioVendas;  -- todas as vendas
            EXEC RelatorioVendas @DataInicio = '2025-01-01', @DataFim = '2025-03-31';
            EXEC RelatorioVendas @Categoria = 'Eletrônicos';

## Procedures com variáveis internas e lógica condicional
## Procedures podem armazenar resultados em variáveis, usar IF/ELSE e executar blocos lógicos:
        CREATE PROCEDURE AvaliarCliente
            @ID_Cliente INT
        AS
        BEGIN
            SET NOCOUNT ON;

            DECLARE @Total DECIMAL(10,2);

            SELECT @Total = SUM(Valor)
            FROM Vendas
            WHERE ID_Cliente = @ID_Cliente;

            IF @Total > 50000
                PRINT 'Cliente de alto valor';
            ELSE
                PRINT 'Cliente regular';
        END;

## Procedures com saída de valor (Output Parameter):
## Você pode retornar resultados diretamente em variáveis externas, não apenas via SELECT:
        CREATE PROCEDURE ContarVendasCliente
            @ID_Cliente INT,
            @QtdVendas INT OUTPUT
        AS
        BEGIN
            SET NOCOUNT ON;
            SELECT @QtdVendas = COUNT(*) FROM Vendas WHERE ID_Cliente = @ID_Cliente;
        END;

        Execução:

        DECLARE @Resultado INT;
        EXEC ContarVendasCliente @ID_Cliente = 3, @QtdVendas = @Resultado OUTPUT;
        SELECT @Resultado AS TotalVendas;

## Atualizando, testando e removendo procedures
    ALTER PROCEDURE nome : Atualiza uma procedure existente
    DROP PROCEDURE nome : Exclui uma procedure
    EXEC nome : Executa
    sp_helptext 'nome' : Exibe o código da procedure

## Exemplo integrado com CTE e Window Functions
        CREATE PROCEDURE RankingClientesMensal
            @Mes INT,
            @Ano INT
        AS
        BEGIN
            SET NOCOUNT ON;

            WITH VendasMes AS (
                SELECT 
                    ID_Cliente,
                    SUM(Valor) AS Total
                FROM Vendas
                WHERE MONTH(DataVenda) = @Mes AND YEAR(DataVenda) = @Ano
                GROUP BY ID_Cliente
            )
            SELECT 
                c.Nome AS Cliente,
                v.Total,
                RANK() OVER (ORDER BY v.Total DESC) AS Posicao
            FROM VendasMes v
            JOIN Clientes c ON c.ID_Cliente = v.ID_Cliente;
        END;

        Execução:
            EXEC RankingClientesMensal @Mes = 9, @Ano = 2025;








