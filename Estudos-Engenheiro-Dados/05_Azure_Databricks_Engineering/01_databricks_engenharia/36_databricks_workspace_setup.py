"""
SCRIPT 36: DATABRICKS WORKSPACE SETUP
Nível: Básico
Foco: Configuração inicial do workspace Databricks
"""

class DatabricksWorkspace:
    def __init__(self):
        self.componentes_workspace = {
            "Workspace": "Área de trabalho principal para organização",
            "Clusters": "Ambientes de computação para execução",
            "Notebooks": "Documentos interativos para código",
            "Jobs": "Tarefas agendadas ou por demanda",
            "Libraries": "Bibliotecas e dependências",
            "Data": "Acesso a fontes de dados e storage"
        }
    
    def criar_workspace_config(self, nome, regiao):
        config = {
            "nome_workspace": nome,
            "regiao_azure": regiao,
            "tipo_workspace": "Standard",
            "configuracao_rede": "Public Access",
            "permissoes": "Azure AD Integration"
        }
        return config
    
    def estrutura_pastas_recomendada(self):
        estrutura = {
            "Workspace": [
                "00_Setup/ - Configuracoes iniciais",
                "01_Ingestao/ - Pipelines de ingestao",
                "02_Transformacao/ - Notebooks de transformacao",
                "03_Analise/ - Analises e modelos",
                "04_Deploy/ - Jobs e producao"
            ]
        }
        return estrutura

def demonstrar_workspace():
    databricks = DatabricksWorkspace()
    
    print("=== DATABRICKS WORKSPACE SETUP ===")
    print("Componentes do Workspace:")
    for componente, funcao in databricks.componentes_workspace.items():
        print(f"- {componente}: {funcao}")
    
    config = databricks.criar_workspace_config("databricks-dev", "Brazil South")
    print(f"\nConfiguracao Exemplo:")
    for chave, valor in config.items():
        print(f"{chave}: {valor}")
    
    print("\nEstrutura de Pastas Recomendada:")
    estrutura = databricks.estrutura_pastas_recomendada()
    for pasta, descricao in estrutura.items():
        for item in descricao:
            print(f"{item}")

if __name__ == "__main__":
    demonstrar_workspace()