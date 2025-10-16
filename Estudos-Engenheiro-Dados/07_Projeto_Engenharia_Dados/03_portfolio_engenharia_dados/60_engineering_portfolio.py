"""
SCRIPT 60: ENGINEERING PORTFOLIO
Nível: Intermediário
Foco: Construção de portfolio profissional de engenharia de dados
"""

class EngineeringPortfolio:
    def __init__(self):
        self.componentes_portfolio = {
            "Projetos Práticos": "Implementações reais com tecnologias Azure",
            "Documentação Técnica": "READMEs, arquiteturas e decisões técnicas",
            "Código Fonte": "Repositórios GitHub com exemplos de código",
            "Casos de Uso": "Problemas de negócio resolvidos com dados",
            "Métricas e Resultados": "Impacto mensurável dos projetos"
        }
    
    def criar_estrutura_portfolio(self):
        estrutura = {
            "projetos_principais": [
                {
                    "nome": "Pipeline ETL End-to-End",
                    "tecnologias": ["Azure Data Factory", "Databricks", "Synapse"],
                    "descricao": "Pipeline completo de processamento de dados de vendas",
                    "destaques": ["Medallion Architecture", "Data Quality Checks"]
                },
                {
                    "nome": "Streaming em Tempo Real", 
                    "tecnologias": ["Event Hubs", "Stream Analytics", "Power BI"],
                    "descricao": "Sistema de monitoramento de transações em tempo real",
                    "destaques": ["Low latency processing", "Real-time dashboards"]
                },
                {
                    "nome": "Data Warehouse Cloud",
                    "tecnologias": ["Synapse Analytics", "Data Lake", "Power BI"],
                    "descricao": "Data warehouse dimensional na nuvem Azure",
                    "destaques": ["Star Schema", "Performance Optimization"]
                }
            ],
            "habilidades_demonstradas": [
                "Orquestração de pipelines com ADF",
                "Processamento distribuído com Databricks",
                "Modelagem dimensional com Synapse",
                "Streaming com Stream Analytics",
                "Visualização com Power BI"
            ]
        }
        return estrutura
    
    def plataformas_apresentacao(self):
        plataformas = [
            "GitHub - Código fonte e documentação",           
            "Azure DevOps - Pipelines CI/CD demonstradas"
        ]
        return plataformas

def demonstrar_engineering_portfolio():
    portfolio = EngineeringPortfolio()
    
    print("=== ENGINEERING PORTFOLIO ===")
    print("Componentes do Portfolio Profissional:")
    for componente, descricao in portfolio.componentes_portfolio.items():
        print(f"- {componente}: {descricao}")
    
    print("\nEstrutura de Portfolio Exemplo:")
    estrutura = portfolio.criar_estrutura_portfolio()
    print("Projetos Principais:")
    for projeto in estrutura['projetos_principais']:
        print(f"\n{projeto['nome']}:")
        print(f"  Tecnologias: {', '.join(projeto['tecnologias'])}")
        print(f"  Descrição: {projeto['descricao']}")
        print(f"  Destaques: {', '.join(projeto['destaques'])}")
    
    print("\nPlataformas de Apresentação:")
    for plataforma in portfolio.plataformas_apresentacao():
        print(f"- {plataforma}")

if __name__ == "__main__":
    demonstrar_engineering_portfolio()