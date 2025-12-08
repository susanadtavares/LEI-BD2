from django.urls import path
from . import views

urlpatterns = [
    path("registar/",  views.registar_viagem,   name="registar_viagem"),
    path("consultar/", views.consultar_viagens, name="consultar_viagens"),
]
