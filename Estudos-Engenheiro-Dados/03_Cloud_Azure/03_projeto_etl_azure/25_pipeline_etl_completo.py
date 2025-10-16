"""
SCRIPT 25: PIPELINE ETL COMPLETO
Nível: Intermediário
Foco: Projeto prático integrando conceitos
"""

class PipelineETLCompleto:
    def __init__(self, nome):
        self.nome = nome
        self.componentes = {}
    
    def configurar_origens(self):
        origens = {
            "SQL Server": "dados relacionais",
            "Data Lake Raw": "arquivos CSV/JSON",
            "Blob Storage": "arquivos temporários"
        }
        self.componentes["origens"] = origens
    
    def configurar_transformacoes(self):
        transformacoes = [
            "Limpeza dados nulos",
            "Padronização formatos",
            "Validação regras negócio",
            "Enriquecimento dados"
        ]
        self.componentes["transformacoes"] = transformacoes
    
    def configurar_destinos(self):
        destinos = {
            "Data Lake Processed": "dados limpos",
            "Azure SQL Database": "dados relacionais",
            "Data Lake Curated": "dados analíticos"
        }
        self.componentes["destinos"] = destinos
    
    def executar_pipeline(self):
        print(f"\n=== EXECUTANDO PIPELINE: {self.nome} ===")
        
        print("\n[1] EXTRAÇÃO:")
        for origem, descricao in self.componentes["origens"].items():
            print(f" {origem}: {descricao}")
        
        print("\n[2] TRANSFORMAÇÃO:")
        for transformacao in self.componentes["transformacoes"]:
            print(f" {transformacao}")
        
        print("\n[3] CARGA:")
        for destino, descricao in self.componentes["destinos"].items():
            print(f" {destino}: {descricao}")
        
        print("\n PIPELINE CONCLUÍDO COM SUCESSO!")

def projeto_etl_vendas():
    pipeline = PipelineETLCompleto("ETL_Vendas_Completo")
    
    pipeline.configurar_origens()
    pipeline.configurar_transformacoes() 
    pipeline.configurar_destinos()
    pipeline.executar_pipeline()
    
    return pipeline

if __name__ == "__main__":
    projeto_etl_vendas()