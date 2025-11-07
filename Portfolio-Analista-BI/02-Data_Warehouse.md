# Resumo detalhado: conceitos fundamentais e fluxo de um Data Warehouse ( Armazém de dados)

Este documento apresenta, de forma concisa e prática, os conceitos-chave de um Data Warehouse (DW), o fluxo típico de dados e exemplos comentados para facilitar entendimento e implementação.

---

## 1. Visão geral
- Data Warehouse: repositório centralizado de dados históricos, organizado para análise e tomada de decisão (OLAP).
- Objetivo: integrar dados heterogêneos, garantir consistência temporal, otimizar consultas analíticas e suportar relatórios e BI.
- Diferença principal: OLTP (transações) vs OLAP (análise/histórico).
- Propriedades: Não Volátil, Integração e Padronização, Orientação ao Tempo, Orientado ao Assunto.

---

## 2. Componentes fundamentais
- Fontes de Dados: sistemas transacionais, arquivos, APIs, logs, outras bases.
- Staging (área de preparação): cópia bruta temporária das fontes para validação e limpeza.
- ETL/ELT:
    - ETL: Extract → Transform → Load (transformações antes do carregamento no DW).
    - ELT: Extract → Load → Transform (carrega primeiro, transforma no destino).
- Data Warehouse (modelo dimensional ou relacional): armazenagem central (físico ou em nuvem).
- Data Marts: subconjuntos orientados a departamentos/temas.
- Metadata & Catálogo: descrição das tabelas, dicionário e lineage.
- Governança e Qualidade: regras, SLA, mascaramento e segurança.

---

## 3. Modelagem: fatos e dimensões
- Fato: eventos métricos (ex.: vendas), contém medidas numéricas e chaves para dimensões.
- Dimensão: contexto/atributos (ex.: cliente, produto, tempo).
- Granularidade: nível de detalhe da tabela fato (ex.: por transação, por item).
- Schemas comuns:
    - Estrela (Star): fato central + dimensões desnormalizadas — fácil para usuários.
    - Floco de Neve (Snowflake): dimensões normalizadas — economia de espaço.
    - Galaxy (constellation): múltiplas fatos compartilhando dimensões.

Exemplo conceitual:
- Fato_Vendas(id_venda, data_id, cliente_id, produto_id, qtde, valor_total)
- Dim_Cliente(cliente_id, nome, segmento, cidade)
- Dim_Produto(produto_id, sku, categoria, marca)
- Dim_Tempo(data_id, data, mes, trimestre, ano)

---

## 4. Slowly Changing Dimensions (SCD)
- SCD Tipo 1: sobrescrever atributos (perde histórico).
- SCD Tipo 2: preservar histórico com versões (data_início, data_fim, current_flag).
- SCD Tipo 3: armazenar apenas o valor anterior (coluna extra).

Exemplo SCD Tipo 2 (pseudo-ETL):
```sql
-- checar cliente existente
IF EXISTS (SELECT 1 FROM dim_cliente WHERE business_key = @bk AND current_flag = 1)
BEGIN
    IF dados mudaram THEN
        -- encerrar registro antigo
        UPDATE dim_cliente SET data_fim = @hoje, current_flag = 0 WHERE business_key = @bk AND current_flag = 1;
        -- inserir novo registro com nova surrogate key
        INSERT INTO dim_cliente (surrogate_id, business_key, nome, segmento, data_inicio, data_fim, current_flag)
        VALUES (@new_sk, @bk, @nome, @segmento, @hoje, '9999-12-31', 1);
    END
END
ELSE
    INSERT ... -- novo cliente
```
(comentário: business_key = chave natural da fonte; surrogate_id = chave substituta do DW)

---

## 5. Fluxo típico (ETL/ELT) — passo a passo
1. Extração: coletar dados das fontes (batch ou streaming).
     - Ex.: full load inicial, depois delta usando timestamp ou log de transações.
2. Staging: armazenar dados brutos para auditoria e replay.
     - Comentário: facilita reprocessamento sem tocar produção.
3. Transformação:
     - Limpeza (nulos, tipos), padronização (formatos, unidades), deduplicação.
     - Enriquecimento (cálculos, geocoding), junções, regras de negócio.
4. Tratamento de SCD: aplicar lógica de dimensão (1/2/3).
5. Carga no DW: inserir/atualizar fatos e dimensões.
6. Agregações e índices: criar visões/materializações para performance.
7. Exposição: BI tools, SQL, APIs, Data Marts.
8. Monitoramento e lineage: logs, alertas, métricas de SLA.

---

## 6. Exemplo prático de fluxo (venda diária)
- Fonte: sistema de vendas OLTP.
- Processo:
    1. Extrair transações desde última extração (WHERE ts > last_extract).
    2. Carregar em staging.vendas_raw.
    3. Validar esquema e dados (ex.: produtos inexistentes → direcionar para exceções).
    4. Atualizar Dim_Produto/Dim_Cliente (aplicar SCD Tipo 2).
    5. Inserir linhas em Fato_Vendas com surrogate keys das dimensões.
    6. Atualizar agregações (fato_agg_mes_produto).

Comentário: usar transações e checkpoints para evitar duplicidade em reprocessamentos.

---

## 7. Consultas típicas (exemplos SQL)
- Soma de vendas por mês e categoria:
```sql
SELECT t.ano, t.mes, p.categoria, SUM(f.valor_total) AS vendas
FROM fato_vendas f
JOIN dim_tempo t ON f.data_id = t.data_id
JOIN dim_produto p ON f.produto_id = p.produto_id
GROUP BY t.ano, t.mes, p.categoria
ORDER BY t.ano, t.mes;
```
- Retornar histórico de um cliente (SCD2):
```sql
SELECT * FROM dim_cliente WHERE business_key = 'C123' ORDER BY data_inicio;
```

---

## 8. Arquiteturas e abordagens
- Kimball (bus dimensional): DW orientado a Data Marts, modelagem dimensional; foco em entrega incremental e agilidade.
- Inmon (corporate DW): DW central normalizado, depois derivação de Data Marts; foco em arquitetura corporativa.
- Lambda/Kappa (big data): combinar batch e streaming para necessidades em tempo real.

---

## 9. Boas práticas (comentadas)
- Definir granularidade clara desde o início (muito fino = mais dados; muito grosso = perde detalhes).
- Usar chaves substitutas (surrogate keys) para estabilidade.
- Conservar metadados e lineage para auditoria e conformidade.
- Versionar pipelines ETL e testes automatizados.
- Planejar retenção e particionamento (por data) para performance.
- Monitorar qualidade (registros rejeitados, latência, volumes).

---

## 10. Considerações finais
- Data Warehouse é tanto arquitetura quanto processo: modelagem + pipelines + governança.
- Inicie por casos de negócio de alto impacto (ex.: vendas, faturamento) e evolua o DW iterativamente.
- Documentação e automação reduzem riscos: testes de regressão para ETL e validações diárias.

