# Módulo 01 - Python Pandas

## Descrição
Módulo fundamental para manipulação e análise de dados utilizando a biblioteca Pandas. Estabelece a base técnica para os módulos subsequentes do roadmap de Engenharia de Dados.

## Estrutura do Diretório
01_python_pandas/
├── dados/ # Dados origem (Módulo 1)
├── dados_processados/ # Dados transformados (Módulo 2)
├── dados_limpos/ # Dados tratados (Módulo 3)
├── resultados_analise/ # Resultados analíticos (Módulos 4-5)
├── 01_introducao_pandas.py
├── 02_operacoes_dataframes.py
├── 03_limpeza_dados.py
├── 04_agregacoes_avancadas.py
├── 05_manipulacao_datetime.py
├── ORDEM_EXECUCAO.md
└── README.md (este arquivo)


## Scripts em Ordem de Execução

### 1. 01_introducao_pandas.py
- **Objetivo**: Criar datasets base para o pipeline
- **Entrada**: Nenhuma (dados gerados internamente)
- **Saída**: clientes.csv, produtos.csv, vendas.csv em `dados/`

### 2. 02_operacoes_dataframes.py
- **Objetivo**: Operações de combinação e transformação de dados
- **Entrada**: Arquivos do diretório `dados/`
- **Saída**: Arquivos processados em `dados_processados/`

### 3. 03_limpeza_dados.py
- **Objetivo**: Aplicar técnicas de limpeza e tratamento de dados
- **Entrada**: Arquivos do diretório `dados_processados/`
- **Saída**: Arquivos limpos em `dados_limpos/`

### 4. 04_agregacoes_avancadas.py
- **Objetivo**: Demonstrar operações de análise e agregação
- **Entrada**: Arquivos do diretório `dados_limpos/`
- **Saída**: Resultados analíticos em `resultados_analise/`

### 5. 05_manipulacao_datetime.py
- **Objetivo**: Trabalhar com dados temporais e séries temporais
- **Entrada**: Resultados do Módulo 4
- **Saída**: Análises temporais em `resultados_analise/`

## Como Executar

Execute os scripts na ordem numérica:

# Execute os scripts na ordem numérica:
cd 01_python_pandas
python 01_introducao_pandas.py
python 02_operacoes_dataframes.py
python 03_limpeza_dados.py
python 04_agregacoes_avancadas.py
python 05_manipulacao_datetime.py

# Dependências
    Python 3.8 ou superior
    pandas
    numpy

# Conceitos Abordados
    - Criação e manipulação de DataFrames
    - Operações de leitura/escrita de arquivos
    - Combinação de dados (merge, concat)
    - Agrupamento e agregação
    - Tratamento de valores missing e duplicatas
    - Manipulação de datas e tempos
    - Análises descritivas básicas