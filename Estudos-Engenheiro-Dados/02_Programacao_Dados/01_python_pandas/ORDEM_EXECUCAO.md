# ORDEM DE EXECUCAO - PYTHON PANDAS

## ESTRUTURA DE DIRETORIOS:

### DIRETORIO ORIGEM (Modulo 1):
01_python_pandas/dados/
- clientes.csv
- produtos.csv  
- vendas.csv

### DIRETORIO PROCESSADOS (Modulo 2):
01_python_pandas/dados_processados/
- vendas_completo.csv
- clientes_completo.csv
- produtos.csv 

### DIRETORIO LIMPEZA (Modulo 3):
01_python_pandas/dados_limpos/
- dataset_limpo.csv

### DIRETORIO ANALISES (Modulos 4-5):
01_python_pandas/resultados_analise/
- pivot_categoria_mes.csv
- estatisticas_categoria.csv
- vendas_por_data.csv
- vendas_mensais.csv
- vendas_semanais.csv
- vendas_diarias_media_movel.csv

## SEQUENCIA CORRETA

1. 01_introducao_pandas.py
   - Cria: dados/vendas.csv, dados/clientes.csv

2. 02_operacoes_dataframes.py  
   - Usa: dados/
   - Cria: dados_processados/

3. 03_limpeza_dados.py
   - Usa: dados_processados/
   - Cria: dados_limpos/

4. 04_agregacoes_avancadas.py
   - Usa: dados_limpos/
   - Cria: resultados_analise/

5. 05_manipulacao_datetime.py
   - Usa: resultados_analise/
   - Cria: analises adicionais

## INSTRUCOES
- Executar um script por vez
- Verificar mensagens de confirmacao
- Conferir arquivos gerados