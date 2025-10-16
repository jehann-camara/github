
"""
ROADMAP ENGENHARIA DE DADOS - CONEXAO PERSONALIZADA
Configuracao testada e funcionando para seu ambiente
"""

import pyodbc

def conectar_sql_server():
    """Conecta ao SQL Server usando sua configuracao especifica"""
    
    connection_string = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=G\SQLEXPRESS;"
        "DATABASE=RoadmapEngenhariaDados;"
        "Trusted_Connection=yes;"
        "Encrypt=yes;"
        "TrustServerCertificate=yes;"
    )
    
    try:
        conn = pyodbc.connect(connection_string)
        print("OK - Conexao estabelecida com sucesso!")
        return conn
    except pyodbc.Error as e:
        print(f"ERRO na conexao: {e}")
        return None

# Exemplo de uso
if __name__ == "__main__":
    conn = conectar_sql_server()
    if conn:
        # Suas operacoes aqui
        conn.close()
        print("OK - Conexao fechada")
