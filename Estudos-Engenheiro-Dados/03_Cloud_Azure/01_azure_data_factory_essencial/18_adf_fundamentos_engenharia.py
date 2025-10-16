"""
SCRIPT 18: ADF FUNDAMENTOS ENGENHARIA
Nível: Básico
Foco: Conceitos fundamentais Azure Data Factory
"""

# CONCEITOS PRINCIPAIS
class ADFFundamentos:
    def __init__(self):
        self.componentes = {
            "Pipeline": "Orquestra atividades ETL/ELT",
            "Activity": "Etapa individual no pipeline", 
            "Dataset": "Estrutura de dados entrada/saída",
            "Linked Service": "Conexão com fontes de dados",
            "Integration Runtime": "Infraestrutura computação"
        }
    
    def explicar_arquitetura(self):
        print("=== ARQUITETURA BÁSICA ADF ===")
        for componente, funcao in self.componentes.items():
            print(f"• {componente}: {funcao}")

# EXEMPLO PRÁTICO
def criar_pipeline_simples(nome):
    pipeline = {
        "nome": nome,
        "atividades": [
            {"tipo": "Copy", "origem": "SQL", "destino": "DataLake"},
            {"tipo": "Transform", "script": "SQL"}
        ],
        "trigger": "Agendamento Diário"
    }
    return pipeline

# EXECUÇÃO
if __name__ == "__main__":
    print("SCRIPT 18 - ADF FUNDAMENTOS")
    fundamentos = ADFFundamentos()
    fundamentos.explicar_arquitetura()
    
    pipeline = criar_pipeline_simples("Ingestao_Clientes")
    print(f"\nPipeline criado: {pipeline['nome']}")