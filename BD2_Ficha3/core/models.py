from django.db import models

class Docente(models.Model):
    id_docente = models.AutoField(primary_key=True)
    nome = models.CharField(max_length=255)
    email = models.CharField(max_length=255)

    class Meta:
        db_table = 'docente'
        managed = False

    def __str__(self):
        return f"{self.nome} <{self.email}>"

class Aluno(models.Model):
    n_mecanografico = models.IntegerField(primary_key=True)
    nome = models.CharField(max_length=255)

    class Meta:
        db_table = 'aluno'
        managed = False

class Turno(models.Model):
    id_turno = models.AutoField(primary_key=True)
    n_turno = models.IntegerField()
    tipo = models.CharField(max_length=255)

    class Meta:
        db_table = 'turno'
        managed = False

class UnidadeCurricular(models.Model):
    id_unidadecurricular = models.AutoField(primary_key=True)
    nome = models.CharField(max_length=255)

    class Meta:
        db_table = 'unidade_curricular'
        managed = False

class InscricaoTurno(models.Model):
    id_inscricao = models.AutoField(primary_key=True)
    n_mecanografico = models.IntegerField()
    id_turno = models.IntegerField(null=True, blank=True)
    id_unidadecurricular = models.IntegerField()
    data_inscricao = models.DateField()

    class Meta:
        db_table = 'inscricao_turno'
        managed = False
