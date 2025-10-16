"""
SCRIPT 33: SYNAPSE DATA TRANSFORMATION
Nível: Intermediário
Foco: Transformações de dados usando SQL e Spark
"""

class DataTransformation:
    def __init__(self):
        self.transformacoes_comuns = {
            "Limpeza": "Remocao de nulos, padronizacao formatos",
            "Agregacao": "SUM, COUNT, AVG, GROUP BY",
            "Join": "Combinacao de multiplas fontes",
            "Pivot": "Transformacao linhas para colunas",
            "Window Functions": "Calculos sobre particoes de dados"
        }
    
    def transformacoes_sql(self):
        exemplos_sql = {
            "limpeza": "UPDATE tabela SET coluna = TRIM(coluna) WHERE coluna IS NOT NULL",
            "agregacao": "SELECT categoria, SUM(vendas) FROM vendas GROUP BY categoria",
            "window_function": "SELECT *, ROW_NUMBER() OVER(PARTITION BY categoria ORDER BY vendas DESC) as rank"
        }
        return exemplos_sql
    
    def transformacoes_spark(self):
        exemplos_spark = {
            "filter": "df_filtered = df.filter(df.coluna > 100)",
            "select": "df_selected = df.select('col1', 'col2')",
            "groupby": "df_grouped = df.groupBy('categoria').agg({'vendas': 'sum'})",
            "join": "df_joined = df1.join(df2, 'id', 'inner')"
        }
        return exemplos_spark

def demonstrar_transformacoes():
    transform = DataTransformation()
    
    print("=== DATA TRANSFORMATION SYNAPSE ===")
    print("Tipos de Transformacao:")
    for tipo, descricao in transform.transformacoes_comuns.items():
        print(f"- {tipo}: {descricao}")
    
    print("\nExemplos SQL:")
    sql_exemplos = transform.transformacoes_sql()
    for operacao, codigo in sql_exemplos.items():
        print(f"{operacao}: {codigo}")
    
    print("\nExemplos Spark:")
    spark_exemplos = transform.transformacoes_spark()
    for operacao, codigo in spark_exemplos.items():
        print(f"{operacao}: {codigo}")

if __name__ == "__main__":
    demonstrar_transformacoes()