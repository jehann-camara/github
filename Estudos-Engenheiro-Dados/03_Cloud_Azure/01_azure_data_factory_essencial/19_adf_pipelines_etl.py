"""
SCRIPT 19: ADF PIPELINES ETL  
Nível: Básico-Intermediário
Foco: Criação de pipelines ETL práticos
"""

class PipelineETL:
    def __init__(self, nome):
        self.nome = nome
        self.etapas = []
    
    def adicionar_extracao(self, origem, query):
        etapa = {
            "tipo": "Extração",
            "origem": origem,
            "query": query,
            "descricao": "Extrair dados da fonte"
        }
        self.etapas.append(etapa)
    
    def adicionar_transformacao(self, transformacao):
        etapa = {
            "tipo": "Transformação",
            "operacao": transformacao,
            "descricao": "Transformar dados"
        }
        self.etapas.append(etapa)
    
    def adicionar_carga(self, destino):
        etapa = {
            "tipo": "Carga",
            "destino": destino,
            "descricao": "Carregar dados no destino"
        }
        self.etapas.append(etapa)
    
    def executar_simulacao(self):
        print(f"\n=== EXECUTANDO PIPELINE: {self.nome} ===")
        for i, etapa in enumerate(self.etapas, 1):
            print(f"{i}. [{etapa['tipo']}] {etapa['descricao']}")

# EXEMPLO PRÁTICO
def pipeline_vendas():
    pipeline = PipelineETL("Processamento_Vendas")
    
    pipeline.adicionar_extracao(
        origem="SQLServer/Vendas", 
        query="SELECT * FROM Vendas WHERE Data >= DATEADD(day, -1, GETDATE())"
    )
    
    pipeline.adicionar_transformacao("Calcular total de vendas")
    pipeline.adicionar_transformacao("Agrupar por categoria")
    
    pipeline.adicionar_carga("DataLake/Processado/Vendas")
    
    return pipeline

if __name__ == "__main__":
    pipeline = pipeline_vendas()
    pipeline.executar_simulacao()