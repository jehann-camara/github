# Python – Semana 7: Fundamentos (VSCode)
# Autor: Jehann Câmara 
# Objetivo: exemplos executáveis do básico ao intermediário leve, com boas práticas.

from __future__ import annotations

from pathlib import Path
from typing import Iterable, Any
from datetime import datetime


# ----------------------------
# Utilidades gerais
# ----------------------------

def log(msg: str) -> None:
    agora = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{agora}] {msg}")


# ----------------------------
# 1) Tipos e operações básicas
# ----------------------------

def exemplos_basicos() -> None:
    idade: int = 34
    preco: float = 199.90
    ativo: bool = True
    nome: str = "Jehann"
    tags: list[str] = ["sql", "python", "bi"]
    perfil: dict[str, Any] = {"nome": nome, "cidade": "Fortaleza", "ativo": ativo}

    log(f"idade={idade}, preco={preco}, ativo={ativo}")
    log(f"tags={tags}, perfil={perfil}")

    # Strings
    s = "  dados, análise, python  "
    s = s.strip().lower()
    partes = [p.strip() for p in s.split(",")]
    log(f"strings -> {partes}")


# ----------------------------
# 2) Controle de fluxo
# ----------------------------

def par_ou_impar(n: int) -> str:
    return "par" if n % 2 == 0 else "impar"


def loop_demo() -> None:
    for i in range(1, 6):
        log(f"for i={i}")
    i = 0
    while i < 3:
        log(f"while i={i}")
        i += 1


# ----------------------------
# 3) Funções com type hints
# ----------------------------

def ticket_medio(valores: Iterable[float]) -> float:
    valores = list(valores)
    if not valores:
        return 0.0
    return sum(valores) / len(valores)


def normaliza_nome(s: str) -> str:
    # remove espaços extras e capitaliza
    palavras = [p for p in s.strip().split() if p]
    return " ".join(p.capitalize() for p in palavras)


# ----------------------------
# 4) Arquivos e Pathlib
# ----------------------------

def escreve_e_ler_resultados(path: Path) -> dict[str, Any]:
    import json
    dados = {"media": 42.5, "itens": 10}
    path.write_text(json.dumps(dados, ensure_ascii=False, indent=2), encoding="utf-8")
    lido = json.loads(path.read_text(encoding="utf-8"))
    return lido


# ----------------------------
# 5) Desafio: ticket médio por cidade (CSV)
# ----------------------------
# Arquivo esperado: vendas.csv com cabeçalho: cidade,valor
# Exemplo:
# Fortaleza,100.0
# Recife,200.0
# Fortaleza,300.0

def ticket_medio_por_cidade_csv(path_csv: Path) -> dict[str, float]:
    soma: dict[str, float] = {}
    cont: dict[str, int] = {}
    with path_csv.open("r", encoding="utf-8") as f:
        header = f.readline()  # descarta cabeçalho
        for linha in f:
            if not linha.strip():
                continue
            cidade, valor_str = linha.strip().split(",")
            valor = float(valor_str)
            soma[cidade] = soma.get(cidade, 0.0) + valor
            cont[cidade] = cont.get(cidade, 0) + 1
    return {c: (soma[c] / cont[c]) for c in soma}


# ----------------------------
# Execução direta (VSCode)
# ----------------------------

if __name__ == "__main__":
    log("Iniciando exemplos da Semana 7...")
    exemplos_basicos()
    log(f"7 é {par_ou_impar(7)}; 8 é {par_ou_impar(8)}")
    loop_demo()

    valores = [100, 200, 300]
    log(f"ticket_medio({valores}) = {ticket_medio(valores):.2f}")
    log(f"normaliza_nome('  jehann   câmara  ') -> '{normaliza_nome('  jehann   câmara  ')}'")

    # Arquivos
    saida = Path("resultados.json")
    lido = escreve_e_ler_resultados(saida)
    log(f"conteudo lido de {saida}: {lido}")

    # Desafio CSV (opcional): crie 'vendas.csv' no mesmo diretório antes de executar
    csv = Path("vendas.csv")
    if csv.exists():
        medias = ticket_medio_por_cidade_csv(csv)
        log(f"ticket médio por cidade: {medias}")
    else:
        log("Crie um arquivo 'vendas.csv' para testar o desafio de ticket médio por cidade.")
