# Dimensões / Descritores — Resumo 

## O que são
- Dimensão: tabela ou conjunto de atributos que descrevem entidades de negócio (ex.: cliente, produto, tempo). 
- Fornece contexto para fatos, dando sentido para as (medidas/métricas).
- Descritor: atributo da dimensão que explica ou qualifica a entidade (ex.: categoria, cor, segmentação).

Comentário: dimensões respondem "quem/onde/como/quando" enquanto fatos respondem "quanto/quantidade".

## Estrutura típica
- Chave surrogate (inteira, única, gerada no DW).
- Chave natural (origem operacional).
- Atributos descritivos (strings, códigos, flags).
- Granularidade (grain): define o nível de detalhe representado pela linha da dimensão.

Exemplo de esquema simples:
```sql
Dim_Produto (
    ProdutoSK INT PRIMARY KEY,      -- surrogate key
    ProdutoID VARCHAR(50),          -- chave natural
    Nome VARCHAR(200),
    Categoria VARCHAR(100),
    Marca VARCHAR(100),
    Ativo BIT
)
```
## Surrogate Key (SK) - Conceitos
- Chave artificial gerada no DW (tipicamente INT/BIGINT).
- Independente de chaves naturais do sistema fonte.
- Sequencial, única e nunca reutilizada.

### Benefícios
- Melhor performance em joins.
- Protege contra mudanças nas chaves naturais.
- Simplifica chaves compostas.
- Facilita rastreamento de histórico (SCD).

### Uso
- Primary key em dimensões.
- Foreign key em tabelas fato.
- Sequência contínua (sem gaps) não é necessária.
Comentário: usar surrogate keys evita problemas quando chaves naturais mudam ou são compostas.

## Tipos comuns de dimensão
- Conformed: compartilhada entre vários fatos/áreas.
- Slowly Changing Dimension (SCD):
    - Type 0: nunca altera.
    - Type 1: sobrescreve o atributo (sem histórico).
    - Type 2: preserva histórico criando novas linhas (com datas/flags).
    - Type 3: mantém um número fixo de versões (ex.: atual + anterior).
- Role-playing: mesma dimensão usada em papéis diferentes (ex.: Dim_Tempo como OrderDate e ShipDate).
- Degenerate: atributos descritivos armazenados no fato (ex.: número de pedido).
- Junk / Mini-dim: pequenos atributos de baixa cardinalidade agrupados em dimensão separada.

- Qual é a principal diferença entre dimensões do tipo 1 e do tipo 2 (SCD Tipo 1 e Tipo 2)?
    Tipo 1 sobrescreve os dados, Tipo 2 mantém a história
- SCD Tipo 1 atualiza os dados sobrescrevendo os valores antigos sem manter o histórico, enquanto SCD Tipo 2 cria novos registros para capturar as mudanças nos dados, preservando o histórico de alterações.

Exemplo SCD Type 2 (simplificado):
```sql
-- Inserir nova versão quando atributo muda
INSERT INTO Dim_Cliente (...) VALUES (...);
-- Marca versão anterior como inativa
UPDATE Dim_Cliente SET DataFim = '2025-01-01' WHERE ClienteSK = 123;
```

Comentário: SCD2 exige controle de DataInicio/DataFim ou indicadores de ativo para consultas históricas.

## Hierarquias e Níveis

As hierarquias e níveis são fundamentais na modelagem de dados, especialmente em ambientes de Business Intelligence (BI) e análise de dados. Elas permitem organizar informações de forma que facilite a navegação e a análise. 

### Hierarquia Natural
Uma hierarquia natural é uma estrutura que organiza dados em níveis, onde cada nível representa uma categoria mais específica. Por exemplo, considere a hierarquia de produtos:

- **Categoria**: Eletrônicos
    - **Subcategoria**: Computadores
        - **Produto**: Laptop

Essa estrutura permite que os usuários realizem análises em diferentes níveis de detalhe, como visualizar vendas totais de eletrônicos ou detalhar as vendas de laptops especificamente.

### Uso de Hierarquias
Hierarquias são utilizadas para:
- **Navegação**: Facilitar a exploração de dados em relatórios e dashboards.
- **Drill-down**: Permitir que os usuários aprofundem-se em dados mais específicos a partir de uma visão geral.
- **Agregações**: Calcular totais em diferentes níveis, como somar vendas por categoria ou subcategoria.
- **Criação de Atributos Derivados**: Gerar novos atributos com base em níveis hierárquicos, como calcular impostos em diferentes níveis fiscais.

### Comentários
Modelar níveis claros dentro de hierarquias não apenas melhora a experiência do usuário, mas também otimiza a performance de consultas em sistemas OLAP (Processamento Analítico Online). Uma hierarquia bem definida pode reduzir a complexidade das consultas e melhorar a eficiência na recuperação de dados.

### Exemplo Prático
Considere uma tabela de vendas que inclui uma hierarquia de produtos. Ao realizar uma consulta, um analista pode querer saber as vendas totais por categoria:

```sql
SELECT Categoria, SUM(Vendas) AS TotalVendas
FROM Vendas
GROUP BY Categoria;
```

Neste exemplo, a consulta agrega as vendas por categoria, permitindo que o analista veja rapidamente quais categorias estão gerando mais receita.

### Resumo
Hierarquias e níveis são essenciais para a organização e análise de dados. Elas permitem uma navegação intuitiva e facilitam a realização de análises detalhadas, contribuindo para decisões mais informadas e estratégicas em ambientes de BI.

## Boas práticas (resumo)
- Definir grain explicitamente para cada dimensão.
- Normalizar quando há repetição de grupos com alto volume? Preferir denormalização para desempenho de leitura.
- Padronizar valores e tratar códigos nulos/unknown.
- Versionamento de dimensões críticas (usar SCD apropriado).
- Indexar chave surrogate e atributos usados em joins/filters.
- Conformidade: criar dimensões compartilhadas quando múltiplas áreas usam as mesmas descrições.

## Exemplos práticos
Exemplo de linhas em Dim_Tempo:
| TempoSK | Data       | Ano | Mes | Dia | Trimestre |
|---------|------------|-----|-----|-----|----------|
| 20240101| 2024-01-01 | 2024| 1   | 1   | 1        |

Exemplo de uso em consulta:
```sql
SELECT t.Ano, COUNT(*) AS Pedidos
FROM Fato_Pedido f
JOIN Dim_Tempo t ON f.TempoSK = t.TempoSK
GROUP BY t.Ano;
```

- Comentário: consultas via joins com dimensões são o padrão em star schema; manter cardinalidade e índices bem definidos melhora performance.


## Quando transformar um descritor em dimensão separada
- Quando o descritor tem contexto próprio (atributos adicionais, ciclo de vida, baixa cardinalidade repetida).
- Quando é compartilhado por múltiplos fatos.
- Quando precisa de história separada.

Resumo final: modelar dimensões é equilibrar requisito de histórico, performance e reutilização. A definição clara de grain, escolha de SCD e padronização de atributos são fundamentais para um DW/BI confiável e eficiente.