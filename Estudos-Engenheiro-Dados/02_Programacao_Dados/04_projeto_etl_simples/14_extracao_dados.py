"""
ROADMAP ENGENHARIA DE DADOS - MÊS 2
Script: 14_extracao_dados.py
Data: 11/10/2025
Descrição: Extração de dados de múltiplas fontes para projeto ETL
"""

import pandas as pd
import os

print("=== EXTRAÇÃO DE DADOS - PROJETO ETL ===")

# Criar diretório para dados extraídos
os.makedirs('dados_etl', exist_ok=True)

# FONTE 1: Dados de vendas em CSV
print("\n1. EXTRAINDO DADOS DE VENDAS (CSV):")

dados_vendas = {
    'venda_id': [1, 2, 3, 4, 5],
    'produto': ['Notebook', 'Mouse', 'Teclado', 'Monitor', 'Tablet'],
    'quantidade': [2, 5, 3, 1, 4],
    'valor_unitario': [2500.00, 50.00, 120.00, 800.00, 450.00],
    'data_venda': ['2025-01-15', '2025-01-16', '2025-01-17', '2025-01-18', '2025-01-19']
}

df_vendas = pd.DataFrame(dados_vendas)
df_vendas.to_csv('dados_etl/vendas.csv', index=False)
print("OK - Dados de vendas salvos em: dados_etl/vendas.csv")
print(df_vendas)

# FONTE 2: Dados de clientes em JSON
print("\n2. EXTRAINDO DADOS DE CLIENTES (JSON):")

dados_clientes = {
    'cliente_id': [101, 102, 103, 104, 105],
    'nome': ['Ana Silva', 'Carlos Santos', 'Marina Oliveira', 'Pedro Costa', 'Julia Lima'],
    'cidade': ['São Paulo', 'Rio de Janeiro', 'Belo Horizonte', 'Porto Alegre', 'Recife'],
    'estado': ['SP', 'RJ', 'MG', 'RS', 'PE']
}

df_clientes = pd.DataFrame(dados_clientes)
df_clientes.to_json('dados_etl/clientes.json', orient='records', indent=2)
print("OK - Dados de clientes salvos em: dados_etl/clientes.json")
print(df_clientes)

# FONTE 3: Dados de produtos em Excel
print("\n3. EXTRAINDO DADOS DE PRODUTOS (EXCEL):")

dados_produtos = {
    'produto_id': [1001, 1002, 1003, 1004, 1005],
    'categoria': ['Informática', 'Informática', 'Informática', 'Informática', 'Tablet'],
    'marca': ['Dell', 'Logitech', 'Microsoft', 'Samsung', 'Apple'],
    'estoque': [15, 30, 20, 10, 8]
}

df_produtos = pd.DataFrame(dados_produtos)
df_produtos.to_excel('dados_etl/produtos.xlsx', index=False)
print("OK - Dados de produtos salvos em: dados_etl/produtos.xlsx")
print(df_produtos)

# RESUMO DA EXTRAÇÃO
print("\n=== RESUMO DA EXTRAÇÃO ===")
print(f"OK - Vendas: {len(df_vendas)} registros")
print(f"OK - Clientes: {len(df_clientes)} registros")
print(f"OK - Produtos: {len(df_produtos)} registros")
print("OK - Arquivos salvos na pasta 'dados_etl'")

print("=== EXTRAÇÃO CONCLUÍDA ===")