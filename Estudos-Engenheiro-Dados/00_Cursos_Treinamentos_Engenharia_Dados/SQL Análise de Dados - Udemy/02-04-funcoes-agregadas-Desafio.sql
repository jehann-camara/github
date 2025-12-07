-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Conte quantos clientes da tabela sales.customers tem menos de 30 anos

select count(customer_id)
from sales.customers
where birth_date > CURRENT_DATE - INTERVAL '30 years'

select count(*)
from sales.customers
where ((current_date - birth_date) / 365 ) < 30


-- (Exercício 2) Informe a idade do cliente mais velho e mais novo da tabela sales.customers

SELECT
    MAX(EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date))) AS idade_mais_velho,
    MIN(EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date))) AS idade_mais_novo
from sales.customers

select 
	max((current_date - birth_date) / 365 ),
	min((current_date - birth_date) / 365 )
from sales.customers


-- (Exercício 3) Selecione todas as informações do cliente mais rico da tabela sales.customers
-- (possívelmente a resposta contém mais de um cliente)

select *
from sales.customers
where income = (select max(income) from sales.customers)

-- (Exercício 4) Conte quantos veículos de cada marca tem registrado na tabela sales.products
-- Ordene o resultado pelo nome da marca

select brand, count(*) as contagem
from sales.products
group by brand
order by brand


-- (Exercício 5) Conte quantos veículos existem registrados na tabela sales.products
-- por marca e ano do modelo. Ordene pela nome da marca e pelo ano do veículo

select brand, model_year, count(*) as contagem
from sales.products
group by brand, model_year
order by brand, model_year


-- (Exercício 6) Conte quantos veículos de cada marca tem registrado na tabela sales.products
-- e mostre apenas as marcas que contém mais de 10 veículos registrados

select brand, count(*) as contagem
from sales.products
group by brand
having count(*) > 10
order by contagem desc
