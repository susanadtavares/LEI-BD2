from django.http import HttpResponse
from django.shortcuts import render
from ficha8.db import get_db

def seed_curso(request):
    """INSERÇÃO TEMPORÁRIA: mete 1 curso na BD para testares. Depois podes apagar esta view."""
    db = get_db()
    # só insere se ainda não existir esse registo
    if not db.cursos.find_one({"nome": "Engenharia Informática", "instituicoes.sigla": "ESTGV"}):
        db.cursos.insert_one({
            "nome": "Engenharia Informática",
            "grau": "Licenciatura - 1.º ciclo",
            "area_cientifica": ["Informática"],
            "ects": 180,
            "estado": "Ativo",
            "registos": [
                {"codigo": "R/A-Cr 54/2021/AL01", "data": "2021-07-15"}
            ],
            "instituicoes": [
                {
                    "sigla": "ESTGV",
                    "nome": "Escola Superior de Tecnologia e Gestão de Viseu",
                    "politecnico": "Instituto Politécnico de Viseu",
                    "distrito": "Viseu"
                }
            ],
            "tags": ["Viseu", "Informática", "Engenharia"]
        })
        return HttpResponse("OK: curso ESTGV inserido.")
    return HttpResponse("Já existia, não inseri.")

def lista_cursos(request):
    """Lista com as colunas da Figura 2 (usa aggregation)."""
    db = get_db()

    pipeline = [
        {"$project": {
            "_id": 0,
            "Registo": {
                "$let": {
                    "vars": {"cods": {"$map": {"input": "$registos", "as": "r", "in": "$$r.codigo"}}},
                    "in": {"$arrayElemAt": ["$$cods", 0]}
                }
            },
            "Denominacao": "$nome",
            "ECTS": "$ects",
            "Estado": "$estado",
            "Instituicoes": {"$map": {"input": "$instituicoes", "as": "i", "in": "$$i.nome"}}
        }},
        {"$sort": {"Denominacao": 1}}
    ]

    cursos = list(db.cursos.aggregate(pipeline))
    return render(request, "cursos/lista.html", {"cursos": cursos})
