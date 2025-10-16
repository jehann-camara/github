"""
SCRIPT 51: PIPELINE TEMPO REAL COMPLETO
Nível: Intermediário
Foco: Projeto completo de pipeline em tempo real
"""

class PipelineTempoRealCompleto:
    def __init__(self, nome_pipeline):
        self.nome = nome_pipeline
        self.componentes = {}
    
    def configurar_arquitetura_completa(self):
        arquitetura = {
            "Ingestao": {
                "servico": "Azure Event Hubs",
                "config": "Namespace: eh-streaming, Partitions: 4"
            },
            "Processamento": {
                "servico": "Azure Stream Analytics",
                "config": "3 Streaming Units, Query personalizada"
            },
            "Armazenamento": {
                "servico": "Azure Data Lake",
                "config": "Camada Raw para dados brutos"
            },
            "Visualizacao": {
                "servico": "Power BI",
                "config": "Streaming Dataset para tempo real"
            },
            "Monitoramento": {
                "servico": "Azure Monitor",
                "config": "Alertas para metricas chave"
            }
        }
        return arquitetura
    
    def query_analytics_completa(self):
        query = {
            "descricao": "Pipeline completo para analise de vendas em tempo real",
            "sql": """
WITH 
VendasProcessadas AS (
    SELECT
        produto,
        quantidade,
        valor,
        cliente,
        System.Timestamp() as process_time,
        EventEnqueuedUtcTime as event_time
    FROM
        [input-vendas]
    TIMESTAMP BY EventEnqueuedUtcTime
),
Agregacoes AS (
    SELECT
        produto,
        SUM(quantidade) as total_quantidade,
        SUM(valor) as total_vendas,
        COUNT(*) as total_transacoes,
        System.Timestamp() as window_end
    FROM
        VendasProcessadas
    GROUP BY
        produto, TumblingWindow(minute, 5)
)
-- Output para Power BI (tempo real)
SELECT * INTO [output-powerbi] FROM Agregacoes

-- Output para Data Lake (historico)
SELECT * INTO [output-datalake] FROM VendasProcessadas
            """
        }
        return query
    
    def executar_pipeline(self):
        print(f"=== EXECUTANDO PIPELINE: {self.nome} ===")
        
        arquitetura = self.configurar_arquitetura_completa()
        print("Arquitetura do Pipeline:")
        for componente, detalhes in arquitetura.items():
            print(f"\n{componente}:")
            print(f"  Servico: {detalhes['servico']}")
            print(f"  Config: {detalhes['config']}")
        
        print(f"\nQuery Stream Analytics:")
        query = self.query_analytics_completa()
        print(f"Descricao: {query['descricao']}")
        print("SQL implementado com sucesso")

def projeto_vendas_tempo_real():
    pipeline = PipelineTempoRealCompleto("Pipeline_Vendas_Tempo_Real")
    
    print("=== PIPELINE TEMPO REAL COMPLETO ===")
    pipeline.executar_pipeline()
    
    print("\nBeneficios Implementados:")
    beneficios = [
        "Processamento de vendas em tempo real",
        "Agregacoes a cada 5 minutos",
        "Dashboard Power BI atualizado continuamente",
        "Armazenamento historico no Data Lake",
        "Monitoramento e alertas proativos"
    ]
    for beneficio in beneficios:
        print(f"- {beneficio}")
    
    return pipeline

if __name__ == "__main__":
    projeto_vendas_tempo_real()