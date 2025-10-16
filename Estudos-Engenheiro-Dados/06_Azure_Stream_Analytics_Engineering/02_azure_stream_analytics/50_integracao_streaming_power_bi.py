"""
SCRIPT 50: INTEGRAÇÃO STREAMING POWER BI
Nível: Básico-Intermediário
Foco: Visualização de dados em tempo real no Power BI
"""

class IntegracaoPowerBI:
    def __init__(self):
        self.tipos_datasets_streaming = {
            "Streaming Dataset": "Dados em tempo real com janela de retencao",
            "Push Dataset": "Dados armazenados para historico",
            "Hybrid Dataset": "Combinacao de streaming e dados historicos"
        }
    
    def criar_dataset_streaming_exemplo(self):
        dataset = {
            "nome": "VendasTempoReal",
            "tipo": "Streaming Dataset",
            "campos": [
                {"nome": "timestamp", "tipo": "DateTime"},
                {"nome": "produto", "tipo": "Text"},
                {"nome": "quantidade", "tipo": "Number"},
                {"nome": "valor", "tipo": "Number"},
                {"nome": "localizacao", "tipo": "Text"}
            ],
            "retencao": 1  # dia
        }
        return dataset
    
    def configurar_output_power_bi(self):
        config = {
            "dataset": "Nome do dataset no Power BI",
            "table": "Nome da tabela no dataset",
            "authentication": "User Authentication ou Service Principal",
            "group_id": "ID do workspace do Power BI"
        }
        return config
    
    def exemplos_visualizacao_tempo_real(self):
        exemplos = [
            "Dashboard de monitoramento de vendas",
            "Metricas de performance em tempo real",
            "Mapa de calor de atividades",
            "Gauge para metricas operacionais",
            "Gráfico de linhas para tendencias"
        ]
        return exemplos
    
    def fluxo_dados_completo(self):
        fluxo = [
            "1. Dados gerados por aplicacao/dispositivo",
            "2. Ingestao via Event Hubs/IoT Hubs",
            "3. Processamento com Stream Analytics",
            "4. Output para Power BI Streaming Dataset",
            "5. Visualizacao em dashboard tempo real"
        ]
        return fluxo

def demonstrar_integracao_power_bi():
    power_bi = IntegracaoPowerBI()
    
    print("=== INTEGRAÇÃO STREAMING POWER BI ===")
    print("Tipos de Datasets Streaming:")
    for tipo, descricao in power_bi.tipos_datasets_streaming.items():
        print(f"- {tipo}: {descricao}")
    
    print("\nDataset Streaming Exemplo:")
    dataset = power_bi.criar_dataset_streaming_exemplo()
    print(f"Nome: {dataset['nome']}")
    print(f"Tipo: {dataset['tipo']}")
    print("Campos:")
    for campo in dataset['campos']:
        print(f"  - {campo['nome']}: {campo['tipo']}")
    
    print("\nExemplos de Visualizacao:")
    for exemplo in power_bi.exemplos_visualizacao_tempo_real():
        print(f"- {exemplo}")
    
    print("\nFluxo de Dados Completo:")
    for etapa in power_bi.fluxo_dados_completo():
        print(f"{etapa}")

if __name__ == "__main__":
    demonstrar_integracao_power_bi()