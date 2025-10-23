
# Interpolação de variáveis em Python // By Jehann Câmara

nome = "Jehann Câmara"
idade = 38
profissao = "Analista de Dados"
linguagem = "Python"
saldo = 45.234

print("Olá, me chamo {}. Eu tenho {} anos de idade, trabalho como {} e estou estudando {}.".format(nome, idade, profissao, linguagem))

print("Olá, me chamo {3}. Eu tenho {2} anos de idade, trabalho como {1} e estou estudando {0}.".format(linguagem, profissao, idade, nome))

PI = 3,14159

# print(f"Valor de de PI: {PI:.2f}")

# print(f"Valor de de PI: {PI: 10.2f}")


# Interpolar utilizando dicionario
dicionario_pessoa = {"nome": "Jehann Câmara","idade": 38}

print("nome: {nome} e idade: {idade} ".format(**dicionario_pessoa))
print(f"nome: {nome} e idade: {idade} e saldo= {saldo:10.2f}") # Inclue em saldo 10 espaços e formata com 2 casas decimais