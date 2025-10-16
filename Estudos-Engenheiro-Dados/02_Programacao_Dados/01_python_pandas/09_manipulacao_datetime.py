"""
05 - MANIPULACAO DE DATAS COM PANDAS
Modulo: 01_python_pandas
Pre-requisito: 04_agregacoes_avancadas.py
"""
import pandas as pd
import os
from datetime import datetime, timedelta

# Configurar diretorios
base_dir = os.path.dirname(os.path.realpath(__file__))
resultados_dir = os.path.join(base_dir, "resultados_analise")

def main():
    print("INICIANDO MANIPULACAO DE DATAS")
    print("=" * 40)
    
    try:
        # Criar dataset de exemplo para praticar
        print("1. Criando dataset de exemplo")
        
        datas = pd.date_range(start='2024-01-01', periods=30, freq='D')
        
        dados = pd.DataFrame({
            'data_venda': datas,
            'vendas': [50, 60, 45, 70, 80, 55, 65, 75, 85, 60] * 3,
            'valor': [1000, 1200, 900, 1400, 1600, 1100, 1300, 1500, 1700, 1200] * 3
        })
        
        print(f"   Dataset criado: {len(dados)} registros")
        
        # Extrair componentes de data
        print("\n2. Extraindo partes da data")
        dados['ano'] = dados['data_venda'].dt.year
        dados['mes'] = dados['data_venda'].dt.month
        dados['dia'] = dados['data_venda'].dt.day
        dados['dia_semana'] = dados['data_venda'].dt.dayofweek
        dados['nome_dia'] = dados['data_venda'].dt.day_name()
        dados['nome_mes'] = dados['data_venda'].dt.month_name()
        
        print("   Componentes extraidos:")
        print(dados[['data_venda', 'ano', 'mes', 'nome_mes', 'nome_dia']].head())
        
        # Agrupamentos por tempo
        print("\n3. Agrupando por mes")
        vendas_mensais = dados.groupby('mes').agg({
            'vendas': 'sum',
            'valor': 'sum'
        })
        
        print("   Vendas mensais:")
        print(vendas_mensais)
        
        # Analise por dia da semana
        print("\n4. Analisando por dia da semana")
        vendas_dia_semana = dados.groupby('nome_dia').agg({
            'vendas': 'mean',
            'valor': 'mean'
        }).round(2)
        
        print("   Media por dia da semana:")
        print(vendas_dia_semana)
        
        # Calculos com datas
        print("\n5. Calculos com datas")
        dados['dias_desde_inicio'] = (dados['data_venda'] - dados['data_venda'].min()).dt.days
        dados['data_entrega'] = dados['data_venda'] + timedelta(days=7)
        
        print("   Datas com calculos:")
        print(dados[['data_venda', 'dias_desde_inicio', 'data_entrega']].head())
        
        # Filtragem por data
        print("\n6. Filtrando por periodos")
        data_limite = dados['data_venda'].max() - timedelta(days=7)
        ultima_semana = dados[dados['data_venda'] > data_limite]
        
        print("   Ultima semana de vendas:")
        print(ultima_semana[['data_venda', 'vendas', 'valor']])
        
        # Salvar resultados
        print("\n7. Salvando analises")
        dados.to_csv(os.path.join(resultados_dir, "dataset_datas_completo.csv"), index=False)
        vendas_mensais.to_csv(os.path.join(resultados_dir, "vendas_mensais.csv"))
        vendas_dia_semana.to_csv(os.path.join(resultados_dir, "vendas_dia_semana.csv"))
        
        print("   Arquivos salvos em resultados_analise/")
        
        # Resumo final
        print("\n" + "=" * 40)
        print("MANIPULACAO DE DATAS CONCLUIDA")
        
    except Exception as e:
        print(f"Erro: {e}")

if __name__ == "__main__":
    main()