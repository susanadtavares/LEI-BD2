from django import forms
from .models import Docente, InscricaoTurno, Aluno, Turno, UnidadeCurricular

class DocenteCreateForm(forms.Form):
    nome = forms.CharField(max_length=255, label="Nome")
    email = forms.EmailField(max_length=255, label="Email")

class DocenteUpdateForm(forms.ModelForm):
    class Meta:
        model = Docente
        fields = ["nome", "email"]

class InscricaoCreateForm(forms.Form):
    n_mecanografico = forms.ChoiceField(label="Aluno")
    id_turno = forms.ChoiceField(label="Turno", required=False)
    id_unidadecurricular = forms.ChoiceField(label="Unidade Curricular")
    data_inscricao = forms.DateField(widget=forms.DateInput(attrs={"type": "date"}), label="Data")

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["n_mecanografico"].choices = [
            (a.n_mecanografico, f"{a.n_mecanografico} - {a.nome}")
            for a in Aluno.objects.order_by("n_mecanografico")
        ]
        self.fields["id_turno"].choices = [("", "— Sem turno —")] + [
            (t.id_turno, f"{t.id_turno} - {t.n_turno} ({t.tipo})")
            for t in Turno.objects.order_by("id_turno")
        ]
        self.fields["id_unidadecurricular"].choices = [
            (u.id_unidadecurricular, f"{u.id_unidadecurricular} - {u.nome}")
            for u in UnidadeCurricular.objects.order_by("id_unidadecurricular")
        ]

class InscricaoUpdateForm(forms.ModelForm):
    class Meta:
        model = InscricaoTurno
        fields = ["n_mecanografico", "id_turno", "id_unidadecurricular", "data_inscricao"]
        widgets = {"data_inscricao": forms.DateInput(attrs={"type": "date"})}
