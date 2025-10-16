"""
SCRIPT 53: DATA PLATFORM ARCHITECTURE
Nível: Intermediário
Foco: Arquitetura completa de plataforma de dados Azure
"""

class DataPlatformArchitecture:
    def __init__(self):
        self.camadas_arquitetura = {
            "Ingestão": "Coleta e entrada de dados de múltiplas fontes",
            "Armazenamento": "Camadas de dados brutos, processados e curados",
            "Processamento": "Transformação e enriquecimento de dados",
            "Serviço": "Disponibilização de dados para consumo",
            "Orquestração": "Coordenação de pipelines e workflows",
            "Monitoramento": "Observabilidade e governança"
        }
    
    def arquitetura_referencia_azure(self):
        arquitetura = {
            "Ingestão": ["Azure Data Factory", "Event Hubs", "IoT Hubs"],
            "Armazenamento": ["Data Lake Gen2", "Blob Storage", "SQL Database"],
            "Processamento": ["Azure Databricks", "Synapse Analytics", "Stream Analytics"],
            "Serviço": ["Power BI", "Synapse Serverless", "API Management"],
            "Orquestração": ["ADF Pipelines", "Databricks Workflows"],
            "Monitoramento": ["Azure Monitor", "Log Analytics"]
        }
        return arquitetura
    
    def criar_plataforma_exemplo(self, nome_empresa):
        plataforma = {
            "nome": f"Plataforma Dados - {nome_empresa}",
            "camadas": {
                "Bronze": "datalake/bronze - Dados brutos",
                "Silver": "datalake/silver - Dados limpos e validados",
                "Gold": "datalake/gold - Dados de negócio"
            },
            "tecnologias_principais": [
                "Azure Data Factory para orquestração",
                "Azure Databricks para processamento",
                "Azure Synapse para data warehouse",
                "Power BI para visualização"
            ]
        }
        return plataforma

def demonstrar_arquitetura_plataforma():
    arquitetura = DataPlatformArchitecture()
    
    print("=== DATA PLATFORM ARCHITECTURE ===")
    print("Camadas da Arquitetura:")
    for camada, descricao in arquitetura.camadas_arquitetura.items():
        print(f"- {camada}: {descricao}")
    
    print("\nArquitetura de Referência Azure:")
    ref_arquitetura = arquitetura.arquitetura_referencia_azure()
    for camada, tecnologias in ref_arquitetura.items():
        print(f"\n{camada}:")
        for tech in tecnologias:
            print(f"  - {tech}")
    
    print("\nExemplo de Plataforma:")
    plataforma = arquitetura.criar_plataforma_exemplo("Empresa XYZ")
    print(f"Nome: {plataforma['nome']}")
    print("Camadas de Dados:")
    for camada, path in plataforma['camadas'].items():
        print(f"  {camada}: {path}")

if __name__ == "__main__":
    demonstrar_arquitetura_plataforma()