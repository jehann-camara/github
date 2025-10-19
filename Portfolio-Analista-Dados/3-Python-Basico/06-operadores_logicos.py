
# Operadores Lógicos em Python // By Jehann Câmara

print(True and True) # = True
print(True and False) # = False
print(False and False) # = False

print(True or True) # = True
print(True or False) # = True
print(False or False) # = False


saldo = 1000 
saque = 200
limite = 100

saldo >= saque # = True
saque <= limite # = False

# Concatenar com operadores lógicos

# V and F = False

saldo >= saque and saque <= limite # = False

# V or F = True

saldo >= saque or saque <= limite # = True

print(saldo >= saque or saque <= limite )

contatos_emergencia = []  # Lista vazia

not 1000 > 1500 # = True

not contatos_emergencia # = True. pois lista vazia = false

not "Saque 1500;" # = False. string não vazia = true

not "" # = true. string vazia = false

#  Precedência de operadores -------------------------------------------------------------------------------

saldo = 1000 
saque = 250
limite = 200
conta_especial = True

(saldo >= saque and saque <= limite) or (conta_especial and saldo >= saque)

print((saldo >= saque and saque <= limite) or (conta_especial and saldo >= saque))
