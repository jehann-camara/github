"""
SCRIPT 44: DATA PROCESSING PIPELINE
Nível: Intermediário
Foco: Pipeline completo de processamento de dados
"""

class DataProcessingPipeline:
    def __init__(self, nome_pipeline):
        self.nome = nome_pipeline
        self.etapas = []
    
    def adicionar_etapa_ingestao(self, fonte, formato):
        etapa = {
            "tipo": "Ingestao",
            "fonte": fonte,
            "formato": formato,
            "descricao": f"Ingerir dados de {fonte} no formato {formato}"
        }
        self.etapas.append(etapa)
    
    def adicionar_etapa_transformacao(self, transformacoes):
        etapa = {
            "tipo": "Transformacao",
            "transformacoes": transformacoes,
            "descricao": f"Aplicar transformacoes: {', '.join(transformacoes)}"
        }
        self.etapas.append(etapa)
    
    def adicionar_etapa_carga(self, destino, formato):
        etapa = {
            "tipo": "Carga", 
            "destino": destino,
            "formato": formato,
            "descricao": f"Carregar dados em {destino} no formato {formato}"
        }
        self.etapas.append(etapa)
    
    def executar_pipeline(self):
        print(f"=== EXECUTANDO PIPELINE: {self.nome} ===")
        for i, etapa in enumerate(self.etapas, 1):
            print(f"{i}. [{etapa['tipo']}] {etapa['descricao']}")
            if etapa['tipo'] == 'Transformacao':
                print(f"   Transformacoes: {', '.join(etapa['transformacoes'])}")

def pipeline_vendas_completo():
    pipeline = DataProcessingPipeline("Pipeline_Vendas_Completo")
    
    # Camada Bronze
    pipeline.adicionar_etapa_ingestao("SQL Server/Vendas", "JDBC")
    pipeline.adicionar_etapa_carga("DataLake/Bronze/Vendas", "Delta")
    
    # Camada Silver
    pipeline.adicionar_etapa_ingestao("DataLake/Bronze/Vendas", "Delta")
    pipeline.adicionar_etapa_transformacao([
        "Remocao duplicatas",
        "Validacao schema", 
        "Limpeza nulos",
        "Padronizacao formatos"
    ])
    pipeline.adicionar_etapa_carga("DataLake/Silver/Vendas", "Delta")
    
    # Camada Gold
    pipeline.adicionar_etapa_ingestao("DataLake/Silver/Vendas", "Delta")
    pipeline.adicionar_etapa_transformacao([
        "Agregacao vendas por categoria",
        "Calculo metricas mensais",
        "Enriquecimento dados cliente"
    ])
    pipeline.adicionar_etapa_carga("DataLake/Gold/Vendas", "Delta")
    
    return pipeline

if __name__ == "__main__":
    print("=== DATA PROCESSING PIPELINE ===")
    pipeline = pipeline_vendas_completo()
    pipeline.executar_pipeline()
    
    print("\n=== RESUMO PIPELINE MEDALLION ===")
    print("Arquitetura completa implementada:")
    print("- Bronze: Dados brutos da fonte")
    print("- Silver: Dados limpos e validados") 
    print("- Gold: Dados agregados para negocio")