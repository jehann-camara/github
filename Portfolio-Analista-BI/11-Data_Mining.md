
# KDD (Knowledge Discovery in Databases)

- KDD é o processo completo de descoberta de conhecimento a partir de dados. Envolve várias etapas desde a coleta até a interpretação dos resultados.

- Etapas do KDD:

    Seleção dos dados → escolher as bases relevantes.

    Pré-processamento → limpar erros, remover duplicidades, tratar valores nulos.

    Transformação → normalizar, reduzir dimensões, criar novas variáveis.

    Data Mining → aplicar técnicas para encontrar padrões e relações.

    Interpretação e avaliação → entender os resultados e gerar conhecimento útil.

- Resumo: KDD é o “processo completo”. Data Mining é apenas uma etapa dentro dele.

# Data Mining / Mineração de dados

- Definição : Data Mining significa literalmente “mineração de dados”.
É o processo de explorar grandes volumes de dados para descobrir padrões, correlações, tendências e insights ocultos, utilizando métodos estatísticos, matemáticos e algoritmos de aprendizado de máquina.

- Em resumo: Enquanto o BI tradicional responde “o que aconteceu”, o Data Mining tenta responder “por que aconteceu” e “o que pode acontecer”.

## Tipos de tarefas no Data Mining:

- Classificação: prever categorias (ex: cliente vai comprar ou não).

- Regressão: prever valores numéricos (ex: valor de venda).

- Agrupamento (Clustering): segmentar automaticamente (ex: grupos de clientes).

- Associação: descobrir regras do tipo “quem compra X também compra Y”.

- Resumo: Data Mining = aplicação prática de algoritmos para encontrar conhecimento.

# Machine Learning (Aprendizado de Máquina)
- Machine Learning (ML) é o campo da inteligência artificial que cria algoritmos capazes de aprender padrões a partir de dados, 
  sem depender apenas de regras fixas.

# Tipos de Machine Learning:

- Supervisionado: dados com resposta correta (rótulo).

- Não supervisionado: dados sem rótulos.

- Reforço: aprende por tentativa e erro.

- Resumo: Machine Learning fornece os algoritmos usados no Data Mining.

# graph TD;
    A[KDD - Descoberta de Conhecimento] --> B[Seleção e Pré-processamento];
    A --> C[Data Mining];
    C --> D[Machine Learning];
    D --> E[Modelos e Padrões];
    E --> F[Interpretação e Geração de Conhecimento];

# Resumo Final em Tópicos

- KDD é o processo completo de transformar dados em conhecimento.

- Data Mining é a parte do KDD onde os padrões são realmente descobertos.

- Machine Learning fornece as técnicas e algoritmos usados para minerar os dados.

- Ou seja: Machine Learning → usado no Data Mining → que faz parte do KDD.

# O Data Mining envolve várias tarefas analíticas, classificadas conforme o objetivo da descoberta de conhecimento.
Essas tarefas são divididas em duas grandes categorias:
- Previsão (Predictive)
- Descrição (Descriptive)

## Tarefas Preditivas (Predictive Tasks)

- O objetivo é prever valores ou comportamentos futuros com base em dados históricos.
Usam modelos supervisionados, ou seja, dados rotulados (com variável alvo conhecida).

### Principais tipos:

  - Classificação: Atribui uma categoria a um registro com base em exemplos anteriores.
      Exemplo: Prever se um cliente vai cancelar (sim/não).

  - Regressão: Prediz um valor numérico contínuo.
      Exemplo: Estimar o valor das vendas do próximo mês.

  - Previsão (Forecasting): Variante da regressão aplicada a séries temporais.
      Exemplo: Prever demanda de produtos nos próximos dias.

- Resumo: As tarefas preditivas “olham para o passado para prever o futuro”.

## Tarefas Descritivas (Descriptive Tasks)

- O objetivo é descobrir padrões ocultos e estruturas nos dados existentes, sem variável alvo.
Usam modelos não supervisionados, ideais para exploração e segmentação.

### Principais tipos:

  - Agrupamento (Clustering): Agrupa elementos semelhantes sem rótulo prévio.
      Exemplo: Segmentar clientes por comportamento de compra.

  - Associação (Association Rules): Encontra regras de coocorrência entre itens.
      Exemplo: “Quem compra café também compra açúcar.”

  - Sumarização (Forecasting): Resume e descreve o conteúdo dos dados de forma compacta.
      Exemplo: Gerar perfis médios de clientes por faixa etária.

  - Detecção de Anomalias (Forecasting): Identifica registros fora do padrão.
      Exemplo: Detectar transações fraudulentas ou erros em medições.

- Resumo: As tarefas descritivas “explicam o que está acontecendo e por quê”.

