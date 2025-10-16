"""
ROADMAP ENGENHARIA DE DADOS - MÊS 2
Script: 15_transformacao_dados.py
Data: 11/10/2025
Descrição: Transformação e limpeza de dados para projeto ETL
"""

import pandas as pd
import numpy as np

print("=== TRANSFORMAÇÃO DE DADOS - PROJETO ETL ===")

# CARREGAR DADOS EXTRAÍDOS
print("1. CARREGANDO DADOS EXTRAÍDOS:")

df_vendas = pd.read_csv('dados_etl/vendas.csv')
df_clientes = pd.read_json('dados_etl/clientes.json')
df_produtos = pd.read_excel('dados_etl/produtos.xlsx')

print(f"OK - Vendas carregadas: {len(df_vendas)} registros")
print(f"OK - Clientes carregados: {len(df_clientes)} registros")
print(f"OK - Produtos carregados: {len(df_produtos)} registros")

# TRANSFORMAÇÃO 1: Calcular valor total das vendas
print("\n2. CALCULANDO VALOR TOTAL DAS VENDAS:")

df_vendas['valor_total'] = df_vendas['quantidade'] * df_vendas['valor_unitario']
print("OK - Coluna 'valor_total' adicionada")
print(df_vendas[['produto', 'quantidade', 'valor_unitario', 'valor_total']])

# TRANSFORMAÇÃO 2: Adicionar informações de clientes às vendas
print("\n3. ENRIQUECENDO DADOS DE VENDAS:")

# Simular cliente_id nas vendas (para demonstração)
df_vendas['cliente_id'] = [101, 102, 103, 104, 105]

# Juntar dados de clientes com vendas
df_vendas_completo = pd.merge(df_vendas, df_clientes, on='cliente_id', how='left')
print("OK - Dados de clientes unidos com vendas")
print(df_vendas_completo[['produto', 'nome', 'cidade', 'valor_total']])

# TRANSFORMAÇÃO 3: Limpeza e padronização
print("\n4. LIMPEZA E PADRONIZAÇÃO:")

# Converter data para formato datetime
df_vendas_completo['data_venda'] = pd.to_datetime(df_vendas_completo['data_venda'])
print("OK - Datas convertidas para formato datetime")

# Adicionar mês e ano da venda
df_vendas_completo['mes_venda'] = df_vendas_completo['data_venda'].dt.month
df_vendas_completo['ano_venda'] = df_vendas_completo['data_venda'].dt.year
print("OK - Mês e ano extraídos das datas")

# TRANSFORMAÇÃO 4: Agregações
print("\n5. AGREGAÇÕES BÁSICAS:")

vendas_por_cidade = df_vendas_completo.groupby('cidade')['valor_total'].sum()
print("OK - Vendas totais por cidade:")
print(vendas_por_cidade)

vendas_por_mes = df_vendas_completo.groupby('mes_venda')['valor_total'].sum()
print("\nOK - Vendas totais por mês:")
print(vendas_por_mes)

# SALVAR DADOS TRANSFORMADOS
print("\n6. SALVANDO DADOS TRANSFORMADOS:")

df_vendas_completo.to_csv('dados_etl/vendas_transformadas.csv', index=False)
vendas_por_cidade.to_csv('dados_etl/vendas_por_cidade.csv')
vendas_por_mes.to_csv('dados_etl/vendas_por_mes.csv')

print("OK - Dados transformados salvos:")
print("  - dados_etl/vendas_transformadas.csv")
print("  - dados_etl/vendas_por_cidade.csv")
print("  - dados_etl/vendas_por_mes.csv")

print("=== TRANSFORMAÇÃO CONCLUÍDA ===")