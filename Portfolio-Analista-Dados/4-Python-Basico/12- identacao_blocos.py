
# Identação e blocos em Python // By Jehann Câmara

# Método Sacar

def sacar (valor):

    saldo = 500

    if saldo >= valor:
        print("Valor Sacado = " + str(valor))
    else:
        print(" Valor não sacado, faltam " + str(valor - saldo) + " de saldo")
        
sacar(1000)

