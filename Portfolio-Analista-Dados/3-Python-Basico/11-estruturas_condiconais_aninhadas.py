
# Estruturas Condicionais aninhadas + If ternário // By Jehann Câmara

conta_normal = True

conta_universitaria = False

saldo = 3000

#saque = float(input("Informe o valor do saque !"))
saque = 200

cheque_especial = 1000

if conta_normal:
    if saldo >= saque:
        print("Saque realizado com sucesso")
    elif saque <= (saldo + cheque_especial):
        print("Saldo realizado com uso do cheque especial")
    elif saque > (saldo + cheque_especial):  
        print("Saldo insuficiente, mesmo com cheque especial")
elif conta_universitaria:
    if saldo >= saque:
        print("Saque realizado com sucesso")
    else:
        print("Saldo insuficiente")


# If ternário 
saque = float(input("Informe o valor do saque novamente !"))

status_saque = "Saque realizado com sucesso" if ( conta_normal and saldo >= saque ) else "Saldo insuficiente"

print(status_saque)
