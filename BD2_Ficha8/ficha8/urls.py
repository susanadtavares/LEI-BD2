from django.contrib import admin
from django.urls import path
from cursos.views import lista_cursos, seed_curso

urlpatterns = [
    path('admin/', admin.site.urls),
    path('cursos/', lista_cursos, name='lista_cursos'),
    path('seed/', seed_curso, name='seed_curso'),  # rota temporária para inserir dados
]
