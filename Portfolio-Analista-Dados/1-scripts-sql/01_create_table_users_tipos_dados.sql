
-- Curso Sql Udemy: https://www.udemy.com/course/microsoft-sql-server-2022/learn/lecture/40627794#overview
-- By Jehann C�mara

use hcode

Create table tb_users (
	id int,
	name varchar (100)
)

exec sp_help tb_users -- atalho: ALT + F1 selecionando a tabela

-- Tipos de dados
-- Int = inteiros (4 bytes)
-- decimmal: Pre�o gasolina: 5,299 = decimal(4,3) , onde 4 s�o os algarismos e 3 a precis�o.
-- Datetime: Data e hora
-- varchar : caracteres , tamanho vari�vel