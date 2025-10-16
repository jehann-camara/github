"""
ROADMAP ENGENHARIA DE DADOS - MÊS 2
Script: 17_relatorio_final.py
Data: 11/10/2025
Descrição: Relatório final do projeto ETL simples
"""

import pandas as pd
import pyodbc

print("=== RELATORIO FINAL - PROJETO ETL ===")

def conectar_sql_server():
    """Conecta ao SQL Server usando a configuracao do seu ambiente"""
    connection_string = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=G\\SQLEXPRESS;"
        "DATABASE=RoadmapEngenhariaDados;"
        "Trusted_Connection=yes;"
        "Encrypt=yes;"
        "TrustServerCertificate=yes;"
    )
    
    try:
        conn = pyodbc.connect(connection_string)
        print("OK - Conexao estabelecida com G\\SQLEXPRESS")
        return conn
    except pyodbc.Error as e:
        print(f"ERRO - Falha na conexao: {e}")
        return None

print("1. CONECTANDO AO BANCO PARA ANALISE:")
conn = conectar_sql_server()
if not conn:
    exit()

# ANALISE DOS DADOS
print("\n2. ANALISE DOS DADOS CARREGADOS:")

df_vendas = pd.read_sql("SELECT * FROM VendasETL", conn)

print(f"OK - Total de vendas processadas: {len(df_vendas)}")
print(f"OK - Periodo das vendas: {df_vendas['data_venda'].min()} a {df_vendas['data_venda'].max()}")
print(f"OK - Valor total vendido: R$ {df_vendas['valor_total'].sum():,.2f}")

# ANALISE POR PRODUTO
print("\n3. VENDAS POR PRODUTO:")
vendas_produto = df_vendas.groupby('produto').agg({
    'quantidade': 'sum',
    'valor_total': 'sum'
}).reset_index()

for _, row in vendas_produto.iterrows():
    print(f"   {row['produto']}: {row['quantidade']} unidades - R$ {row['valor_total']:,.2f}")

# ANALISE POR CIDADE
print("\n4. VENDAS POR CIDADE:")
vendas_cidade = df_vendas.groupby('cidade')['valor_total'].sum().reset_index()
vendas_cidade = vendas_cidade.sort_values('valor_total', ascending=False)

for _, row in vendas_cidade.iterrows():
    print(f"   {row['cidade']}: R$ {row['valor_total']:,.2f}")

# RELATORIO FINAL
print("\n5. RELATORIO FINAL:")
print("=" * 50)
print("RELATORIO DO PROJETO ETL")
print("=" * 50)
print(f"Total de Vendas Processadas: {len(df_vendas)}")
print(f"Valor Total: R$ {df_vendas['valor_total'].sum():,.2f}")

produto_mais_vendido = vendas_produto.loc[vendas_produto['valor_total'].idxmax()]
cidade_maior_venda = vendas_cidade.loc[vendas_cidade['valor_total'].idxmax()]

print(f"Produto Mais Vendido: {produto_mais_vendido['produto']} (R$ {produto_mais_vendido['valor_total']:,.2f})")
print(f"Cidade com Maior Venda: {cidade_maior_venda['cidade']} (R$ {cidade_maior_venda['valor_total']:,.2f})")
print("=" * 50)

# SALVAR RELATORIO
with open('dados_etl/relatorio_final.txt', 'w', encoding='utf-8') as f:
    f.write("RELATORIO DO PROJETO ETL\n")
    f.write("=" * 30 + "\n")
    f.write(f"Total de Vendas: {len(df_vendas)}\n")
    f.write(f"Valor Total: R$ {df_vendas['valor_total'].sum():,.2f}\n")
    f.write(f"Produto Mais Vendido: {produto_mais_vendido['produto']}\n")
    f.write(f"Cidade com Maior Venda: {cidade_maior_venda['cidade']}\n")

print("OK - Relatorio salvo em: dados_etl/relatorio_final.txt")

# FECHAR CONEXAO
conn.close()
print("\nOK - Conexao fechada")

print("\n=== PROJETO ETL CONCLUIDO COM SUCESSO ===")