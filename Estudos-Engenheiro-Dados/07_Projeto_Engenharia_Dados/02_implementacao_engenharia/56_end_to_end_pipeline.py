"""
SCRIPT 56: END-TO-END PIPELINE
Nível: Intermediário
Foco: Pipeline completo integrando todas as tecnologias
"""

class EndToEndPipeline:
    def __init__(self, nome_pipeline):
        self.nome = nome_pipeline
        self.etapas = []
    
    def definir_arquitetura_pipeline(self):
        arquitetura = {
            "Fonte de Dados": ["SQL Server", "API REST", "Arquivos CSV"],
            "Ingestão": ["Azure Data Factory", "Event Hubs"],
            "Processamento": ["Databricks", "Synapse Analytics"],
            "Armazenamento": ["Data Lake", "SQL Database", "Synapse DW"],
            "Visualização": ["Power BI", "Synapse Studio"],
            "Monitoramento": ["Azure Monitor", "Log Analytics"]
        }
        return arquitetura
    
    def criar_pipeline_vendas_completo(self):
        pipeline = {
            "nome": "Pipeline_Vendas_EndToEnd",
            "etapas": [
                {
                    "fase": "Extração",
                    "tecnologia": "Azure Data Factory",
                    "atividade": "Copiar dados de SQL Server para Data Lake Bronze"
                },
                {
                    "fase": "Processamento",
                    "tecnologia": "Azure Databricks", 
                    "atividade": "Transformar e limpar dados no Data Lake Silver"
                },
                {
                    "fase": "Modelagem",
                    "tecnologia": "Azure Synapse",
                    "atividade": "Carregar modelo dimensional no Data Lake Gold"
                },
                {
                    "fase": "Visualização", 
                    "tecnologia": "Power BI",
                    "atividade": "Conectar e criar dashboards analíticos"
                },
                {
                    "fase": "Monitoramento",
                    "tecnologia": "Azure Monitor",
                    "atividade": "Configurar alertas e métricas de performance"
                }
            ]
        }
        return pipeline
    
    def executar_simulacao_pipeline(self):
        print(f"=== EXECUTANDO PIPELINE END-TO-END: {self.nome} ===")
        pipeline = self.criar_pipeline_vendas_completo()
        
        for etapa in pipeline['etapas']:
            print(f"\n[{etapa['fase']}]")
            print(f"Tecnologia: {etapa['tecnologia']}")
            print(f"Atividade: {etapa['atividade']}")
            print("Status: Concluído")

def projeto_pipeline_completo():
    pipeline = EndToEndPipeline("Vendas_Enterprise_Data_Pipeline")
    
    print("=== END-TO-END PIPELINE ===")
    print("Arquitetura do Pipeline:")
    arquitetura = pipeline.definir_arquitetura_pipeline()
    for componente, tecnologias in arquitetura.items():
        print(f"\n{componente}:")
        for tech in tecnologias:
            print(f"  - {tech}")
    
    print("\nExecução do Pipeline:")
    pipeline.executar_simulacao_pipeline()
    
    return pipeline

if __name__ == "__main__":
    projeto_pipeline_completo()