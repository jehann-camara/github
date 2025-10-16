"""
SCRIPT 42: DATABRICKS WORKFLOWS
Nível: Intermediário
Foco: Orquestração de jobs e workflows
"""

class DatabricksWorkflows:
    def __init__(self):
        self.componentes_workflow = {
            "Job": "Definicao de tarefa a ser executada",
            "Task": "Unidade individual de trabalho no job",
            "Cluster": "Computacao para execucao das tasks",
            "Schedule": "Agendamento de execucao",
            "Notification": "Alertas e notificacoes"
        }
    
    def criar_workflow_etl(self):
        workflow = {
            "nome": "ETL_Vendas_Diario",
            "tasks": [
                {
                    "nome": "ingestao_vendas",
                    "notebook": "/Workspace/01_Ingestao/ingestao_vendas",
                    "cluster": "cluster-etl-standard"
                },
                {
                    "nome": "transformacao_vendas", 
                    "notebook": "/Workspace/02_Transformacao/transformacao_vendas",
                    "cluster": "cluster-etl-standard",
                    "dependencies": ["ingestao_vendas"]
                },
                {
                    "nome": "validacao_dados",
                    "notebook": "/Workspace/03_Validacao/validacao_vendas",
                    "cluster": "cluster-etl-standard",
                    "dependencies": ["transformacao_vendas"]
                }
            ],
            "schedule": "0 0 8 * * ?",  # Diariamente as 8h
            "notificacoes": {
                "on_success": ["team@empresa.com"],
                "on_failure": ["alerts@empresa.com"]
            }
        }
        return workflow
    
    def tipos_trigger(self):
        triggers = {
            "Manual": "Execucao manual por usuario",
            "Schedule": "Execucao baseada em cron expression",
            "File Arrival": "Execucao baseada em chegada de arquivos",
            "API": "Execucao via chamada de API"
        }
        return triggers

def demonstrar_workflows():
    workflows = DatabricksWorkflows()
    
    print("=== DATABRICKS WORKFLOWS ===")
    print("Componentes do Workflow:")
    for componente, descricao in workflows.componentes_workflow.items():
        print(f"- {componente}: {descricao}")
    
    print("\nTipos de Trigger:")
    triggers = workflows.tipos_trigger()
    for trigger, descricao in triggers.items():
        print(f"- {trigger}: {descricao}")
    
    print("\nExemplo Workflow ETL:")
    workflow = workflows.criar_workflow_etl()
    print(f"Workflow: {workflow['nome']}")
    print("Tasks:")
    for task in workflow['tasks']:
        print(f"  - {task['nome']} (dependencies: {task.get('dependencies', 'nenhuma')})")

if __name__ == "__main__":
    demonstrar_workflows()