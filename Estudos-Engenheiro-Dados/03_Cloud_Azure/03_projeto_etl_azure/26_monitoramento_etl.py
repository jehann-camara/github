"""
SCRIPT 26: MONITORAMENTO ETL
Nível: Básico-Intermediário
Foco: Acompanhamento e qualidade pipelines
"""

class MonitoramentoETL:
    def __init__(self):
        self.metricas = [
            "Tempo execução pipeline",
            "Quantidade registros processados",
            "Taxa sucesso/falha",
            "Performance atividades"
        ]
        
        self.alertas = [
            "Falha execução pipeline",
            "Tempo execução acima esperado",
            "Qtd registros fora padrão",
            "Erros transformação"
        ]
    
    def criar_dashboard_monitoramento(self):
        dashboard = {
            "Pipeline Runs": {
                "Sucesso": "95%",
                "Falha": "3%", 
                "Executando": "2%"
            },
            "Performance": {
                "Tempo médio": "15min",
                "Atividade mais lenta": "Transformação Dados",
                "Recomendação": "Otimizar data flow"
            },
            "Qualidade": {
                "Dados processados": "1.2M registros",
                "Erros validação": "150 registros",
                "Taxa qualidade": "99.9%"
            }
        }
        return dashboard

def demonstrar_monitoramento():
    monitor = MonitoramentoETL()
    
    print("=== MONITORAMENTO ETL ===")
    
    print("\n MÉTRICAS PRINCIPAIS:")
    for metrica in monitor.metricas:
        print(f"  • {metrica}")
    
    print("\n ALERTAS CONFIGURADOS:")
    for alerta in monitor.alertas:
        print(f" {alerta}")
    
    print("\n DASHBOARD EXEMPLO:")
    dashboard = monitor.criar_dashboard_monitoramento()
    for categoria, dados in dashboard.items():
        print(f"\n{categoria}:")
        for item, valor in dados.items():
            print(f"  {item}: {valor}")

if __name__ == "__main__":
    demonstrar_monitoramento()