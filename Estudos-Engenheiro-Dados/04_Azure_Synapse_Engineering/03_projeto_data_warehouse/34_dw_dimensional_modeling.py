"""
SCRIPT 34: DATA WAREHOUSE DIMENSIONAL MODELING
Nível: Intermediário
Foco: Modelagem dimensional para data warehouse
"""

class DimensionalModeling:
    def __init__(self):
        self.conceitos_chave = {
            "Fato": "Tabela com metricas de negocio (vendas, quantidade)",
            "Dimensao": "Tabela com descritores (tempo, produto, cliente)",
            "Star Schema": "Modelo estrela com fato no centro",
            "Snowflake": "Dimensoes normalizadas em multiplas tabelas"
        }
    
    def criar_modelo_vendas(self):
        modelo = {
            "fato_vendas": {
                "tipo": "Fato",
                "colunas": ["id_venda", "id_tempo", "id_produto", "id_cliente", "valor_venda", "quantidade"],
                "chaves_estrangeiras": ["id_tempo", "id_produto", "id_cliente"]
            },
            "dim_tempo": {
                "tipo": "Dimensao", 
                "colunas": ["id_tempo", "data", "dia_semana", "mes", "ano", "trimestre"]
            },
            "dim_produto": {
                "tipo": "Dimensao",
                "colunas": ["id_produto", "nome_produto", "categoria", "subcategoria"]
            },
            "dim_cliente": {
                "tipo": "Dimensao", 
                "colunas": ["id_cliente", "nome_cliente", "cidade", "estado"]
            }
        }
        return modelo

def demonstrar_modelagem():
    modelagem = DimensionalModeling()
    
    print("=== DIMENSIONAL MODELING ===")
    print("Conceitos Fundamentais:")
    for conceito, definicao in modelagem.conceitos_chave.items():
        print(f"- {conceito}: {definicao}")
    
    print("\nModelo Exemplo - Vendas:")
    modelo = modelagem.criar_modelo_vendas()
    for tabela, detalhes in modelo.items():
        print(f"\n{tabela} ({detalhes['tipo']}):")
        print(f"  Colunas: {', '.join(detalhes['colunas'])}")

if __name__ == "__main__":
    demonstrar_modelagem()