# Características de Dimensões, Fatos e Cubos OLAP

## 1. Dimensões
As dimensões são as categorias que fornecem contexto aos dados. Elas permitem que os usuários analisem os dados de diferentes perspectivas. Cada dimensão pode ter atributos que detalham suas características.

### Exemplo:
- **Dimensão Tempo**: Pode incluir atributos como Ano, Mês e Dia.
- **Dimensão Produto**: Pode incluir atributos como Nome do Produto, Categoria e Marca.

### Comentário:
As dimensões ajudam a estruturar os dados, permitindo que os usuários façam perguntas como "Quais produtos foram vendidos em janeiro de 2023?".

## 2. Fatos
Os fatos são os dados quantitativos que são analisados. Eles geralmente representam medidas que podem ser somadas, contadas ou calculadas. Os fatos estão sempre associados a dimensões.

### Exemplo:
- **Fato Vendas**: Pode incluir medidas como Quantidade Vendida e Receita Total.

### Comentário:
Os fatos são o núcleo da análise, permitindo que os usuários respondam a perguntas como "Qual foi a receita total de vendas em 2023?".

## 3. Cubos OLAP
Os cubos OLAP são estruturas multidimensionais que permitem a análise rápida e eficiente de dados. Eles combinam dimensões e fatos, permitindo que os usuários realizem operações como drill-down (aprofundar) e roll-up (resumir).

### 3.1 Características do Cubo
Os cubos OLAP possuem quatro operações principais:

- **Slice (Fatiar)**: Permite selecionar uma "fatia" específica do cubo, filtrando por uma dimensão específica (exemplo: vendas apenas do ano 2023)

- **Dice (Dividir)**: Permite selecionar um "subcubo" através de múltiplos filtros em diferentes dimensões (exemplo: vendas de eletrônicos em São Paulo em 2023)

- **Pivot Table (Tabela Dinâmica)**: Reorganiza a visualização dos dados rotacionando as dimensões, permitindo diferentes perspectivas da mesma informação

- **Drill (Perfurar/Mergulhar)**:
    - Down: Navega do nível mais agregado para o mais detalhado (exemplo: de ano para mês)
    - Up: Navega do nível mais detalhado para o mais agregado (exemplo: de dia para mês)
    - Across: Movimenta-se entre hierarquias relacionadas, dimensões compartilhadas.

### Exemplo:
Um cubo OLAP pode ter dimensões como Tempo, Produto e Região, e fatos como Receita e Quantidade Vendida.

### Comentário:
Os cubos OLAP facilitam a visualização e a análise de grandes volumes de dados, permitindo que os usuários explorem informações de maneira interativa.

## Conclusão
As dimensões, fatos e cubos OLAP são fundamentais para a análise de dados em ambientes de Business Intelligence. Eles permitem que os usuários façam análises complexas de forma intuitiva e eficiente.  