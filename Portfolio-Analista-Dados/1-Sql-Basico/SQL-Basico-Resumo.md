## Resumo Sql básico // By Jehann Câmara

## Resumo Sql Básico
    SELECT * Escolhe e calcula as colunas do resultado *
    FROM * Lê as tabelas base *
    JOIN * Combina tabelas conforme as condições *
    WHERE * Filtra linhas individuais (antes de agrupamento) *
    GROUP BY * Agrupa as linhas em conjuntos *
    HAVING * Filtra grupos após o agrupamento *
    ORDER BY * Ordena o resultado final *
    LIMIT / TOP * Restringe o número de linhas mostradas * 

## Exemplo:
    SELECT 
        Vendedor,
        SUM(Valor) AS TotalVendas
    FROM Vendas
    WHERE Mes = 'Janeiro'
    GROUP BY Vendedor
    HAVING SUM(Valor) > 1000
    ORDER BY TotalVendas DESC;

