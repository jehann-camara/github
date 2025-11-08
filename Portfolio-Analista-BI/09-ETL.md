# Resumo didático sobre ETL

## Visão geral
ETL (Extract, Transform, Load) é um processo para mover e preparar dados de fontes heterogêneas para um destino analítico (data warehouse, data lake, tabela de relatórios).  
Objetivo: garantir que os dados estejam corretos, consistentes e prontos para consumo por análises, dashboards ou modelos.

## Componentes principais
1. Extract (Extração)
    - Conectar às fontes (bancos relacionais, arquivos CSV/Parquet, APIs, logs).
    - Coletar dados brutos com mínima alteração.
    - Boas práticas: registrar timestamp da extração, usar paginação/limites para APIs, tratar timeouts.

2. Transform (Transformação)
    - Limpeza: remover duplicatas, normalizar formatos, tratar valores nulos.
    - Enriquecimento: junções (joins) com outras tabelas, cálculos (ex.: taxas, agregações), conversão de tipos e fusão de campos.
    - Regras de negócio: validações, categorização, correções de dados.
    - Idempotência: garantir que rodar a mesma transformação várias vezes produza o mesmo resultado.

3. Load (Carga)
    - Inserir/atualizar os dados no destino (append, upsert, replace).
    - Estrategias: carga completa vs incremental (CDC - change data capture).
    - Considerar performance: batch size, índices, particionamento.

## Padrões e variações
- ETL clássico: transforma antes de carregar.
- ELT: carrega os dados brutos e transforma no destino (útil em data lakes e warehouses que processam bem grandes volumes).
- Batch vs Streaming: 
  - Batch: janelas periódicas (diário, horário).
  - Streaming: processamento em tempo real ou quase real para eventos contínuos.

## Qualidade, observabilidade e governança
- Data lineage: rastrear origem e transformações.
- Métricas: contagem de registros, taxa de erro, tempo de execução.
- Alertas em falhas e logs detalhados.
- Versionamento de schemas e scripts de transformação.
- Testes: validação de dados de entrada/saída e testes de regressão.

## Exemplo didático (pseudocódigo / passos)
1. Extrair um CSV de vendas
2. Transformar: converter datas, remover vendas com valor negativo, calcular total com imposto
3. Carregar em tabela final (upsert por id_venda)

Exemplo em pseudocódigo/SQL:
```sql
-- Transformação simples em SQL (ex.: em um banco que suporta staging)
-- 1. Inserir raw em staging_vendas (já extraído)
-- 2. Limpar e transformar para tabela final vendas_dim

INSERT INTO vendas_dim (id_venda, data_venda, cliente_id, valor_total)
SELECT
  s.id_venda,
  CAST(s.data AS DATE) AS data_venda,            -- normaliza formato de data
  s.cliente_id,
  ROUND(s.valor * 1.10, 2) AS valor_total        -- aplica imposto de 10%
FROM staging_vendas s
WHERE s.valor IS NOT NULL
  AND s.valor >= 0;                               -- remove valores inválidos
```

Exemplo em Python (pandas) para um fluxo simples:
```python
import pandas as pd

# Extract: ler CSV
df = pd.read_csv("vendas.csv")

# Transform: limpeza e cálculos
df = df.drop_duplicates(subset=["id_venda"])
df = df[df["valor"].notna() & (df["valor"] >= 0)]
df["data_venda"] = pd.to_datetime(df["data_venda"], errors="coerce")
df["valor_total"] = (df["valor"] * 1.10).round(2)  # aplicar imposto

# Load: grava em um parquet ou envia para banco via upsert
df.to_parquet("vendas_parquet/part.parquet", index=False)
# ou: usar conexão DB para upsert (omitir aqui por simplicidade)
```

## Comentários práticos
- Start small: provar o fluxo com um subconjunto dos dados antes de escalar.
- Monitorar desempenho: identificar gargalos na extração (latência de API) ou na transformação (joins caros).
- Considerar segurança e compliance: mascaramento de dados sensíveis durante o pipeline.
- Automação e agendamento: usar orquestradores para dependências e retries; garantir retry/backoff em falhas transitórias.

## Checklist rápido ao projetar um ETL
- Quais são as fontes e seus formatos?
- Tem necessidade de dados em tempo real?
- Como lidar com duplicação e correção histórica?
- Como será feito o versionamento e o deploy das transformações?
- Que métricas e alertas são necessários para operação?

Resumo: ETL é a espinha dorsal da preparação de dados para análise. Projetos bem-sucedidos combinam clareza nas regras de negócio, observabilidade, e escolhas de arquitetura (ETL vs ELT, batch vs streaming) alinhadas ao volume e SLA exigidos.