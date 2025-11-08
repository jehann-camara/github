# Modelagem Multidimensional em Business Intelligence

## Introdução
A modelagem multidimensional é uma técnica fundamental em Business Intelligence (BI) que organiza dados de forma intuitiva e eficiente para análise. Diferente do modelo relacional tradicional, ela é otimizada para consultas analíticas e tomada de decisões.

## Conceitos Fundamentais

### 1. Fatos
- São as medidas numéricas do negócio
- Exemplos:
    - Quantidade vendida
    - Valor total
    - Número de transações

### 2. Dimensões
- Representam as perspectivas de análise
- Fornecem contexto aos fatos
- Exemplos:
    - Tempo (ano, mês, dia)
    - Produto (categoria, subcategoria, nome)
    - Cliente (região, cidade, segmento)

    ## Tipos de Modelagem

    ### 1. Esquema Estrela
    - **Descrição**: O esquema estrela é caracterizado por uma tabela de fatos centralizada cercada por tabelas de dimensões. É o modelo mais simples e comum em data warehousing.
    - **Vantagens**:
        - Simplicidade na estrutura, facilitando a compreensão e a consulta.
        - Performance otimizada para consultas analíticas, devido à menor complexidade nas junções.
    - **Desvantagens**:
        - Pode levar à redundância de dados nas dimensões.

    ### 2. Esquema Floco de Neve
    - **Descrição**: O esquema floco de neve é uma variação do esquema estrela, onde as dimensões são normalizadas, resultando em múltiplas tabelas para cada dimensão.
    - **Vantagens**:
        - Economia de espaço em disco, pois elimina a redundância de dados.
        - Melhor organização dos dados, facilitando a manutenção.
    - **Desvantagens**:
        - Maior complexidade nas consultas, pois requer mais junções entre tabelas.
        - Performance pode ser afetada devido ao aumento no número de junções.

    ### 3. Esquema em Constelação
    - **Descrição**: Também conhecido como esquema de galáxia, combina múltiplas tabelas de fatos que compartilham dimensões comuns. É útil para análises complexas que envolvem diferentes áreas de negócio.
    - **Vantagens**:
        - Flexibilidade para análises multidimensionais em diferentes contextos.
        - Permite a integração de dados de diferentes fontes.
    - **Desvantagens**:
        - Complexidade na modelagem e manutenção.
        - Pode ser desafiador para usuários menos experientes.

    ### 4. Esquema de Data Vault
    - **Descrição**: O Data Vault é uma abordagem que se concentra na agilidade e na adaptabilidade, utilizando três tipos de tabelas: hubs, links e satellites.
    - **Vantagens**:
        - Alta flexibilidade para mudanças nos requisitos de negócios.
        - Facilita a integração de dados históricos e novos dados.
    - **Desvantagens**:
        - Pode ser mais complexo de implementar e entender.
        - Requer um bom planejamento para garantir a eficiência.

    ### 5. Esquema de Kimball
    - **Descrição**: Baseado na filosofia de que a modelagem deve ser orientada ao usuário, o esquema de Kimball enfatiza a simplicidade e a facilidade de uso.
    - **Vantagens**:
        - Foco na usabilidade e na performance das consultas.
        - Facilita a compreensão por parte dos usuários finais.
    - **Desvantagens**:
        - Pode não ser tão eficiente em termos de armazenamento quanto outras abordagens.

### 1. Esquema Estrela

- Modelo mais simples e comum
- Uma tabela de fatos central
- Dimensões diretamente conectadas
- Performance otimizada para consultas

#### Exemplo Detalhado Esquema Estrela

```plaintext
             [Dim_Tempo]
                ↑
        [Dim_Produto] ← [Fato_Vendas] → [Dim_Cliente]
                ↓
             [Dim_Region]
```

- **Descrição**: Neste exemplo, o esquema estrela é representado com uma tabela de fatos centralizada, que é a tabela de vendas, cercada por tabelas de dimensões. As dimensões de tempo, produto e cliente estão diretamente conectadas à tabela de fatos, facilitando as consultas analíticas.
- **Vantagens**:
    - Estrutura simples e intuitiva, facilitando a compreensão.
    - Performance otimizada para consultas devido à menor complexidade nas junções.
- **Desvantagens**:
    - Possibilidade de redundância de dados nas dimensões.
- **Exemplo de Consulta**:
    ```sql
    SELECT 
        d_tempo.ano,
        d_produto.categoria,
        d_cliente.regiao,
        SUM(f_vendas.valor_total) as total_vendas
    FROM fato_vendas f_vendas
    JOIN dim_tempo d_tempo ON f_vendas.id_tempo = d_tempo.id
    JOIN dim_produto d_produto ON f_vendas.id_produto = d_produto.id
    JOIN dim_cliente d_cliente ON f_vendas.id_cliente = d_cliente.id
    GROUP BY d_tempo.ano, d_produto.categoria, d_cliente.regiao
    ```


### 2. Esquema Floco de Neve
- Dimensões normalizadas
- Maior complexidade
- Economia de espaço

#### Exemplo Detalhado de Esquema Floco de Neve

```plaintext
             [Dim_Tempo]
                ↑
        [Dim_Data] ← [Dim_Mês] ← [Dim_Ano]
                ↑
[Dim_Produto] → [Fato_Vendas] ← [Dim_Cliente]
                ↓
        [Dim_Region] ← [Dim_Cidade] ← [Dim_Estado]
```

- **Descrição**: Neste exemplo, o esquema floco de neve é representado com dimensões normalizadas. As dimensões de tempo são divididas em tabelas separadas para dia, mês e ano, permitindo uma análise mais granular.
- **Vantagens**:
    - Redução da redundância de dados.
    - Melhor organização e manutenção das dimensões.
- **Desvantagens**:
    - Aumento da complexidade nas consultas devido ao maior número de junções necessárias.
- **Exemplo de Consulta**:
    ```sql
    SELECT 
        d_ano.ano,
        d_mes.mes,
        d_produto.categoria,
        d_cliente.regiao,
        SUM(f_vendas.valor_total) as total_vendas
    FROM fato_vendas f_vendas
    JOIN dim_tempo d_tempo ON f_vendas.id_tempo = d_tempo.id
    JOIN dim_ano d_ano ON d_tempo.id_ano = d_ano.id
    JOIN dim_mes d_mes ON d_tempo.id_mes = d_mes.id
    JOIN dim_produto d_produto ON f_vendas.id_produto = d_produto.id
    JOIN dim_cliente d_cliente ON f_vendas.id_cliente = d_cliente.id
    GROUP BY d_ano.ano, d_mes.mes, d_produto.categoria, d_cliente.regiao
    ```



## Métricas e Agregações

### Tipos de Métricas
1. **Aditivas**: Podem ser somadas em todas as dimensões
     - Exemplo: Valor total de vendas

2. **Semi-aditivas**: Soma permitida em algumas dimensões
     - Exemplo: Saldo em conta (somável por agência, não por tempo)

3. **Não-aditivas**: Não podem ser somadas
     - Exemplo: Percentuais, médias

## Exemplo Prático
```sql
-- Exemplo de análise multidimensional
SELECT 
        d_tempo.ano,
        d_produto.categoria,
        d_cliente.regiao,
        SUM(f_vendas.valor_total) as total_vendas,
        COUNT(f_vendas.id_venda) as qtd_vendas
FROM fato_vendas f_vendas
JOIN dim_tempo d_tempo ON f_vendas.id_tempo = d_tempo.id
JOIN dim_produto d_produto ON f_vendas.id_produto = d_produto.id
JOIN dim_cliente d_cliente ON f_vendas.id_cliente = d_cliente.id
GROUP BY d_tempo.ano, d_produto.categoria, d_cliente.regiao
```

## Boas Práticas
1. Mantenha as dimensões desnormalizadas (exceto em casos específicos)
2. Use chaves substitutas (surrogate keys)
3. Inclua campos de controle (data de carga, versão, etc.)
4. Planeje granularidade adequada
5. Documente as regras de negócio

## Considerações Finais
A modelagem multidimensional é crucial para criar um Data Warehouse eficiente. O sucesso do projeto depende de um bom entendimento do negócio e das necessidades analíticas dos usuários.