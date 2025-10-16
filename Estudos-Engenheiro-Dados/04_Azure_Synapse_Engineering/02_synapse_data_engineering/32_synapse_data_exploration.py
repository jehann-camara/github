"""
SCRIPT 32: SYNAPSE DATA EXPLORATION
Nível: Básico
Foco: Análise exploratória de dados no Synapse
"""

class DataExploration:
    def __init__(self):
        self.tecnicas_exploracao = [
            "Analise de estrutura dos dados",
            "Verificacao de valores nulos",
            "Analise de distribuicao",
            "Identificacao de outliers",
            "Correlacao entre variaveis"
        ]
    
    def queries_exploratorias_sql(self, tabela):
        queries = {
            "estrutura": f"SELECT TOP 10 * FROM {tabela}",
            "contagem": f"SELECT COUNT(*) as total_registros FROM {tabela}",
            "nulos": f"SELECT COUNT(*) as nulos FROM {tabela} WHERE coluna IS NULL",
            "distribuicao": f"SELECT coluna, COUNT(*) as freq FROM {tabela} GROUP BY coluna"
        }
        return queries
    
    def analise_spark_exemplo(self):
        analises = [
            "df.describe() - Estatisticas descritivas",
            "df.printSchema() - Estrutura do dataframe",
            "df.groupBy().agg() - Agregacoes",
            "df.corr() - Correlacao entre colunas numericas"
        ]
        return analises

def demonstrar_exploracao():
    exploration = DataExploration()
    
    print("=== DATA EXPLORATION SYNAPSE ===")
    print("Tecnicas de Exploracao:")
    for tecnica in exploration.tecnicas_exploracao:
        print(f"- {tecnica}")
    
    print("\nQueries SQL Exploratorias:")
    queries = exploration.queries_exploratorias_sql("tabela_vendas")
    for finalidade, query in queries.items():
        print(f"{finalidade}:")
        print(f"  {query}")
    
    print("\nAnalises com Spark:")
    for analise in exploration.analise_spark_exemplo():
        print(f"- {analise}")

if __name__ == "__main__":
    demonstrar_exploracao()