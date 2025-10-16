"""
SCRIPT 55: DATA GOVERNANCE BÁSICO
Nível: Básico-Intermediário
Foco: Fundamentos de governança de dados
"""

class DataGovernanceBasico:
    def __init__(self):
        self.pilares_governanca = {
            "Qualidade de Dados": "Garantir precisão, integridade e confiabilidade",
            "Segurança e Privacidade": "Proteção e controle de acesso a dados",
            "Metadados e Catálogo": "Documentação e descoberta de dados",
            "Conformidade": "Atendimento a regulamentações e políticas",
            "Linha de Sangue (Lineage)": "Rastreamento da origem e transformações"
        }
    
    def implementar_controles_basicos(self):
        controles = {
            "Classificação de Dados": {
                "Público": "Dados abertos para todos",
                "Interno": "Uso interno da empresa", 
                "Confidencial": "Acesso restrito",
                "Crítico": "Dados sensíveis com proteção máxima"
            },
            "Políticas de Acesso": {
                "RBAC": "Role-Based Access Control",
                "Mínimo Privilégio": "Acesso apenas ao necessário",
                "Auditoria": "Log de acessos e modificações"
            },
            "Qualidade": {
                "Validação": "Checagem de formato e valores",
                "Completude": "Verificação de dados não nulos",
                "Consistência": "Dados coerentes entre sistemas"
            }
        }
        return controles
    
    def catalogo_dados_exemplo(self):
        catalogo = {
            "ativos_dados": [
                "tabela_vendas - Vendas diárias da empresa",
                "tabela_clientes - Cadastro de clientes",
                "tabela_produtos - Catálogo de produtos"
            ],
            "metadados": [
                "Proprietário: time_analytics",
                "Frequência atualização: diária",
                "Classificação: Interno",
                "Sensibilidade: Moderada"
            ]
        }
        return catalogo

def demonstrar_governanca_dados():
    governanca = DataGovernanceBasico()
    
    print("=== DATA GOVERNANCE BÁSICO ===")
    print("Pilares da Governança de Dados:")
    for pilar, descricao in governanca.pilares_governanca.items():
        print(f"- {pilar}: {descricao}")
    
    print("\nControles Básicos de Implementação:")
    controles = governanca.implementar_controles_basicos()
    for controle, detalhes in controles.items():
        print(f"\n{controle}:")
        for tipo, desc in detalhes.items():
            print(f"  - {tipo}: {desc}")
    
    print("\nExemplo de Catálogo de Dados:")
    catalogo = governanca.catalogo_dados_exemplo()
    print("Ativos de Dados:")
    for ativo in catalogo['ativos_dados']:
        print(f"  - {ativo}")

if __name__ == "__main__":
    demonstrar_governanca_dados()