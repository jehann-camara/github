"""
SCRIPT 20: ADF DATA FLOWS
Nível: Básico-Intermediário  
Foco: Transformações visuais com Data Flows
"""

class DataFlowTransformacoes:
    def __init__(self):
        self.transformacoes = [
            "Selecionar - Escolher colunas específicas",
            "Filtrar - Aplicar condições WHERE",
            "Coluna Derivada - Criar novas colunas",
            "Agrupar - Aggregate com GROUP BY",
            "Ordenar - Sort por colunas",
            "Junção - JOIN entre datasets"
        ]
    
    def criar_data_flow_limpeza(self):
        data_flow = {
            "nome": "Limpeza_Clientes",
            "origem": "DataLake/Raw/Clientes",
            "transformacoes": [
                "Selecionar: ID, Nome, Email, Telefone",
                "Filtrar: Email IS NOT NULL",
                "Coluna Derivada: Dominio = SPLIT(Email, '@')[1]",
                "Ordenar: Nome ASC"
            ],
            "destino": "DataLake/Processed/Clientes"
        }
        return data_flow

def demonstrar_transformacoes():
    data_flow = DataFlowTransformacoes()
    
    print("=== TRANSFORMAÇÕES DATA FLOW ===")
    for transformacao in data_flow.transformacoes:
        print(f" {transformacao}")
    
    exemplo = data_flow.criar_data_flow_limpeza()
    print(f"\nExemplo Prático: {exemplo['nome']}")
    for etapa in exemplo['transformacoes']:
        print(f" {etapa}")

if __name__ == "__main__":
    demonstrar_transformacoes()