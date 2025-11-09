# Arquitetura de Business Intelligence (BI)

## 1. Visão Geral
A arquitetura de Business Intelligence é um framework que organiza dados, informações e ferramentas para suportar a tomada de decisões em uma organização.

## 2. Componentes Fundamentais

### 2.1 Fontes de Dados
- **Dados Estruturados**: Bancos de dados relacionais (MySQL, SQL Server)
- **Dados Não-Estruturados**: E-mails, documentos, redes sociais
- **Dados Semi-Estruturados**: XMLs, JSONs
> Exemplo: Sistema ERP gerando dados de vendas, CRM com dados de clientes

### 2.2 ETL (Extract, Transform, Load)
1. **Extração**: Coleta de dados das fontes
2. **Transformação**: Limpeza, padronização e enriquecimento
3. **Carga**: Inserção no Data Warehouse
> Exemplo: Ferramenta SSIS extraindo dados de vendas, normalizando datas e carregando no Data Warehouse.

### 2.3 Data Warehouse (DW)
- Repositório central de dados integrados
- Modelagem dimensional (Star Schema ou Snowflake)
- Histórico de dados
> Exemplo: DW com fatos de vendas relacionados a dimensões de produtos, clientes e tempo

## 3. Camadas da Arquitetura

### 3.1 Staging Area
- Área temporária para dados brutos
- Validação inicial dos dados
> Exemplo: Tabelas temporárias para dados extraídos antes da transformação

### 3.2 Data Warehouse
- Camada empresarial
- Dados consolidados e históricos
- Otimizado para consultas

### 3.3 Data Marts
- Subconjuntos do DW
- Específicos por departamento/função
> Exemplo: Data Mart de Vendas, Data Mart Financeiro

### 3.4 Camada de Apresentação
- Ferramentas de visualização
- Dashboards e relatórios
- Analytics
> Exemplo: Power BI, Tableau, QlikView

## 4. Fluxo de Dados

1. Coleta das fontes de dados
2. Processamento ETL
3. Armazenamento no DW
4. Distribuição para Data Marts
5. Análise e visualização

## 5. Boas Práticas

- Documentação detalhada
- Governança de dados
- Políticas de backup
- Monitoramento de performance
- Segurança e controle de acesso

## 6. Benefícios

- Decisões baseadas em dados
- Visão única da verdade
- Histórico consistente
- Análises complexas
- Escalabilidade : Um sistema escalável é aquele que cresce sem quebrar — ou seja, mantém bom desempenho mesmo com mais dados, usuários e relatórios.

## 7. Desafios Comuns

- Qualidade dos dados
- Integração de fontes diversas
- Performance do DW
- Custos de infraestrutura
- Manutenção contínua

> **Nota**: A arquitetura pode variar conforme as necessidades específicas de cada organização.

## 8. Resumo BI

Business Intelligence (BI) é um conjunto de processos, tecnologias e ferramentas que transformam dados brutos em informações úteis para tomada de decisões nos negócios. Principais aspectos:

- **Objetivo**: Suportar decisões estratégicas com dados
- **Processo**: Coleta, transformação e análise de dados
- **Componentes**: ETL, Data Warehouse, ferramentas analíticas
- **Resultados**: Dashboards, relatórios e insights acionáveis

O BI permite que organizações:
- Identifiquem tendências
- Otimizem operações
- Melhorem eficiência
- Aumentem vantagem competitiva

## 9. Técnicas Envolvidas

- Data Warehouse;
- OLTP X OLAP;
- Metadados;
- Dimensões;
- Fatos;
- Data Mining;
- Big Data;