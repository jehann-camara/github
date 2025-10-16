"""
SCRIPT 52: MONITORAMENTO ALERTAS STREAMING
Nível: Intermediário
Foco: Monitoramento e alertas para pipelines de streaming
"""

class MonitoramentoAlertasStreaming:
    def __init__(self):
        self.metricas_chave = {
            "InputEvents": "Quantidade de eventos recebidos",
            "OutputEvents": "Quantidade de eventos processados",
            "WatermarkDelay": "Atraso no processamento",
            "ResourceUtilization": "Utilizacao de recursos",
            "ConversionErrors": "Erros de conversao de dados"
        }
    
    def configurar_alertas_essenciais(self):
        alertas = {
            "AltoWatermarkDelay": {
                "metrica": "WatermarkDelay",
                "condicao": "GreaterThan",
                "limite": "300",  # 5 minutos
                "acao": "Notificar equipe de operacoes"
            },
            "ErrosConversao": {
                "metrica": "ConversionErrors", 
                "condicao": "GreaterThan",
                "limite": "10",
                "acao": "Investigar fonte de dados"
            },
            "BaixaUtilizacao": {
                "metrica": "ResourceUtilization",
                "condicao": "LessThan",
                "limite": "10",  # 10%
                "acao": "Reduzir Streaming Units"
            }
        }
        return alertas
    
    def dashboard_monitoramento(self):
        dashboard = {
            "Visao Geral": [
                "Status dos jobs em execucao",
                "Throughput de entrada/saida",
                "Latencia media de processamento"
            ],
            "Performance": [
                "Utilizacao de Streaming Units",
                "Watermark delay por job",
                "Eventos processados por minuto"
            ],
            "Saude": [
                "Erros e excecoes",
                "Backlog de eventos",
                "Disponibilidade dos endpoints"
            ]
        }
        return dashboard
    
    def praticas_monitoramento(self):
        praticas = [
            "Configurar alertas proativos para metricas chave",
            "Monitorar tendencias de utilizacao de recursos",
            "Estabelecer SLAs para latencia de processamento",
            "Implementar logging detalhado para troubleshooting",
            "Revisar regularmente metricas de performance"
        ]
        return praticas

def demonstrar_monitoramento_alertas():
    monitoramento = MonitoramentoAlertasStreaming()
    
    print("=== MONITORAMENTO ALERTAS STREAMING ===")
    print("Metricas Chave para Monitoramento:")
    for metrica, descricao in monitoramento.metricas_chave.items():
        print(f"- {metrica}: {descricao}")
    
    print("\nAlertas Essenciais Configurados:")
    alertas = monitoramento.configurar_alertas_essenciais()
    for nome_alerta, config in alertas.items():
        print(f"\n{nome_alerta}:")
        print(f"  Metrica: {config['metrica']}")
        print(f"  Condicao: {config['condicao']}")
        print(f"  Limite: {config['limite']}")
        print(f"  Acao: {config['acao']}")
    
    print("\nDashboard de Monitoramento:")
    dashboard = monitoramento.dashboard_monitoramento()
    for secao, itens in dashboard.items():
        print(f"\n{secao}:")
        for item in itens:
            print(f"  - {item}")
    
    print("\nPraticas Recomendadas:")
    for pratica in monitoramento.praticas_monitoramento():
        print(f"- {pratica}")

if __name__ == "__main__":
    demonstrar_monitoramento_alertas()