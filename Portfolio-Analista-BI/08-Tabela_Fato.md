# Tabela Fato

- A Tabela Fato é um conceito fundamental em modelagem de dados, especialmente em ambientes de Data Warehouse. Ela armazena dados quantitativos que podem ser analisados e medidos. Abaixo, apresentamos um resumo didático sobre a Tabela Fato, incluindo comentários e exemplos.

- Dados **Quantitativos**, representa um **ASSUNTO** no negócio.

## Estrutura da Tabela Fato

Uma Tabela Fato geralmente contém:

- **Medidas**: Valores numéricos que representam o desempenho de um negócio. Por exemplo, vendas, receita, quantidade vendida.
- **Chaves Estrangeiras**: Referências a Tabelas Dimensão, que fornecem contexto para as medidas. Por exemplo, uma chave de produto, uma chave de cliente, e uma chave de tempo.

### Exemplo de Tabela Fato

Considere uma Tabela Fato chamada `Fato_Vendas`:

| ID_Venda | ID_Produto | ID_Cliente | ID_Tempo | Quantidade | Receita   |
|----------|------------|------------|----------|------------|-----------|
| 1        | 101        | 1001       | 20230101 | 2          | 200.00    |
| 2        | 102        | 1002       | 20230102 | 1          | 150.00    |
| 3        | 101        | 1003       | 20230103 | 3          | 300.00    |

## Granularidade da Tabela Fato

A granularidade define o nível mais detalhado de informação que uma Tabela Fato armazena:
A granularidade representa o nível de detalhe dos dados:

- **Maior Granularidade**: MENOS detalhado (mais agregado)
    - Exemplo: Vendas mensais agrupadas
    - Menos registros
    - Consultas mais rápidas

- **Menor Granularidade**: MAIS detalhado (mais atômico)
    - Exemplo: Cada venda individual
    - Mais registros
    - Consultas mais detalhadas

Lembre-se: Quanto menor a granularidade, maior o nível de detalhe.

## Métricas de Tabela Fato

As Tabelas Fato podem ser classificadas em três tipos principais, dependendo da natureza das medidas/métricas que armazenam:

1. **Métricas-Aditivas**: 
    - Medidas que podem ser somadas em qualquer nível de agregação. 
    - Exemplo: Receita total, quantidade vendida.

2. **Métricas-Semi-Aditivas**: 
    - Medidas que podem ser somadas em alguns níveis de agregação, mas não em todas as dimensões. 
    - Exemplo: Saldo de contas, onde a soma faz sentido apenas em níveis de tempo, mas não em níveis de produto.

3. **Métricas-Não Aditivas**: 
    - Medidas que não podem ser somadas. 
    - Exemplo: Taxas ou proporções, como a taxa de conversão, que não faz sentido somar.

Entender esses tipos é crucial para a modelagem eficaz de dados e para garantir que as análises sejam precisas e significativas.

### Dica de Modelagem
Sempre defina a granularidade no início do projeto, pois ela impacta diretamente:
- Volume do banco
- Velocidade das consultas
- Nível de detalhe das análises

### Comentários

- **ID_Venda**: Identificador único para cada transação.
- **ID_Produto**: Chave estrangeira que se relaciona com a Tabela Dimensão de Produtos.
- **ID_Cliente**: Chave estrangeira que se relaciona com a Tabela Dimensão de Clientes.
- **ID_Tempo**: Chave estrangeira que se relaciona com a Tabela Dimensão de Tempo.
- **Quantidade** e **Receita**: Medidas que podem ser analisadas para entender o desempenho de vendas.

### Tabela Fato Snapshot

- Definição rápida: uma Tabela Fato Snapshot armazena o estado de uma entidade ou conjunto de medidas em instantes periódicos (por exemplo, diário, mensal). Não registra eventos individuais, mas sim “fotografias” do estado ao longo do tempo.

- Características principais:
    - Periodicidade fixa (dia, mês, fim de período).
    - Normalmente uma linha por combinação de dimensões por período (ex.: conta + data).
    - Métricas frequentemente semi-aditivas (ex.: saldos) — somar ao longo de tempo geralmente não faz sentido sem tratamento.
    - Facilita consultas de ponto no tempo, tendências e cálculos de evolução.

- Uso típico:
    - Saldos de contas, inventário diário, status de clientes/reservas em uma data específica, KPIs periódicos.

- Vantagens:
    - Simplicidade para relatórios periódicos e comparações de tendência.
    - Performance de consulta para análises temporais prontas.

- Limitações / cuidados:
    - Pode consumir mais espaço dependendo da granularidade.
    - Exige definição clara de periodicidade e tratamento de dados atrasados.
    - Deve-se planejar como calcular variações (ex.: diferencia entre snapshots) e como tratar agregações temporais.

- Exemplo esquemático:
    - Colunas: ID_Conta | Data_Snapshot | Saldo_Abertura | Debitos | Creditos | Saldo_Fechamento
    - Interpretação: cada linha representa o estado da conta na data do snapshot; para evolução usar diferenciação entre datas ou funções de janela.

Dica prática: defina a granularidade e regras de atualização (horário, fusos, dados late-arriving) antes de projetar a tabela para evitar inconsistências em análises históricas.


## Conclusão

A Tabela Fato é essencial para análises de dados, pois permite que as empresas avaliem seu desempenho com base em dados quantitativos. A combinação de medidas e chaves estrangeiras proporciona uma visão abrangente e contextualizada das operações de negócios.