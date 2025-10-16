"""
SCRIPT 39: DATABRICKS DELTA LAKE
Nível: Intermediário
Foco: Fundamentos do Delta Lake e tabelas ACID
"""

class DeltaLakeEngineering:
    def __init__(self):
        self.vantagens_delta = {
            "ACID Transactions": "Transacoes atomicas e consistentes",
            "Time Travel": "Acesso a versoes historicas dos dados",
            "Schema Enforcement": "Validacao automatica de schema",
            "Upserts": "Operacoes MERGE eficientes",
            "Compaction": "Otimizacao automatica de arquivos"
        }
    
    def criar_tabela_delta_exemplo(self):
        exemplo = {
            "criacao_tabela": """
CREATE TABLE IF NOT EXISTS vendas_delta (
    id_venda LONG,
    data_venda DATE,
    valor_venda DECIMAL(10,2),
    id_cliente LONG
) USING DELTA
LOCATION '/mnt/datalake/delta/tables/vendas'
            """,
            "leitura_delta": """
-- Leitura de tabela Delta
SELECT * FROM delta.`/mnt/datalake/delta/tables/vendas`

-- Ou se criada como tabela managed
SELECT * FROM vendas_delta
            """,
            "operacao_merge": """
MERGE INTO vendas_delta target
USING vendas_updates source
ON target.id_venda = source.id_venda
WHEN MATCHED THEN UPDATE SET *
WHEN NOT MATCHED THEN INSERT *
            """
        }
        return exemplo
    
    def time_travel_exemplo(self):
        time_travel = {
            "versao_especifica": "SELECT * FROM vendas_delta VERSION AS OF 12",
            "timestamp_especifico": "SELECT * FROM vendas_delta TIMESTAMP AS OF '2023-10-01'",
            "historico_versoes": "DESCRIBE HISTORY vendas_delta"
        }
        return time_travel

def demonstrar_delta_lake():
    delta = DeltaLakeEngineering()
    
    print("=== DATABRICKS DELTA LAKE ===")
    print("Vantagens do Delta Lake:")
    for vantagem, descricao in delta.vantagens_delta.items():
        print(f"- {vantagem}: {descricao}")
    
    print("\nExemplos de Operacoes Delta:")
    exemplos = delta.criar_tabela_delta_exemplo()
    for operacao, codigo in exemplos.items():
        print(f"\n{operacao}:")
        print(codigo)
    
    print("\nTime Travel - Exemplos:")
    time_travel = delta.time_travel_exemplo()
    for cenario, query in time_travel.items():
        print(f"{cenario}: {query}")

if __name__ == "__main__":
    demonstrar_delta_lake()