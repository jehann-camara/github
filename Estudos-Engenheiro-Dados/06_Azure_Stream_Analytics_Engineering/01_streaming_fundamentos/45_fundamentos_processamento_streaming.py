"""
SCRIPT 45: FUNDAMENTOS PROCESSAMENTO STREAMING
Nível: Básico
Foco: Conceitos fundamentais de processamento em tempo real
"""

class FundamentosStreaming:
    def __init__(self):
        self.conceitos_chave = {
            "Streaming": "Dados continuos e infinitos",
            "Eventos": "Unidades individuais de dados",
            "Tempo de Evento": "Momento quando evento ocorreu",
            "Tempo de Processamento": "Momento quando evento e processado",
            "Janelas Temporais": "Agrupamento de eventos por tempo",
            "Watermark": "Marcador de progresso no stream"
        }
    
    def comparacao_batch_vs_streaming(self):
        comparacao = {
            "Batch Processing": {
                "dados": "Finitos e completos",
                "processamento": "Em lotes agendados",
                "latencia": "Minutos a horas",
                "exemplo": "ETL diario de vendas"
            },
            "Stream Processing": {
                "dados": "Continuos e infinitos",
                "processamento": "Em tempo real",
                "latencia": "Milissegundos a segundos",
                "exemplo": "Monitoramento de transacoes"
            }
        }
        return comparacao
    
    def componentes_arquitetura_streaming(self):
        componentes = [
            "Source - Fonte de dados de streaming",
            "Ingestion - Servico de ingestao de eventos",
            "Processing - Processamento e analise em tempo real",
            "Sink - Destino dos dados processados",
            "Monitoring - Monitoramento e alertas"
        ]
        return componentes

def demonstrar_fundamentos_streaming():
    fundamentos = FundamentosStreaming()
    
    print("=== FUNDAMENTOS PROCESSAMENTO STREAMING ===")
    print("Conceitos Chave:")
    for conceito, definicao in fundamentos.conceitos_chave.items():
        print(f"- {conceito}: {definicao}")
    
    print("\nComparacao Batch vs Streaming:")
    comparacao = fundamentos.comparacao_batch_vs_streaming()
    for tipo, caracteristicas in comparacao.items():
        print(f"\n{tipo}:")
        for carac, valor in caracteristicas.items():
            print(f"  {carac}: {valor}")
    
    print("\nComponentes Arquitetura Streaming:")
    for componente in fundamentos.componentes_arquitetura_streaming():
        print(f"- {componente}")

if __name__ == "__main__":
    demonstrar_fundamentos_streaming()