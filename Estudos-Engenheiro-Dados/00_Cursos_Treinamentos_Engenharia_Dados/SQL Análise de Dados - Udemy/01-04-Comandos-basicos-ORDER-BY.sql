-- PARA QUE SERVE ##################################################################
-- Serve para ordenar a seleção de acordo com uma regra definida pelo usuário


-- SINTAXE #########################################################################
select coluna_1, coluna_2, coluna_3
from schema_1.tabela_1
where condição_x=true
order by coluna_1


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Ordenação de valores numéricos
-- Liste produtos da tabela products na ordem crescente com base no preço
select *
from sales.products
--where price > 0
order by price

-- Usando Desc = decrescente
select *
from sales.products
--where price > 0
order by price desc

-- (Exemplo 2) Ordenação de texto
-- Liste os estados distintos da tabela customers na ordem crescente
select distinct state
from sales.customers
--where state is not null
order by state

-- Usando Desc = decrescente
select distinct state
from sales.customers
--where state is not null
order by state desc


-- RESUMO ##########################################################################
-- (1) Comando utilizado para ordenar a seleção de acordo com uma regra definida
-- (2) Por padrão o comando ordena na ordem crescente. Para mudar para a ordem 
-- decrescente usar o comando DESC
-- (3) No caso de strings a ordenação será seguirá a ordem alfabetica




