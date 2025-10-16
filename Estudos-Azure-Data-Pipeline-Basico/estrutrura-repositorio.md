
## ESTRUTURA DO REPOSITÓRIO:

   Portfolio-Azure-Data-Pipeline-Basico/
        ├── 01-azure-sql-basico/
        │   ├── scripts-sql/
        │   │   ├── 01-criacao-tabelas.sql
        │   │   ├── 02-inserts-dados.sql
        │   │   ├── 03-consultas-basicas.sql
        │   │   └── 04-consultas-intermediarias.sql
        │   └── exercicios-praticos.md
        ├── 02-data-factory-pipeline/
        │   ├── pipeline-ingestao/
        │   │   └── pipeline-ingestao-sql-to-datalake.json
        │   └── linked-services/
        │       ├── linked-service-sql-database.json
        │       └── linked-service-data-lake.json
        ├── 03-databricks-notebooks/
        │   ├── transformacao-basica/
        │   │   └── notebook-transformacao-basica.py
        │   └── processamento-dados/
        │       └── notebook-processamento-dados.py
        ├── 04-integracao-completa/
        │   ├── pipeline-end-to-end/
        │   │   └── pipeline-end-to-end.json
        │   └── documentacao/
        │       └── arquitetura.md
        └── README.md