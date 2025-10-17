
-- Curso Sql Udemy: https://www.udemy.com/course/microsoft-sql-server-2022/learn/lecture/40627794#overview
-- By Jehann Câmara

use hcode

Create table tb_users (
	id int,
	name varchar (100)
)

exec sp_help tb_users -- atalho: ALT + F1 selecionando a tabela

-- Tipos de dados
-- Int = inteiros (4 bytes)
-- decimmal: Preço gasolina: 5,299 = decimal(4,3) , onde 4 são os algarismos e 3 a precisão.
-- Datetime: Data e hora
-- varchar : caracteres , tamanho variável