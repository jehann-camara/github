"""
SCRIPT 41: DATABRICKS DATA ENGINEERING
Nível: Intermediário
Foco: Padrões e práticas de engenharia de dados
"""

class DataEngineeringPatterns:
    def __init__(self):
        self.padroes_comuns = {
            "Incremental Load": "Carregamento apenas de dados novos/alterados",
            "Change Data Capture": "Captura de mudanças em dados fonte",
            "Data Validation": "Validacao de qualidade dos dados",
            "Error Handling": "Tratamento de erros e excecoes",
            "Data Lineage": "Rastreamento da origem dos dados"
        }
    
    def pipeline_incremental_exemplo(self):
        pipeline = {
            "identificacao_novos_dados": """
-- Identificar dados novos desde ultima execucao
SELECT MAX(data_modificacao) as ultima_execucao 
FROM tabela_controle
            """,
            "extração_incremental": """
-- Extrair apenas dados modificados
SELECT * 
FROM tabela_fonte 
WHERE data_modificacao > '${ultima_execucao}'
            """,
            "atualizacao_controle": """
-- Atualizar controle de execucao
UPDATE tabela_controle 
SET data_modificacao = CURRENT_TIMESTAMP()
            """
        }
        return pipeline
    
    def praticas_recomendadas(self):
        praticas = [
            "Implementar logging detalhado",
            "Usar parametrizacao para flexibilidade",
            "Configurar alertas para falhas",
            "Manter documentacao atualizada",
            "Testar pipelines com dados de exemplo"
        ]
        return praticas

def demonstrar_data_engineering():
    de_patterns = DataEngineeringPatterns()
    
    print("=== DATABRICKS DATA ENGINEERING ===")
    print("Padroes Comuns:")
    for padrao, descricao in de_patterns.padroes_comuns.items():
        print(f"- {padrao}: {descricao}")
    
    print("\nPipeline Incremental - Exemplo:")
    pipeline = de_patterns.pipeline_incremental_exemplo()
    for etapa, codigo in pipeline.items():
        print(f"\n{etapa}:")
        print(codigo)
    
    print("\nPraticas Recomendadas:")
    for pratica in de_patterns.praticas_recomendadas():
        print(f"- {pratica}")

if __name__ == "__main__":
    demonstrar_data_engineering()