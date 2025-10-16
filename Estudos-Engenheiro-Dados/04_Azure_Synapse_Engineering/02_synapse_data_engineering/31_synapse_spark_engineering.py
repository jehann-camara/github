"""
SCRIPT 31: SYNAPSE SPARK ENGINEERING
Nível: Básico-Intermediário
Foco: Processamento distribuído com Spark Pools
"""

class SparkEngineering:
    def __init__(self):
        self.configuracoes_pool = {
            "tamanho_no": "Small",
            "auto_scale": "3-10 nos",
            "runtime_version": "3.2",
            "libraries": ["pandas", "pyodbc"]
        }
    
    def criar_dataframe_exemplo(self):
        exemplos = {
            "leitura_parquet": "df = spark.read.parquet('abfss://container@datalake.dfs.core.windows.net/path')",
            "leitura_csv": "df = spark.read.csv('abfss://container@datalake.dfs.core.windows.net/path.csv')",
            "transformacao": "df_transformed = df.select('coluna1', 'coluna2').filter(df.coluna1 > 100)",
            "escrita": "df_transformed.write.parquet('abfss://container@datalake.dfs.core.windows.net/output')"
        }
        return exemplos
    
    def configurar_otimizacao(self):
        otimizacoes = [
            "Usar formato Parquet para melhor performance",
            "Particionar dados por colunas frequentemente filtradas",
            "Usar cache para dataframes reutilizados",
            "Ajustar numero de particoes com repartition()"
        ]
        return otimizacoes

def demonstrar_spark_engineering():
    spark_eng = SparkEngineering()
    
    print("=== SPARK ENGINEERING SYNAPSE ===")
    print("Configuracao Pool Spark:")
    for config, valor in spark_eng.configuracoes_pool.items():
        print(f"- {config}: {valor}")
    
    print("\nExemplos de Codigo:")
    exemplos = spark_eng.criar_dataframe_exemplo()
    for operacao, codigo in exemplos.items():
        print(f"{operacao}:")
        print(f"  {codigo}")
    
    print("\nOtimizacoes Recomendadas:")
    for otimizacao in spark_eng.configurar_otimizacao():
        print(f"- {otimizacao}")

if __name__ == "__main__":
    demonstrar_spark_engineering()