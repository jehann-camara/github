
# Estruturas de Repetição For, range e While // By Jehann Câmara

#For

texto = input("Informe um texto: ")
VOGAIS = "AEIOU"

for letra in texto:
    if letra.upper() in VOGAIS:
        print(letra, end="")
        print() # adiciona uma quebra de linha 
else:
    print("Executa no final do laço")        


# Range + For

for numero in range(0,11):
    print(numero, end=" ")
   
# Tabuada de 5

for numero in range(0,51, 5):
    print(numero, end=" ")

print()

# While

opcao = -1

while opcao != 0:
    opcao = int(input(" Escolha uma opção: \n [1] Sacar \n [2] Extrato \n [0] Sair \n"))

    if opcao == 1:
        print("Sacando...")
    elif opcao == 2:
        print("Exibindo o Extrato")
    elif opcao == 3:
        print("Utilizando o break")
        break # Break para o laço e Continue pula uma iteração do laço

else: 
    print("Obrigado por utilizar nosso sistema bancário")
    exit() #exit() e quit() finalizam
