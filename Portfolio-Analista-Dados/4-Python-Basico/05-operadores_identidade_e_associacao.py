
# Operadores de Identidade e de associacao em Python // By Jehann Câmara

# São operadores utilizados para comparar se os dois objetos testados ocupam a mesma posição na memória.

curso = "Curso Python"
nome_curso = curso
saldo, limite = 200, 200

print(curso is nome_curso)

print(curso is not nome_curso)

print(saldo is limite)

# São operadores utilizados para verificar se um objeto está presente em uma sequencia

curso = "Curso de Python"
frutas = ["laranja","uva","limão"]
saques = [1500,100]

print( "Python" in curso)

print( "Maçã" not in frutas)

print( "uva" in frutas)

200 in saques