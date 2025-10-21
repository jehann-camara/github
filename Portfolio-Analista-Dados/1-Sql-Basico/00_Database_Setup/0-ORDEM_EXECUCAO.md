# 📋 ORDEM DE EXECUÇÃO - SCRIPTS SQL DO ROADMAP

## 🎯 VISÃO GERAL
Esta documentação define a **ordem correta de execução** de todos os scripts SQL do roadmap para evitar erros de dependência.

## 🚀 ORDEM PRINCIPAL DE SETUP

Execute os scripts **numericamente na seguinte ordem**:

### **FASE 1: SETUP INICIAL (OBRIGATÓRIO)**
| Ordem | Script | Descrição | Database Alvo |
|-------|--------|-----------|---------------|
| 1 | `01_setup_estudos_sql.sql` | Database simples para Mês 1 | `estudos_sql` |


### **COMANDOS DE EXECUÇÃO:**

## Na ordem exata:
SOURCE 00_Database_Setup/01_setup_estudos_sql.sql
SOURCE 00_Database_Setup/01_setup_roadmap_principal.sql
