"""
SCRIPT 21: INTEGRATION RUNTIME
Nível: Básico
Foco: Configuração e tipos de IR
"""

class IntegrationRuntimeConfig:
    def __init__(self):
        self.tipos_ir = {
            "Azure": "IR gerenciado pela Azure - Mais comum",
            "Auto-Hospedado": "IR em infra própria - Dados locais",
            "Azure-SSIS": "Para executar pacotes SSIS"
        }
    
    def selecionar_ir(self, cenarios):
        recomendacoes = {
            "dados_publicos": "Azure",
            "rede_corporativa": "Auto-Hospedado",
            "migracao_etl": "Azure-SSIS"
        }
        return recomendacoes.get(cenarios, "Azure")
    
    def configurar_ir_azure(self):
        config = {
            "tipo": "Azure",
            "regiao": "Brazil South",
            "nos_computacao": 2,
            "tamanho_no": "Standard_D2_v3"
        }
        return config

def exemplo_configuracao():
    ir_config = IntegrationRuntimeConfig()
    
    print("=== TIPOS INTEGRATION RUNTIME ===")
    for tipo, descricao in ir_config.tipos_ir.items():
        print(f"• {tipo}: {descricao}")
    
    print("\n=== CONFIGURAÇÃO RECOMENDADA ===")
    config = ir_config.configurar_ir_azure()
    for chave, valor in config.items():
        print(f"{chave}: {valor}")

if __name__ == "__main__":
    exemplo_configuracao()