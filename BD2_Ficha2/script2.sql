/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     24/09/2025 17:53:28                          */
/*==============================================================*/


drop index ESTA_FK;

drop index PERTENCE_FK;

drop index ALUNO_PK;

drop table ALUNO;

drop index ANO_CURRICULAR_PK;

drop table ANO_CURRICULAR;

drop index ANO_LETIVO_PK;

drop table ANO_LETIVO;

drop index CURSO_PK;

drop table CURSO;

drop index DOCENTE_PK;

drop table DOCENTE;

drop index POSSUI_FK;

drop index ESTA_CONTIDO_FK;

drop index HORARIO_PK;

drop table HORARIO;

drop index FAZ_FK;

drop index INSCRICAO_TURNO_PK;

drop table INSCRICAO_TURNO;

drop index INSCRITO2_FK;

drop index INSCRITO_FK;

drop index INSCRITO_PK;

drop table INSCRITO_UC;

drop index RELATIONSHIP_10_FK;

drop index RELATIONSHIP_9_FK;

drop index RELATIONSHIP_9_PK;

drop table LECIONA_UC;

drop index FEITA_NO_FK;

drop index TEM_FK;

drop index MATRICULA_PK;

drop table MATRICULA;

drop index SEMESTRE_PK;

drop table SEMESTRE;

drop index TURNO_PK;

drop table TURNO;

drop index RELATIONSHIP_8_FK;

drop index RELATIONSHIP_7_FK;

drop index RELATIONSHIP_7_PK;

drop table TURNO_UC;

drop index DO_FK;

drop index RELATIONSHIP_6_FK;

drop index UNIDADE_CURRICULAR_PK;

drop table UNIDADE_CURRICULAR;

/*==============================================================*/
/* Table: ALUNO                                                 */
/*==============================================================*/
create table ALUNO (
   N_MECANOGRAFICO      INT4                 not null,
   ID_CURSO             INT4                 not null,
   ID_ANOCURRICULAR     INT4                 not null,
   NOME                 VARCHAR(255)         not null,
   EMAIL                VARCHAR(255)         not null,
   PASSWORD             VARCHAR(255)         not null,
   constraint PK_ALUNO primary key (N_MECANOGRAFICO)
);

/*==============================================================*/
/* Index: ALUNO_PK                                              */
/*==============================================================*/
create unique index ALUNO_PK on ALUNO (
N_MECANOGRAFICO
);

/*==============================================================*/
/* Index: PERTENCE_FK                                           */
/*==============================================================*/
create  index PERTENCE_FK on ALUNO (
ID_CURSO
);

/*==============================================================*/
/* Index: ESTA_FK                                               */
/*==============================================================*/
create  index ESTA_FK on ALUNO (
ID_ANOCURRICULAR
);

/*==============================================================*/
/* Table: ANO_CURRICULAR                                        */
/*==============================================================*/
create table ANO_CURRICULAR (
   ID_ANOCURRICULAR     SERIAL               not null,
   ANO_CURRICULAR       VARCHAR(255)         not null,
   constraint PK_ANO_CURRICULAR primary key (ID_ANOCURRICULAR)
);

/*==============================================================*/
/* Index: ANO_CURRICULAR_PK                                     */
/*==============================================================*/
create unique index ANO_CURRICULAR_PK on ANO_CURRICULAR (
ID_ANOCURRICULAR
);

/*==============================================================*/
/* Table: ANO_LETIVO                                            */
/*==============================================================*/
create table ANO_LETIVO (
   ID_ANOLETIVO         SERIAL               not null,
   ANOLETIVO            VARCHAR(255)         not null,
   constraint PK_ANO_LETIVO primary key (ID_ANOLETIVO)
);

/*==============================================================*/
/* Index: ANO_LETIVO_PK                                         */
/*==============================================================*/
create unique index ANO_LETIVO_PK on ANO_LETIVO (
ID_ANOLETIVO
);

/*==============================================================*/
/* Table: CURSO                                                 */
/*==============================================================*/
create table CURSO (
   ID_CURSO             SERIAL               not null,
   NOME                 VARCHAR(255)         not null,
   GRAU                 VARCHAR(255)         not null,
   constraint PK_CURSO primary key (ID_CURSO)
);

/*==============================================================*/
/* Index: CURSO_PK                                              */
/*==============================================================*/
create unique index CURSO_PK on CURSO (
ID_CURSO
);

/*==============================================================*/
/* Table: DOCENTE                                               */
/*==============================================================*/
create table DOCENTE (
   ID_DOCENTE           SERIAL               not null,
   NOME                 VARCHAR(255)         not null,
   EMAIL                VARCHAR(255)         not null,
   constraint PK_DOCENTE primary key (ID_DOCENTE)
);

/*==============================================================*/
/* Index: DOCENTE_PK                                            */
/*==============================================================*/
create unique index DOCENTE_PK on DOCENTE (
ID_DOCENTE
);

/*==============================================================*/
/* Table: HORARIO                                               */
/*==============================================================*/
create table HORARIO (
   ID_HORARIO           SERIAL               not null,
   ID_ANOLETIVO         INT4                 null,
   ID_SEMESTRE          INT4                 not null,
   HORARIO              VARCHAR(255)         not null,
   constraint PK_HORARIO primary key (ID_HORARIO)
);

/*==============================================================*/
/* Index: HORARIO_PK                                            */
/*==============================================================*/
create unique index HORARIO_PK on HORARIO (
ID_HORARIO
);

/*==============================================================*/
/* Index: ESTA_CONTIDO_FK                                       */
/*==============================================================*/
create  index ESTA_CONTIDO_FK on HORARIO (
ID_SEMESTRE
);

/*==============================================================*/
/* Index: POSSUI_FK                                             */
/*==============================================================*/
create  index POSSUI_FK on HORARIO (
ID_ANOLETIVO
);

/*==============================================================*/
/* Table: INSCRICAO_TURNO                                       */
/*==============================================================*/
create table INSCRICAO_TURNO (
   ID_INSCRICAO         SERIAL               not null,
   N_MECANOGRAFICO      INT4                 not null,
   ID_TURNO             INT4                 null,
   ID_UNIDADECURRICULAR INT4                 null,
   DATA_INSCRICAO       DATE                 not null,
   constraint PK_INSCRICAO_TURNO primary key (ID_INSCRICAO)
);

/*==============================================================*/
/* Index: INSCRICAO_TURNO_PK                                    */
/*==============================================================*/
create unique index INSCRICAO_TURNO_PK on INSCRICAO_TURNO (
ID_INSCRICAO
);

/*==============================================================*/
/* Index: FAZ_FK                                                */
/*==============================================================*/
create  index FAZ_FK on INSCRICAO_TURNO (
N_MECANOGRAFICO
);

/*==============================================================*/
/* Table: INSCRITO_UC                                           */
/*==============================================================*/
create table INSCRITO_UC (
   N_MECANOGRAFICO      INT4                 not null,
   ID_UNIDADECURRICULAR INT4                 not null,
   ESTADO               BOOL                 not null,
   constraint PK_INSCRITO_UC primary key (N_MECANOGRAFICO, ID_UNIDADECURRICULAR)
);

/*==============================================================*/
/* Index: INSCRITO_PK                                           */
/*==============================================================*/
create unique index INSCRITO_PK on INSCRITO_UC (
N_MECANOGRAFICO,
ID_UNIDADECURRICULAR
);

/*==============================================================*/
/* Index: INSCRITO_FK                                           */
/*==============================================================*/
create  index INSCRITO_FK on INSCRITO_UC (
N_MECANOGRAFICO
);

/*==============================================================*/
/* Index: INSCRITO2_FK                                          */
/*==============================================================*/
create  index INSCRITO2_FK on INSCRITO_UC (
ID_UNIDADECURRICULAR
);

/*==============================================================*/
/* Table: LECIONA_UC                                            */
/*==============================================================*/
create table LECIONA_UC (
   ID_UNIDADECURRICULAR INT4                 not null,
   ID_DOCENTE           INT4                 not null,
   constraint PK_LECIONA_UC primary key (ID_UNIDADECURRICULAR, ID_DOCENTE)
);

/*==============================================================*/
/* Index: RELATIONSHIP_9_PK                                     */
/*==============================================================*/
create unique index RELATIONSHIP_9_PK on LECIONA_UC (
ID_UNIDADECURRICULAR,
ID_DOCENTE
);

/*==============================================================*/
/* Index: RELATIONSHIP_9_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_9_FK on LECIONA_UC (
ID_UNIDADECURRICULAR
);

/*==============================================================*/
/* Index: RELATIONSHIP_10_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_10_FK on LECIONA_UC (
ID_DOCENTE
);

/*==============================================================*/
/* Table: MATRICULA                                             */
/*==============================================================*/
create table MATRICULA (
   ID_MATRICULA         SERIAL               not null,
   ID_ANOLETIVO         INT4                 not null,
   N_MECANOGRAFICO      INT4                 not null,
   DATA_MATRICULA       DATE                 not null,
   ESTADO               VARCHAR(255)         not null,
   constraint PK_MATRICULA primary key (ID_MATRICULA)
);

/*==============================================================*/
/* Index: MATRICULA_PK                                          */
/*==============================================================*/
create unique index MATRICULA_PK on MATRICULA (
ID_MATRICULA
);

/*==============================================================*/
/* Index: TEM_FK                                                */
/*==============================================================*/
create  index TEM_FK on MATRICULA (
N_MECANOGRAFICO
);

/*==============================================================*/
/* Index: FEITA_NO_FK                                           */
/*==============================================================*/
create  index FEITA_NO_FK on MATRICULA (
ID_ANOLETIVO
);

/*==============================================================*/
/* Table: SEMESTRE                                              */
/*==============================================================*/
create table SEMESTRE (
   ID_SEMESTRE          SERIAL               not null,
   SEMESTRE             VARCHAR(255)         not null,
   constraint PK_SEMESTRE primary key (ID_SEMESTRE)
);

/*==============================================================*/
/* Index: SEMESTRE_PK                                           */
/*==============================================================*/
create unique index SEMESTRE_PK on SEMESTRE (
ID_SEMESTRE
);

/*==============================================================*/
/* Table: TURNO                                                 */
/*==============================================================*/
create table TURNO (
   ID_TURNO             SERIAL               not null,
   N_TURNO              INT4                 not null,
   TIPO                 VARCHAR(255)         not null,
   CAPACIDADE           INT4                 not null,
   constraint PK_TURNO primary key (ID_TURNO)
);

/*==============================================================*/
/* Index: TURNO_PK                                              */
/*==============================================================*/
create unique index TURNO_PK on TURNO (
ID_TURNO
);

/*==============================================================*/
/* Table: TURNO_UC                                              */
/*==============================================================*/
create table TURNO_UC (
   ID_TURNO             INT4                 not null,
   ID_UNIDADECURRICULAR INT4                 not null,
   constraint PK_TURNO_UC primary key (ID_TURNO, ID_UNIDADECURRICULAR)
);

/*==============================================================*/
/* Index: RELATIONSHIP_7_PK                                     */
/*==============================================================*/
create unique index RELATIONSHIP_7_PK on TURNO_UC (
ID_TURNO,
ID_UNIDADECURRICULAR
);

/*==============================================================*/
/* Index: RELATIONSHIP_7_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_7_FK on TURNO_UC (
ID_TURNO
);

/*==============================================================*/
/* Index: RELATIONSHIP_8_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_8_FK on TURNO_UC (
ID_UNIDADECURRICULAR
);

/*==============================================================*/
/* Table: UNIDADE_CURRICULAR                                    */
/*==============================================================*/
create table UNIDADE_CURRICULAR (
   ID_UNIDADECURRICULAR SERIAL               not null,
   ID_SEMESTRE          INT4                 not null,
   ID_ANOCURRICULAR     INT4                 not null,
   ECTS                 INT4                 not null,
   NOME                 VARCHAR(255)         not null,
   constraint PK_UNIDADE_CURRICULAR primary key (ID_UNIDADECURRICULAR)
);

/*==============================================================*/
/* Index: UNIDADE_CURRICULAR_PK                                 */
/*==============================================================*/
create unique index UNIDADE_CURRICULAR_PK on UNIDADE_CURRICULAR (
ID_UNIDADECURRICULAR
);

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_6_FK on UNIDADE_CURRICULAR (
ID_ANOCURRICULAR
);

/*==============================================================*/
/* Index: DO_FK                                                 */
/*==============================================================*/
create  index DO_FK on UNIDADE_CURRICULAR (
ID_SEMESTRE
);

alter table ALUNO
   add constraint FK_ALUNO_ESTA_ANO_CURR foreign key (ID_ANOCURRICULAR)
      references ANO_CURRICULAR (ID_ANOCURRICULAR)
      on delete restrict on update restrict;

alter table ALUNO
   add constraint FK_ALUNO_PERTENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table HORARIO
   add constraint FK_HORARIO_ESTA_CONT_SEMESTRE foreign key (ID_SEMESTRE)
      references SEMESTRE (ID_SEMESTRE)
      on delete restrict on update restrict;

alter table HORARIO
   add constraint FK_HORARIO_POSSUI_ANO_LETI foreign key (ID_ANOLETIVO)
      references ANO_LETIVO (ID_ANOLETIVO)
      on delete restrict on update restrict;

alter table INSCRICAO_TURNO
   add constraint FK_INSCRICA_FAZ_ALUNO foreign key (N_MECANOGRAFICO)
      references ALUNO (N_MECANOGRAFICO)
      on delete restrict on update restrict;

alter table INSCRICAO_TURNO
   add constraint FK_INSCRICA_REFERENCE_TURNO_UC foreign key (ID_TURNO, ID_UNIDADECURRICULAR)
      references TURNO_UC (ID_TURNO, ID_UNIDADECURRICULAR)
      on delete restrict on update restrict;

alter table INSCRITO_UC
   add constraint FK_INSCRITO_INSCRITO__ALUNO foreign key (N_MECANOGRAFICO)
      references ALUNO (N_MECANOGRAFICO)
      on delete restrict on update restrict;

alter table INSCRITO_UC
   add constraint FK_INSCRITO_INSCRITO__UNIDADE_ foreign key (ID_UNIDADECURRICULAR)
      references UNIDADE_CURRICULAR (ID_UNIDADECURRICULAR)
      on delete restrict on update restrict;

alter table LECIONA_UC
   add constraint FK_LECIONA__LECIONA_U_UNIDADE_ foreign key (ID_UNIDADECURRICULAR)
      references UNIDADE_CURRICULAR (ID_UNIDADECURRICULAR)
      on delete restrict on update restrict;

alter table LECIONA_UC
   add constraint FK_LECIONA__LECIONA_U_DOCENTE foreign key (ID_DOCENTE)
      references DOCENTE (ID_DOCENTE)
      on delete restrict on update restrict;

alter table MATRICULA
   add constraint FK_MATRICUL_FEITA_NO_ANO_LETI foreign key (ID_ANOLETIVO)
      references ANO_LETIVO (ID_ANOLETIVO)
      on delete restrict on update restrict;

alter table MATRICULA
   add constraint FK_MATRICUL_TEM_ALUNO foreign key (N_MECANOGRAFICO)
      references ALUNO (N_MECANOGRAFICO)
      on delete restrict on update restrict;

alter table TURNO_UC
   add constraint FK_TURNO_UC_TURNO_UC_TURNO foreign key (ID_TURNO)
      references TURNO (ID_TURNO)
      on delete restrict on update restrict;

alter table TURNO_UC
   add constraint FK_TURNO_UC_TURNO_UC2_UNIDADE_ foreign key (ID_UNIDADECURRICULAR)
      references UNIDADE_CURRICULAR (ID_UNIDADECURRICULAR)
      on delete restrict on update restrict;

alter table UNIDADE_CURRICULAR
   add constraint FK_UNIDADE__DO_SEMESTRE foreign key (ID_SEMESTRE)
      references SEMESTRE (ID_SEMESTRE)
      on delete restrict on update restrict;

alter table UNIDADE_CURRICULAR
   add constraint FK_UNIDADE__RELATIONS_ANO_CURR foreign key (ID_ANOCURRICULAR)
      references ANO_CURRICULAR (ID_ANOCURRICULAR)
      on delete restrict on update restrict;

