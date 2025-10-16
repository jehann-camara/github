"""
ROADMAP ENGENHARIA DE DADOS - MÊS 2
Script: 16_carga_dados.py
Data: 11/10/2025
Descrição: Carga de dados transformados para SQL Server usando configuração G\SQLEXPRESS
"""

import pandas as pd
import pyodbc

print("=== CARGA DE DADOS - PROJETO ETL ===")
print("Usando configuracao: G\SQLEXPRESS com ODBC Driver 17")
print("=" * 50)

def conectar_sql_server():
    """Conecta ao SQL Server usando a configuracao que funciona no seu ambiente"""
    
    # CONFIGURACAO QUE FUNCIONOU NO SEU AMBIENTE
    connection_string = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=G\\SQLEXPRESS;"
        "DATABASE=RoadmapEngenhariaDados;"
        "Trusted_Connection=yes;"
        "Encrypt=yes;"
        "TrustServerCertificate=yes;"
    )
    
    print("1. CONECTANDO AO BANCO DE DADOS:")
    print(f"   Servidor: G\\SQLEXPRESS")
    print(f"   Driver: ODBC Driver 17 for SQL Server")
    print(f"   Banco: RoadmapEngenhariaDados")
    
    try:
        conn = pyodbc.connect(connection_string)
        print("   OK - Conexao estabelecida com sucesso!")
        return conn
    except pyodbc.Error as e:
        print(f"   ERRO - Falha na conexao: {e}")
        return None

def verificar_estrutura_banco(conn):
    """Verifica e cria a estrutura necessaria no banco de dados"""
    print("\n2. VERIFICANDO ESTRUTURA DO BANCO:")
    
    try:
        cursor = conn.cursor()
        
        # Verificar se a tabela existe
        cursor.execute("""
            IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'VendasETL')
            CREATE TABLE VendasETL (
                venda_id INT,
                produto NVARCHAR(100),
                quantidade INT,
                valor_unitario DECIMAL(10,2),
                valor_total DECIMAL(10,2),
                data_venda DATE,
                cliente_id INT,
                nome NVARCHAR(100),
                cidade NVARCHAR(100),
                estado NVARCHAR(2),
                mes_venda INT,
                ano_venda INT
            )
        """)
        conn.commit()
        print("   OK - Tabela VendasETL criada/verificada")
        return True
        
    except pyodbc.Error as e:
        print(f"   ERRO na estrutura do banco: {e}")
        return False

def carregar_dados(conn):
    """Executa o carregamento dos dados transformados"""
    print("\n3. CARREGANDO DADOS TRANSFORMADOS:")
    
    try:
        # Carregar dados transformados
        print("   Lendo arquivo vendas_transformadas.csv...")
        df_vendas = pd.read_csv('dados_etl/vendas_transformadas.csv')
        print(f"   OK - {len(df_vendas)} registros carregados")
        
        cursor = conn.cursor()
        
        # Limpar tabela antes da carga
        cursor.execute("DELETE FROM VendasETL")
        print("   OK - Tabela limpa para nova carga")
        
        # Inserir dados
        registros_inseridos = 0
        for index, row in df_vendas.iterrows():
            cursor.execute("""
                INSERT INTO VendasETL 
                (venda_id, produto, quantidade, valor_unitario, valor_total, 
                 data_venda, cliente_id, nome, cidade, estado, mes_venda, ano_venda)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, 
            row['venda_id'], row['produto'], row['quantidade'], row['valor_unitario'],
            row['valor_total'], row['data_venda'], row['cliente_id'], row['nome'],
            row['cidade'], row['estado'], row['mes_venda'], row['ano_venda'])
            
            registros_inseridos += 1
        
        conn.commit()
        print(f"   OK - {registros_inseridos} registros inseridos na tabela VendasETL")
        return True
        
    except Exception as e:
        print(f"   ERRO na carga de dados: {e}")
        conn.rollback()
        return False

def verificar_carga(conn):
    """Verifica se a carga foi bem-sucedida"""
    print("\n4. VERIFICANDO CARGA:")
    
    try:
        cursor = conn.cursor()
        
        # Contar registros
        cursor.execute("SELECT COUNT(*) FROM VendasETL")
        count = cursor.fetchone()[0]
        print(f"   OK - Total de registros na tabela: {count}")
        
        # Verificar valor total
        cursor.execute("SELECT SUM(valor_total) FROM VendasETL")
        total_vendas = cursor.fetchone()[0] or 0
        print(f"   OK - Valor total de vendas: R$ {total_vendas:,.2f}")
        
        # Estatisticas por produto
        cursor.execute("""
            SELECT produto, SUM(quantidade) as total_vendido, SUM(valor_total) as valor_total
            FROM VendasETL 
            GROUP BY produto
            ORDER BY valor_total DESC
        """)
        
        print("   RESUMO POR PRODUTO:")
        produtos = cursor.fetchall()
        for produto in produtos:
            print(f"     {produto.produto}: {produto.total_vendido} unidades - R$ {produto.valor_total:,.2f}")
        
        return True
        
    except Exception as e:
        print(f"   ERRO na verificacao: {e}")
        return False

def main():
    """Funcao principal"""
    conn = None
    try:
        # Etapa 1: Conectar ao banco
        conn = conectar_sql_server()
        if not conn:
            return False
        
        # Etapa 2: Verificar estrutura
        if not verificar_estrutura_banco(conn):
            return False
        
        # Etapa 3: Carregar dados
        if not carregar_dados(conn):
            return False
        
        # Etapa 4: Verificar resultados
        if not verificar_carga(conn):
            return False
        
        print("\n" + "=" * 50)
        print("CARGA DE DADOS CONCLUIDA COM SUCESSO!")
        print("Próximo passo: Execute 17_relatorio_final.py")
        return True
        
    except Exception as e:
        print(f"\nERRO INESPERADO: {e}")
        return False
        
    finally:
        # Fechar conexão sempre
        if conn:
            conn.close()
            print("\nOK - Conexao fechada")

if __name__ == "__main__":
    success = main()
    if not success:
        print("\nSCRIPT INTERROMPIDO - Verifique os erros acima")
        exit(1)