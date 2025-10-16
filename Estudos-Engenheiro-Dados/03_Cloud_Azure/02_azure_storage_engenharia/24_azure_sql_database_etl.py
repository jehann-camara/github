"""
SCRIPT 24: AZURE SQL DATABASE ETL
Nível: Básico-Intermediário
Foco: Integração SQL Database com ETL
"""

class SQLDatabaseETL:
    def __init__(self, servidor, database):
        self.servidor = servidor
        self.database = database
        self.tabelas_etl = []
    
    def criar_tabela_staging(self, nome_tabela):
        tabela = {
            "nome": nome_tabela,
            "schema": [
                "ID int PRIMARY KEY",
                "Nome varchar(100)",
                "Email varchar(150)", 
                "DataCriacao datetime",
                "Status varchar(20)"
            ],
            "finalidade": "Tabela temporária para ETL"
        }
        self.tabelas_etl.append(tabela)
        return tabela
    
    def processo_etl_completo(self):
        etapas = [
            "1. Extrair dados do Data Lake",
            "2. Carregar na tabela staging", 
            "3. Validar e limpar dados",
            "4. Transformar regras de negócio",
            "5. Carregar na tabela final"
        ]
        return etapas

def exemplo_etl_sql():
    sql_etl = SQLDatabaseETL("servidor.database.windows.net", "ETL_Database")
    
    # Criar tabela staging
    staging = sql_etl.criar_tabela_staging("stg_clientes")
    
    print("=== ETL AZURE SQL DATABASE ===")
    print(f"Servidor: {sql_etl.servidor}")
    print(f"Database: {sql_etl.database}")
    
    print(f"\nTabela Staging: {staging['nome']}")
    print("Colunas:")
    for coluna in staging['schema']:
        print(f" {coluna}")
    
    print("\nProcesso ETL:")
    etapas = sql_etl.processo_etl_completo()
    for etapa in etapas:
        print(f"  {etapa}")

if __name__ == "__main__":
    exemplo_etl_sql()