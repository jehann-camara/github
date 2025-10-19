
# Estruturas condiconais em Python // By Jehann Câmara

saldo = 2000.0

saque = float(input("Informe o valor do saque : "))

if saldo >= saque:
    print("Realizando saque !")

    
if saldo < saque:
    print("Saldo Insuficiente !")


if saldo >= saque:
    print("Realizando saque !")
else:
    print("Saldo Insuficiente !")

if saldo > saque:
    print("Realizando saque !")
elif saldo < saque:
    print("Saldo Insuficiente !")
else:
    print("Você vai sacar todo o saldo")