"""
SCRIPT 23: AZURE BLOB STORAGE
Nível: Básico
Foco: Armazenamento de objetos e arquivos
"""

class BlobStorageConceitos:
    def __init__(self):
        self.tipos_blob = {
            "Block Blob": "Arquivos texto/binários - Mais comum",
            "Append Blob": "Dados de log - Apenas append",
            "Page Blob": "Discos VM - Acesso aleatório"
        }
        
        self.niveis_acesso = [
            "Hot - Acesso frequente",
            "Cool - Acesso infrequente", 
            "Archive - Acesso raro"
        ]
    
    def exemplo_uso_etl(self):
        uso = {
            "entrada": "arquivos CSV/JSON brutos",
            "processamento": "arquivos temporários",
            "saida": "resultados processados",
            "backup": "cópias de segurança"
        }
        return uso

def conceitos_armazenamento():
    blob = BlobStorageConceitos()
    
    print("=== CONCEITOS BLOB STORAGE ===")
    print("\nTipos de Blob:")
    for tipo, descricao in blob.tipos_blob.items():
        print(f" {tipo}: {descricao}")
    
    print("\nNíveis de Acesso:")
    for nivel in blob.niveis_acesso:
        print(f" {nivel}")
    
    print("\nUso em ETL:")
    uso = blob.exemplo_uso_etl()
    for finalidade, descricao in uso.items():
        print(f" {finalidade}: {descricao}")

if __name__ == "__main__":
    conceitos_armazenamento()