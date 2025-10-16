"""
SCRIPT 49: STREAM ANALYTICS JOBS
Nível: Intermediário
Foco: Configuração e gerenciamento de jobs
"""

class StreamAnalyticsJobs:
    def __init__(self):
        self.componentes_job = {
            "Inputs": "Fontes de dados de streaming",
            "Query": "Consulta SQL para processamento",
            "Outputs": "Destinos dos dados processados",
            "Functions": "Funcoes JavaScript para transformacoes",
            "Job Diagram": "Visualizacao do fluxo de dados"
        }
    
    def criar_configuracao_job(self, nome_job):
        config = {
            "nome": nome_job,
            "streaming_units": 3,
            "compatibilidade_level": "1.2",
            "ordem_eventos": "EventEnqueuedUtcTime",
            "policy_out_of_order": "Adjust",
            "policy_late_arrival": "Drop"
        }
        return config
    
    def configuracoes_input(self):
        inputs = {
            "Event Hub": "Para eventos genericos",
            "IoT Hub": "Para dados de dispositivos IoT",
            "Blob Storage": "Para dados de referencia",
            "Azure Functions": "Para processamento customizado"
        }
        return inputs
    
    def configuracoes_output(self):
        outputs = {
            "Power BI": "Para dashboards em tempo real",
            "Data Lake": "Para armazenamento de dados",
            "SQL Database": "Para dados relacionais",
            "Event Hub": "Para encadeamento de streams",
            "Azure Functions": "Para acoes customizadas"
        }
        return outputs

def demonstrar_stream_analytics_jobs():
    jobs = StreamAnalyticsJobs()
    
    print("=== STREAM ANALYTICS JOBS ===")
    print("Componentes do Job:")
    for componente, descricao in jobs.componentes_job.items():
        print(f"- {componente}: {descricao}")
    
    print("\nConfiguracao Job Exemplo:")
    config = jobs.criar_configuracao_job("job-monitoramento-vendas")
    for chave, valor in config.items():
        print(f"{chave}: {valor}")
    
    print("\nTipos de Input Suportados:")
    inputs = jobs.configuracoes_input()
    for tipo, descricao in inputs.items():
        print(f"- {tipo}: {descricao}")
    
    print("\nTipos de Output Suportados:")
    outputs = jobs.configuracoes_output()
    for tipo, descricao in outputs.items():
        print(f"- {tipo}: {descricao}")

if __name__ == "__main__":
    demonstrar_stream_analytics_jobs()