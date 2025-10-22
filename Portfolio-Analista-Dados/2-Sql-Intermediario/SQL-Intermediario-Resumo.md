

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


