from django.shortcuts import render
from .mongo import conexaomongo, insere_doc

# Lista simples de estações para o autocomplete 
ESTACOES = [
    "Porto-Campanhã",
    "Porto - São Bento",
    "Aveiro",
    "Coimbra-B",
    "Santarém",
    "Lisboa - Oriente",
    "Lisboa - Santa Apolónia",
    "Entrecampos",
    "Faro",
]

def registar_viagem(request):
    mensagem = None
    if request.method == "POST":
        origem  = request.POST.get("origem", "").strip()
        destino = request.POST.get("destino", "").strip()

        # até 4 paragens; vazias são ignoradas
        paragens = [request.POST.get(f"paragem{i}", "").strip() for i in range(1, 5)]
        paragens = [p for p in paragens if p][:4]

        data = request.POST.get("data", "").strip()   
        hora = request.POST.get("hora", "").strip()   

        if not origem or not destino:
            mensagem = "Origem e destino são obrigatórios."
        elif origem.lower() == destino.lower():
            mensagem = "Origem e destino não podem ser iguais."
        else:
            campos  = ["origem", "destino", "paragens", "data", "hora"]
            valores = [origem,   destino,   paragens,   data,   hora]
            insere_doc("viagens", campos, valores)
            mensagem = "Viagem registada com sucesso!"

    # Passamos a lista de estações para o datalist do template
    return render(request, "viagens/registar.html", {
        "mensagem": mensagem,
        "estacoes": ESTACOES,
    })

def consultar_viagens(request):
    filtro = {}
    origem  = request.GET.get("origem", "").strip()
    destino = request.GET.get("destino", "").strip()

    if origem:
        filtro["origem"] = origem
    if destino:
        filtro["destino"] = destino

    # Ordenar por data e depois por hora 
    resultados = list(
        conexaomongo["viagens"]
        .find(filtro, {"_id": 0})
        .sort([("data", 1), ("hora", 1)])
    )

    return render(request, "viagens/consultar.html", {
        "resultados": resultados,
        "origem": origem,
        "destino": destino
    })
