"""
02 - OPERACOES BASICAS COM DATAFRAMES
Modulo: 01_python_pandas
Pre-requisito: 01_introducao_pandas.py
"""
import pandas as pd
import os

# Configurar diretorios
base_dir = os.path.dirname(os.path.realpath(__file__))
dados_dir = os.path.join(base_dir, "dados")
dados_processados_dir = os.path.join(base_dir, "dados_processados")

# Criar pasta de dados processados se não existir
os.makedirs(dados_processados_dir, exist_ok=True)

def main():
    print("INICIANDO OPERACOES COM DATAFRAMES")
    print("=" * 40)

    try:
        # Verificar se o arquivo de dados existe
        arquivo_vendas = os.path.join(dados_dir, "vendas.csv")
        if not os.path.exists(arquivo_vendas):
            print("Arquivo vendas.csv não encontrado na pasta 'dados'.")
            print("Execute o script 01_introducao_pandas.py primeiro.")
            return

        # Carregar dados
        print("1. Carregando dados...")
        vendas = pd.read_csv(arquivo_vendas)
        print(f"   Dados carregados: {len(vendas)} registros")

        # Operacoes basicas
        print("\n2. Realizando operacoes basicas...")
        # Exemplo: Adicionar uma coluna de valor total
        if 'valor_venda' in vendas.columns and 'quantidade' in vendas.columns:
            vendas['valor_total'] = vendas['valor_venda'] * vendas['quantidade']
            print("   Coluna 'valor_total' adicionada.")

        # Exemplo: Filtrar vendas acima de 100
        vendas_acima_100 = vendas[vendas['valor_venda'] > 100]
        print(f"   Vendas acima de 100: {len(vendas_acima_100)} registros")

        # Exemplo: Ordenar por valor de venda
        vendas_ordenadas = vendas.sort_values('valor_venda', ascending=False)
        print("   Dados ordenados por valor_venda.")

        # Salvar dados processados
        print("\n3. Salvando dados processados...")
        caminho_saida = os.path.join(dados_processados_dir, "vendas_processadas.csv")
        vendas.to_csv(caminho_saida, index=False)
        print(f"   Arquivo salvo: {caminho_saida}")

        print("\n" + "=" * 40)
        print("OPERACOES CONCLUIDAS COM SUCESSO!")

    except Exception as e:
        print(f"Erro durante a execucao: {e}")

if __name__ == "__main__":
    main()