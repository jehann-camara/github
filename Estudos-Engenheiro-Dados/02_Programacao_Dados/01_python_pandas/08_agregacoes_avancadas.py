"""
04 - AGREGAÇOES BASICAS COM PANDAS
Modulo: 01_python_pandas
Pre-requisito: 03_limpeza_dados.py
"""
import pandas as pd
import os

# Configurar diretorios
base_dir = os.path.dirname(os.path.realpath(__file__))
dados_limpos_dir = os.path.join(base_dir, "dados_limpos")
resultados_dir = os.path.join(base_dir, "resultados_analise")

# Criar pasta de resultados
os.makedirs(resultados_dir, exist_ok=True)

def main():
    print("INICIANDO ANALISES DE AGREGAÇÃO")
    print("=" * 40)
    
    try:
        # Carregar dados - CORREÇÃO DO NOME DO ARQUIVO
        print("1. Carregando dados limpos")
        arquivo_vendas = os.path.join(dados_limpos_dir, "vendas_limpo.csv")  # NOME CORRETO
        vendas = pd.read_csv(arquivo_vendas)
        
        print(f"Dados carregados: {len(vendas)} registros")
        print("\nPrimeiras linhas do arquivo:")
        print(vendas.head())
        
        # Verificar colunas disponiveis
        print("\n2. Analisando estrutura dos dados")
        print("Colunas disponiveis:")
        for coluna in vendas.columns:
            print(f"  - {coluna}")
        
        # Escolher coluna para agrupamento
        coluna_agrupamento = None
        for coluna in vendas.columns:
            if vendas[coluna].dtype == 'object' or vendas[coluna].nunique() < 10:
                coluna_agrupamento = coluna
                break
        
        if coluna_agrupamento is None:
            print("Criando coluna de exemplo para agrupamento...")
            vendas['categoria_exemplo'] = ['A', 'B', 'C'] * (len(vendas) // 3 + 1)
            vendas = vendas[:len(vendas)]
            coluna_agrupamento = 'categoria_exemplo'
        
        print(f"Usando coluna para agrupamento: {coluna_agrupamento}")
        
        # Agrupamento basico
        print(f"\n3. Agrupando por {coluna_agrupamento}")
        grupo = vendas.groupby(coluna_agrupamento)
        
        # Encontrar coluna numerica para analise
        colunas_numericas = vendas.select_dtypes(include=['number']).columns
        if len(colunas_numericas) > 0:
            coluna_numerica = colunas_numericas[0]
            resumo = grupo.agg({
                coluna_numerica: ['sum', 'mean', 'count']
            })
            resumo.columns = [f'total_{coluna_numerica}', f'media_{coluna_numerica}', 'qtd_registros']
        else:
            # Contagem simples se nao houver colunas numericas
            resumo = grupo.size().to_frame('qtd_registros')
        
        resumo = resumo.round(2)
        print("Resultado do agrupamento:")
        print(resumo)
        
        # Analise de top valores
        print("\n4. Analisando top valores")
        if len(colunas_numericas) > 0 and coluna_agrupamento:
            top_valores = vendas.groupby(coluna_agrupamento).agg({
                colunas_numericas[0]: 'sum'
            }).nlargest(5, colunas_numericas[0])
            
            print(f"Top 5 por {colunas_numericas[0]}:")
            print(top_valores)
        
        # Salvar resultados
        print("\n5. Salvando resultados")
        resumo.to_csv(os.path.join(resultados_dir, "agrupamento_principal.csv"))
        
        if 'top_valores' in locals():
            top_valores.to_csv(os.path.join(resultados_dir, "top_valores.csv"))
        
        # Salvar dados completos para referencia
        vendas.to_csv(os.path.join(resultados_dir, "dados_completos.csv"), index=False)
        
        print("Arquivos salvos em resultados_analise/")
        
        # Resumo final
        print("\n" + "=" * 40)
        print("ANALISES CONCLUIDAS")
        print(f"Local: {resultados_dir}")
        
    except Exception as e:
        print(f"Erro: {e}")

if __name__ == "__main__":
    main()