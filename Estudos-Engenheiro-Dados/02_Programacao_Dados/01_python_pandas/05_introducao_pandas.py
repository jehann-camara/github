"""
MODULO 1: INTRODUCAO AO PANDAS
Objetivos:
- Criar e manipular DataFrames
- Operacoes basicas com Pandas
- Leitura e escrita de arquivos
- Fundamentos para os proximos modulos
"""
import pandas as pd
import numpy as np
import os

print("=" * 60)
print("MODULO 1 - INTRODUCAO AO PANDAS")
print("=" * 60)

# Configuracao de diretorios
script_dir = os.path.dirname(os.path.realpath(__file__))
dados_dir = os.path.join(script_dir, 'dados')
os.makedirs(dados_dir, exist_ok=True)

print("Diretorio de dados configurado")

# Criar DataFrame de clientes
dados_clientes = {
    'id': [1, 2, 3, 4, 5],
    'nome': ['Ana Silva', 'Carlos Santos', 'Maria Oliveira', 'Joao Pereira', 'Lucia Fernandes'],
    'idade': [28, 34, 29, 42, 31],
    'cidade': ['Sao Paulo', 'Rio de Janeiro', 'Belo Horizonte', 'Porto Alegre', 'Salvador'],
    'salario': [5000, 6200, 4800, 7100, 5500]
}

df_clientes = pd.DataFrame(dados_clientes)

# Criar DataFrame de produtos
dados_produtos = [
    [101, 'Notebook Dell', 3500.00, 'Eletronicos'],
    [102, 'Mouse Logitech', 89.90, 'Perifericos'],
    [103, 'Teclado Mecanico', 250.00, 'Perifericos'],
    [104, 'Monitor 24"', 1200.00, 'Eletronicos'],
    [105, 'Headphone Sony', 450.00, 'Audio']
]

df_produtos = pd.DataFrame(dados_produtos, columns=['id', 'produto', 'preco', 'categoria'])

# Criar DataFrame de vendas
np.random.seed(42)
dados_vendas = {
    'venda_id': range(1, 101),
    'produto_id': np.random.randint(101, 106, 100),
    'cliente_id': np.random.randint(1, 6, 100),
    'quantidade': np.random.randint(1, 5, 100),
    'valor_venda': np.random.uniform(50, 5000, 100).round(2),
    'data_venda': pd.date_range('2024-01-01', periods=100, freq='D')
}

df_vendas = pd.DataFrame(dados_vendas)

# Salvar os DataFrames
df_clientes.to_csv(os.path.join(dados_dir, 'clientes.csv'), index=False)
df_produtos.to_csv(os.path.join(dados_dir, 'produtos.csv'), index=False)
df_vendas.to_csv(os.path.join(dados_dir, 'vendas.csv'), index=False)

print("Arquivos salvos em:")
print(f" - {os.path.join(dados_dir, 'clientes.csv')}")
print(f" - {os.path.join(dados_dir, 'produtos.csv')}")
print(f" - {os.path.join(dados_dir, 'vendas.csv')}")

# Verificacao
arquivos = ['clientes.csv', 'produtos.csv', 'vendas.csv']
for arquivo in arquivos:
    caminho = os.path.join(dados_dir, arquivo)
    if os.path.exists(caminho):
        print(f"ARQUIVO GERADO: {arquivo}")
    else:
        print(f"FALHA: {arquivo}")

print("MODULO 1 CONCLUIDO")