"""
SCRIPT 22: AZURE DATA LAKE GEN2
Nível: Básico
Foco: Armazenamento hierárquico para dados
"""

class DataLakeEstrutura:
    def __init__(self, nome_conta):
        self.conta = nome_conta
        self.camadas = ["Raw", "Processed", "Curated"]
    
    def criar_estrutura_pastas(self, dominio):
        estrutura = {
            "Raw": [
                f"{dominio}/landing",
                f"{dominio}/incremental" 
            ],
            "Processed": [
                f"{dominio}/cleaned",
                f"{dominio}/enriched"
            ],
            "Curated": [
                f"{dominio}/business",
                f"{dominio}/analytics"
            ]
        }
        return estrutura

def demonstrar_estrutura():
    data_lake = DataLakeEstrutura("datalakeempresa")
    
    print("=== ESTRUTURA DATA LAKE GEN2 ===")
    print("Camadas de dados:")
    for camada in data_lake.camadas:
        print(f" {camada}")
    
    estrutura = data_lake.criar_estrutura_pastas("vendas")
    print("\nEstrutura exemplo - Domínio Vendas:")
    for camada, pastas in estrutura.items():
        print(f"\n{camada}:")
        for pasta in pastas:
            print(f" {pasta}")

if __name__ == "__main__":
    demonstrar_estrutura()