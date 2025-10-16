"""
SCRIPT 48: STREAM ANALYTICS QUERIES
Nível: Intermediário
Foco: Linguagem de consulta do Stream Analytics
"""

class StreamAnalyticsQueries:
    def __init__(self):
        self.constructos_principais = {
            "SELECT": "Selecao de campos do stream",
            "FROM": "Especificacao da fonte de dados",
            "WHERE": "Filtragem de eventos",
            "GROUP BY": "Agrupamento com janelas temporais",
            "JOIN": "Juncao de multiplos streams",
            "INTO": "Especificacao do destino"
        }
    
    def criar_query_basica(self):
        query = {
            "descricao": "Query basica para contagem de eventos",
            "sql": """
SELECT
    COUNT(*) as total_eventos,
    System.Timestamp() as window_end
INTO
    [output-powerbi]
FROM
    [input-eventhub] 
TIMESTAMP BY EventEnqueuedUtcTime
GROUP BY
    TumblingWindow(minute, 1)
            """
        }
        return query
    
    def tipos_janelas_temporais(self):
        janelas = {
            "TumblingWindow": "Janelas fixas sem sobreposicao",
            "HoppingWindow": "Janelas que pulam no tempo",
            "SlidingWindow": "Janelas que disparam quando eventos ocorrem",
            "SessionWindow": "Janelas baseadas em sessoes de atividade"
        }
        return janelas
    
    def funcoes_stream_analytics(self):
        funcoes = {
            "System.Timestamp() - Timestamp do evento",
            "COUNT() - Contagem de eventos",
            "AVG() - Media de valores",
            "MAX()/MIN() - Valores extremos",
            "LAG() - Acesso a eventos anteriores"
        }
        return funcoes

def demonstrar_queries_stream_analytics():
    queries = StreamAnalyticsQueries()
    
    print("=== STREAM ANALYTICS QUERIES ===")
    print("Constructos Principais:")
    for constructo, descricao in queries.constructos_principais.items():
        print(f"- {constructo}: {descricao}")
    
    print("\nQuery Basica Exemplo:")
    query_exemplo = queries.criar_query_basica()
    print(f"Descricao: {query_exemplo['descricao']}")
    print("SQL:")
    print(query_exemplo['sql'])
    
    print("\nTipos de Janelas Temporais:")
    janelas = queries.tipos_janelas_temporais()
    for janela, descricao in janelas.items():
        print(f"- {janela}: {descricao}")
    
    print("\nFuncoes Importantes:")
    for funcao in queries.funcoes_stream_analytics():
        print(f"- {funcao}")

if __name__ == "__main__":
    demonstrar_queries_stream_analytics()