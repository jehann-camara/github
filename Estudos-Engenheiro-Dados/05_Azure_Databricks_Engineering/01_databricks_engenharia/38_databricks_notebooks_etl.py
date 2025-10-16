"""
SCRIPT 38: DATABRICKS NOTEBOOKS ETL
Nível: Básico-Intermediário
Foco: Desenvolvimento de notebooks para pipelines ETL
"""

class NotebooksETL:
    def __init__(self):
        self.estrutura_notebook = [
            "Celula 1: Configuracao e imports",
            "Celula 2: Funcoes auxiliares",
            "Celula 3: Leitura dos dados",
            "Celula 4: Transformacoes",
            "Celula 5: Validacoes",
            "Celula 6: Escrita dos resultados"
        ]
    
    def criar_notebook_etl_exemplo(self):
        notebook = {
            "nome": "ETL_Vendas_Diario",
            "celulas": {
                "configuracao": """
# Configuracao inicial
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("ETL_Vendas").getOrCreate()
                """,
                "leitura": """
# Leitura dos dados
df_vendas = spark.read.format("delta").load("/mnt/datalake/raw/vendas")
df_clientes = spark.read.format("delta").load("/mnt/datalake/raw/clientes")
                """,
                "transformacao": """
# Transformacao dos dados
df_vendas_transformado = df_vendas.filter("data_venda >= current_date() - 30")
                """,
                "escrita": """
# Escrita dos resultados
df_vendas_transformado.write.format("delta").mode("overwrite").save("/mnt/datalake/processed/vendas_diario")
                """
            }
        }
        return notebook
    
    def boas_praticas_notebooks(self):
        praticas = [
            "Manter celulas pequenas e focadas",
            "Usar comentarios claros",
            "Testar cada celula independentemente",
            "Parametrizar valores importantes",
            "Versionar notebooks no Git"
        ]
        return praticas

def demonstrar_notebooks_etl():
    notebooks = NotebooksETL()
    
    print("=== DATABRICKS NOTEBOOKS ETL ===")
    print("Estrutura Recomendada Notebook:")
    for celula in notebooks.estrutura_notebook:
        print(f"- {celula}")
    
    print("\nBoas Praticas:")
    for pratica in notebooks.boas_praticas_notebooks():
        print(f"- {pratica}")
    
    exemplo = notebooks.criar_notebook_etl_exemplo()
    print(f"\nExemplo Notebook: {exemplo['nome']}")
    for tipo_celula, codigo in exemplo['celulas'].items():
        print(f"\n{tipo_celula.upper()}:")
        print(codigo)

if __name__ == "__main__":
    demonstrar_notebooks_etl()