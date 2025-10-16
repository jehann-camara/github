"""
03 - LIMPEZA BASICA DE DADOS
Modulo: 01_python_pandas
Pre-requisito: 02_operacoes_dataframes.py
"""
import pandas as pd
import os

# Configurar diretorios
base_dir = os.path.dirname(os.path.realpath(__file__))
dados_processados_dir = os.path.join(base_dir, "dados_processados")
dados_limpos_dir = os.path.join(base_dir, "dados_limpos")

# Criar pasta de dados limpos
os.makedirs(dados_limpos_dir, exist_ok=True)

def main():
    print("INICIANDO LIMPEZA DE DADOS")
    print("=" * 40)

    try:
        # Verificar se arquivo existe
        arquivo_vendas = os.path.join(dados_processados_dir, "vendas_processadas.csv")
        if not os.path.exists(arquivo_vendas):
            print("Arquivo vendas_processadas.csv não encontrado na pasta 'dados_processados'.")
            print("Execute o script 02_operacoes_dataframes.py primeiro.")
            return

        # Carregar dados
        print("1. Carregando dados processados...")
        vendas = pd.read_csv(arquivo_vendas)
        print(f"   Dados carregados: {len(vendas)} registros")

        # Limpeza basica
        print("\n2. Aplicando limpeza basica...")

        # Remover duplicatas
        vendas = vendas.drop_duplicates()
        print(f"   Removidas duplicatas: {len(vendas)} registros restantes")

        # Preencher valores vazios
        colunas_categoricas = vendas.select_dtypes(include=['object']).columns
        for coluna in colunas_categoricas:
            vendas[coluna] = vendas[coluna].fillna('Outros')

        colunas_numericas = vendas.select_dtypes(include=['number']).columns
        for coluna in colunas_numericas:
            vendas[coluna] = vendas[coluna].fillna(0)

        print(f"   Pos limpeza: {len(vendas)} registros validos")

        # Salvar dados limpos
        print("\n3. Salvando dados limpos...")
        caminho_saida = os.path.join(dados_limpos_dir, "vendas_limpo.csv")
        vendas.to_csv(caminho_saida, index=False)
        print(f"   Arquivo salvo: {caminho_saida}")

        print("\n" + "=" * 40)
        print("LIMPEZA CONCLUIDA COM SUCESSO!")

    except Exception as e:
        print(f"Erro durante a execucao: {e}")

if __name__ == "__main__":
    main()