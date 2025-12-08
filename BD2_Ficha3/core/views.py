from django.shortcuts import render, redirect, get_object_or_404
from django.db import connection
from django.contrib import messages
from .models import Docente, InscricaoTurno
from .forms import (
    DocenteCreateForm, DocenteUpdateForm,
    InscricaoCreateForm, InscricaoUpdateForm
)

def home(request):
    return render(request, "core/home.html")

# ---------- DOCENTES ----------
def docente_list(request):
    docentes = Docente.objects.order_by("id_docente")
    return render(request, "core/docente_list.html", {"docentes": docentes})

def docente_create(request):
    form = DocenteCreateForm(request.POST or None)
    if request.method == "POST" and form.is_valid():
        try:
            with connection.cursor() as cur:
                cur.execute("CALL public.sp_adicionar_docente(%s, %s)",
                            [form.cleaned_data["nome"], form.cleaned_data["email"]])
            messages.success(request, "Docente criado.")
            return redirect("docente_list")
        except Exception as e:
            messages.error(request, f"Erro: {e}")
    return render(request, "core/docente_form.html", {"form": form, "titulo": "Novo Docente"})

def docente_update(request, pk):
    docente = get_object_or_404(Docente, pk=pk)
    form = DocenteUpdateForm(request.POST or None, instance=docente)
    if request.method == "POST" and form.is_valid():
        form.save()
        messages.success(request, "Docente atualizado.")
        return redirect("docente_list")
    return render(request, "core/docente_form.html", {"form": form, "titulo": f"Editar Docente #{pk}"})

def docente_delete(request, pk):
    docente = get_object_or_404(Docente, pk=pk)
    if request.method == "POST":
        with connection.cursor() as cur:
            cur.execute("DELETE FROM docente WHERE id_docente=%s", [pk])
        messages.success(request, "Docente apagado.")
        return redirect("docente_list")
    return render(request, "core/confirm_delete.html", {"obj": docente, "voltar": "docente_list"})

# ---------- INSCRIÇÕES ----------
def inscricao_list(request):
    inscricoes = InscricaoTurno.objects.order_by("-data_inscricao", "-id_inscricao")
    return render(request, "core/inscricao_list.html", {"inscricoes": inscricoes})

def inscricao_create(request):
    form = InscricaoCreateForm(request.POST or None)
    if request.method == "POST" and form.is_valid():
        cd = form.cleaned_data
        id_turno = cd["id_turno"] or None
        try:
            with connection.cursor() as cur:
                cur.execute("CALL public.sp_adicionar_inscricao_turno(%s,%s,%s,%s)",
                            [cd["n_mecanografico"], id_turno,
                             cd["id_unidadecurricular"], cd["data_inscricao"]])
            messages.success(request, "Inscrição criada.")
            return redirect("inscricao_list")
        except Exception as e:
            messages.error(request, f"Erro: {e}")
    return render(request, "core/inscricao_form.html", {"form": form, "titulo": "Nova Inscrição"})

def inscricao_update(request, pk):
    insc = get_object_or_404(InscricaoTurno, pk=pk)
    form = InscricaoUpdateForm(request.POST or None, instance=insc)
    if request.method == "POST" and form.is_valid():
        form.save()
        messages.success(request, "Inscrição atualizada.")
        return redirect("inscricao_list")
    return render(request, "core/inscricao_form.html", {"form": form, "titulo": f"Editar Inscrição #{pk}"})

def inscricao_delete(request, pk):
    insc = get_object_or_404(InscricaoTurno, pk=pk)
    if request.method == "POST":
        with connection.cursor() as cur:
            cur.execute("DELETE FROM inscricao_turno WHERE id_inscricao=%s", [pk])
        messages.success(request, "Inscrição apagada.")
        return redirect("inscricao_list")
    return render(request, "core/confirm_delete.html", {"obj": insc, "voltar": "inscricao_list"})

def top_docente_uc_corrente(request):
    """
    View Django que lê a VIEW SQL:
    public.v_top_docente_uc_ano_corrente
    (docente que leciona mais UCs no ano letivo corrente)
    """
    row = None
    with connection.cursor() as cur:
        cur.execute("""
            SELECT id_docente, nome, email, total_ucs
            FROM public.v_top_docente_uc_ano_corrente;
        """)
        row = cur.fetchone()
    return render(request, "core/top_docente_uc.html", {"row": row})

def alunos_inscricoes_2025(request):
    """
    View Django que lê a VIEW SQL:
    public.v_alunos_inscricoes_2025
    (todos os alunos com data de inscrição em 2025)
    """
    rows = []
    with connection.cursor() as cur:
        cur.execute("""
            SELECT id_inscricao, data_inscricao, n_mecanografico, aluno_nome,
                   aluno_email, id_unidadecurricular, uc_nome, id_turno
            FROM public.v_alunos_inscricoes_2025;
        """)
        rows = cur.fetchall()
    return render(request, "core/alunos_inscricoes_2025.html", {"rows": rows})

def docente_top(request):
    row = None
    with connection.cursor() as cur:
        cur.execute("""
            SELECT id_docente, nome, email, total_ucs
            FROM vw_docente_ucs
            ORDER BY total_ucs DESC
            LIMIT 1
        """)
        row = cur.fetchone()
    return render(request, "core/docente_top.html", {"row": row})

def inscricoes_por_ano(request):
    ano = int(request.GET.get("ano", 2025))
    with connection.cursor() as cur:
        cur.execute("""
            SELECT id_inscricao, data_inscricao, n_mecanografico, aluno_nome,
                   id_unidadecurricular, uc_nome, id_turno, n_turno, tipo
            FROM vw_inscricoes_detalhe
            WHERE EXTRACT(YEAR FROM data_inscricao) = %s
            ORDER BY data_inscricao DESC
        """, [ano])
        rows = cur.fetchall()
    return render(request, "core/inscricoes_depois.html", {"rows": rows, "ano": ano})
