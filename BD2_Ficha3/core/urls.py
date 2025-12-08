from django.urls import path
from . import views

urlpatterns = [
    path("", views.home, name="home"),

    # ---------- DOCENTES CRUD ----------
    path("docentes/", views.docente_list, name="docente_list"),
    path("docentes/novo/", views.docente_create, name="docente_create"),
    path("docentes/<int:pk>/editar/", views.docente_update, name="docente_update"),
    path("docentes/<int:pk>/apagar/", views.docente_delete, name="docente_delete"),

    # ---------- INSCRIÇÕES CRUD ----------
    path("inscricao/", views.inscricao_list, name="inscricao_list"),
    path("inscricao/novo/", views.inscricao_create, name="inscricao_create"),
    path("inscricao/<int:pk>/editar/", views.inscricao_update, name="inscricao_update"),
    path("inscricao/<int:pk>/apagar/", views.inscricao_delete, name="inscricao_delete"),

    # ---------- RELATÓRIOS PEDIDOS ----------
    # Docente que leciona mais UCs no ano letivo corrente
    path("relatorios/top-docente-uc/", views.top_docente_uc_corrente, name="top_docente_uc"),
    # Alunos com inscrições em 2025
    path("relatorios/alunos-inscricoes-2025/", views.alunos_inscricoes_2025, name="alunos_inscricoes_2025"),

    # ---------- (páginas extra que já tinhas) ----------
    path("docente/top/", views.docente_top, name="docente_top"),  # versão antiga
    path("inscricoes/ano/", views.inscricoes_por_ano, name="inscricoes_por_ano"),
]
