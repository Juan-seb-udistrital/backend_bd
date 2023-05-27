/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     22/05/2023 12:57:40 p. m.                    */
/*==============================================================*/


alter table CALENDARIO
   drop constraint FK_CALENDAR_ES_TIPO_TIPOCALE;

alter table CALENDARIO
   drop constraint FK_CALENDAR_LLENA_OBRA;

alter table CALENDARIO
   drop constraint FK_CALENDAR_POSEE_ESTADO;

alter table COMPOSITOR
   drop constraint FK_COMPOSIT_VIVEN_PAIS;

alter table CONVOCATORIAESTUDIANTE
   drop constraint FK_CONVOCAT_ADMITE_INSTRUME;

alter table CONVOCATORIAESTUDIANTE
   drop constraint FK_CONVOCAT_PARTICIPA_ESTUDIAN;

alter table CONVOCATORIAESTUDIANTE
   drop constraint FK_CONVOCAT_REALIZA_OBRA;

alter table EMPLEADO
   drop constraint FK_EMPLEADO_AGRUPA_UNIDAD;

alter table EMPLEADO
   drop constraint FK_EMPLEADO_TIENE_ROL;

alter table ESTUDIANTE
   drop constraint FK_ESTUDIAN_ESTA_UNIDAD;

alter table GASTOOBRA
   drop constraint FK_GASTOOBR_ATESORA_OBRA;

alter table GASTOOBRA
   drop constraint FK_GASTOOBR_ESTIMA_LISTAGAS;

alter table INVENTARIOINSTRUMENTO
   drop constraint FK_INVENTAR_REVISA_ESTADOIN;

alter table INVENTARIOINSTRUMENTO
   drop constraint FK_INVENTAR_SE_GUARDA_INSTRUME;

alter table LABORPERSONAOBRA
   drop constraint FK_LABORPER_CONTIENEN_CALENDAR;

alter table LABORPERSONAOBRA
   drop constraint FK_LABORPER_PERTENECE_LISTAACT;

alter table LABORPERSONAOBRA
   drop constraint FK_LABORPER_PUEDE_EST_PERSONAL;

alter table LISTAACTIVIDADUD
   drop constraint FK_LISTAACT_ES_PARTE__PERIODO;

alter table LISTAGASTOSUD
   drop constraint FK_LISTAGAS_GUARDA_PERIODO;

alter table NECESITA
   drop constraint FK_NECESITA_NECESITA_OBRA;

alter table NECESITA
   drop constraint FK_NECESITA_NECESITA2_INSTRUME;

alter table OBRA
   drop constraint FK_OBRA_ALMACENA_PERIODO;

alter table OBRA
   drop constraint FK_OBRA_CLASIFICA_GENEROOB;

alter table OBRA
   drop constraint FK_OBRA_CREA_COMPOSIT;

alter table OBRA
   drop constraint FK_OBRA_SE_CREAN_PAIS;

alter table PARTICIPACIONESTUDIANTE
   drop constraint FK_PARTICIP_CONTIENE_CALENDAR;

alter table PARTICIPACIONESTUDIANTE
   drop constraint FK_PARTICIP_PARTICIPA_ESTUDIAN;

alter table PERSONALOBRA
   drop constraint FK_PERSONAL_ES_UN_EMPLEADO;

alter table PERSONALOBRA
   drop constraint FK_PERSONAL_SE_BENEFI_OBRA;

alter table UNIDAD
   drop constraint FK_UNIDAD_ES_UNIDAD;

alter table UNIDAD
   drop constraint FK_UNIDAD_ES_DE_TIPOUNID;

drop index ES_TIPO_FK;

drop index LLENA_FK;

drop index POSEE_FK;

drop table CALENDARIO cascade constraints;

drop index VIVEN_FK;

drop table COMPOSITOR cascade constraints;

drop index PARTICIPAN_FK;

drop index ADMITE_FK;

drop index REALIZA_FK;

drop table CONVOCATORIAESTUDIANTE cascade constraints;

drop index AGRUPA_FK;

drop index TIENE_FK;

drop table EMPLEADO cascade constraints;

drop table ESTADO cascade constraints;

drop table ESTADOINSTRUMENTO cascade constraints;

drop index ESTA_FK;

drop table ESTUDIANTE cascade constraints;

drop index ESTIMA_FK;

drop index ATESORA_FK;

drop table GASTOOBRA cascade constraints;

drop table GENEROOBRA cascade constraints;

drop table INSTRUMENTO cascade constraints;

drop index SE_GUARDAN_FK;

drop index REVISA_FK;

drop table INVENTARIOINSTRUMENTO cascade constraints;

drop index PUEDE_ESTAR_FK;

drop index CONTIENEN_FK;

drop index PERTENECE_FK;

drop table LABORPERSONAOBRA cascade constraints;

drop index ES_PARTE_DE_FK;

drop table LISTAACTIVIDADUD cascade constraints;

drop index GUARDA_FK;

drop table LISTAGASTOSUD cascade constraints;

drop index NECESITA_FK;

drop index NECESITA2_FK;

drop table NECESITA cascade constraints;

drop index CREA_FK;

drop index SE_CREAN_FK;

drop index CLASIFICAN_FK;

drop index ALMACENA_FK;

drop table OBRA cascade constraints;

drop table PAIS cascade constraints;

drop index CONTIENE_FK;

drop index PARTICIPA_FK;

drop table PARTICIPACIONESTUDIANTE cascade constraints;

drop table PERIODO cascade constraints;

drop index SE_BENEFICIA_FK;

drop index ES_UN_FK;

drop table PERSONALOBRA cascade constraints;

drop table ROL cascade constraints;

drop table TIPOCALENDARIO cascade constraints;

drop table TIPOUNIDAD cascade constraints;

drop index ES_DE_FK;

drop index ES_FK;

drop table UNIDAD cascade constraints;

/*==============================================================*/
/* Table: CALENDARIO                                            */
/*==============================================================*/
create table CALENDARIO (
   IDTIPOCALENPKFK      VARCHAR2(2)           not null,
   IDOBRAKFK            VARCHAR2(4)           not null,
   CONSECALENDARIO      NUMBER                not null,
   IDESTADOFK           VARCHAR2(10)          not null,
   FECHAINICIO          DATE                  not null,
   FECHAFIN             DATE                  not null,
   constraint PK_CALENDARIO primary key (IDTIPOCALENPKFK, IDOBRAKFK, CONSECALENDARIO)
);

/*==============================================================*/
/* Index: POSEE_FK                                              */
/*==============================================================*/
create index POSEE_FK on CALENDARIO (
   IDESTADOFK ASC
);

/*==============================================================*/
/* Index: LLENA_FK                                              */
/*==============================================================*/
create index LLENA_FK on CALENDARIO (
   IDOBRAKFK ASC
);

/*==============================================================*/
/* Index: ES_TIPO_FK                                            */
/*==============================================================*/
create index ES_TIPO_FK on CALENDARIO (
   IDTIPOCALENPKFK ASC
);

/*==============================================================*/
/* Table: COMPOSITOR                                            */
/*==============================================================*/
create table COMPOSITOR (
   IDCOMPOSITOR         VARCHAR2(3)           not null,
   CODPAISFK            VARCHAR2(3)           not null,
   NOMCOMPOSITOR        VARCHAR2(30)          not null,
   constraint PK_COMPOSITOR primary key (IDCOMPOSITOR)
);

/*==============================================================*/
/* Index: VIVEN_FK                                              */
/*==============================================================*/
create index VIVEN_FK on COMPOSITOR (
   CODPAISFK ASC
);

/*==============================================================*/
/* Table: CONVOCATORIAESTUDIANTE                                */
/*==============================================================*/
create table CONVOCATORIAESTUDIANTE (
   IDOBRAFK             VARCHAR2(4)           not null,
   CONSECUTIVO          NUMBER                not null,
   IDINSTRUMENTOFK      VARCHAR2(4)           not null,
   CODESTUDIANTEFK      VARCHAR2(10)          not null,
   FECHAINICIO          DATE                  not null,
   FECHAFIN             DATE                  not null,
   CALIFICACION         NUMBER                not null,
   constraint PK_CONVOCATORIAESTUDIANTE primary key (IDOBRAFK, CONSECUTIVO)
);

/*==============================================================*/
/* Index: REALIZA_FK                                            */
/*==============================================================*/
create index REALIZA_FK on CONVOCATORIAESTUDIANTE (
   IDOBRAFK ASC
);

/*==============================================================*/
/* Index: ADMITE_FK                                             */
/*==============================================================*/
create index ADMITE_FK on CONVOCATORIAESTUDIANTE (
   IDINSTRUMENTOFK ASC
);

/*==============================================================*/
/* Index: PARTICIPAN_FK                                         */
/*==============================================================*/
create index PARTICIPAN_FK on CONVOCATORIAESTUDIANTE (
   CODESTUDIANTEFK ASC
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO (
   CODUNIDADPKFK        VARCHAR2(5)           not null,
   ROLPKFK              NUMBER                not null,
   ICODEMPLEADO         VARCHAR2(40)          not null,
   NOMBREEM             VARCHAR2(30)          not null,
   APELLIDOEM           VARCHAR2(30)          not null,
   CEDULAEM             VARCHAR2(10)          not null,
   CELULAREM            VARCHAR2(10)          not null,
   constraint PK_EMPLEADO primary key (CODUNIDADPKFK, ROLPKFK, ICODEMPLEADO)
);

/*==============================================================*/
/* Index: TIENE_FK                                              */
/*==============================================================*/
create index TIENE_FK on EMPLEADO (
   ROLPKFK ASC
);

/*==============================================================*/
/* Index: AGRUPA_FK                                             */
/*==============================================================*/
create index AGRUPA_FK on EMPLEADO (
   CODUNIDADPKFK ASC
);

/*==============================================================*/
/* Table: ESTADO                                                */
/*==============================================================*/
create table ESTADO (
   IDESTADO             VARCHAR2(10)          not null,
   constraint PK_ESTADO primary key (IDESTADO)
);

/*==============================================================*/
/* Table: ESTADOINSTRUMENTO                                     */
/*==============================================================*/
create table ESTADOINSTRUMENTO (
   IDESTADOINSTRUMENTO  VARCHAR2(3)           not null,
   DESCESTADOINSTRU     VARCHAR2(15)          not null,
   constraint PK_ESTADOINSTRUMENTO primary key (IDESTADOINSTRUMENTO)
);

/*==============================================================*/
/* Table: ESTUDIANTE                                            */
/*==============================================================*/
create table ESTUDIANTE (
   CODESTUDIANTE        VARCHAR2(10)          not null,
   CODUNIDADFFK         VARCHAR2(5)           not null,
   NOMBREES             VARCHAR2(30)          not null,
   APELLIDOES           VARCHAR2(30)          not null,
   FECHAINSCRIPCION     DATE                  not null,
   FECHANACIMIENTO      DATE                  not null,
   CORREO               VARCHAR2(40)          not null,
   constraint PK_ESTUDIANTE primary key (CODESTUDIANTE)
);

/*==============================================================*/
/* Index: ESTA_FK                                               */
/*==============================================================*/
create index ESTA_FK on ESTUDIANTE (
   CODUNIDADFFK ASC
);

/*==============================================================*/
/* Table: GASTOOBRA                                             */
/*==============================================================*/
create table GASTOOBRA (
   IDPERIODOPFK         INTEGER               not null,
   CODGASTOS            VARCHAR2(5)           not null,
   CONSEC               NUMBER                not null,
   IDOBRA               VARCHAR2(4)           not null,
   FECHAGASTO           DATE                  not null,
   constraint PK_GASTOOBRA primary key (IDPERIODOPFK, CODGASTOS, CONSEC)
);

/*==============================================================*/
/* Index: ATESORA_FK                                            */
/*==============================================================*/
create index ATESORA_FK on GASTOOBRA (
   IDOBRA ASC
);

/*==============================================================*/
/* Index: ESTIMA_FK                                             */
/*==============================================================*/
create index ESTIMA_FK on GASTOOBRA (
   IDPERIODOPFK ASC,
   CODGASTOS ASC
);

/*==============================================================*/
/* Table: GENEROOBRA                                            */
/*==============================================================*/
create table GENEROOBRA (
   IDGENEROOBRA         VARCHAR2(2)           not null,
   DESCGENERO           VARCHAR2(30)          not null,
   constraint PK_GENEROOBRA primary key (IDGENEROOBRA)
);

/*==============================================================*/
/* Table: INSTRUMENTO                                           */
/*==============================================================*/
create table INSTRUMENTO (
   IDINSTRUMENTO        VARCHAR2(4)           not null,
   NOMINSTRUMENTO       VARCHAR2(40)          not null,
   constraint PK_INSTRUMENTO primary key (IDINSTRUMENTO)
);

/*==============================================================*/
/* Table: INVENTARIOINSTRUMENTO                                 */
/*==============================================================*/
create table INVENTARIOINSTRUMENTO (
   CONSECINVENTARIO     NUMBER                not null,
   IDESTADOINSTRUMENTOFK VARCHAR2(3)           not null,
   IDINSTRUMENTOPFK     VARCHAR2(4)           not null,
   FECHAINGRESO         DATE                  not null,
   constraint PK_INVENTARIOINSTRUMENTO primary key (CONSECINVENTARIO)
);

/*==============================================================*/
/* Index: REVISA_FK                                             */
/*==============================================================*/
create index REVISA_FK on INVENTARIOINSTRUMENTO (
   IDESTADOINSTRUMENTOFK ASC
);

/*==============================================================*/
/* Index: SE_GUARDAN_FK                                         */
/*==============================================================*/
create index SE_GUARDAN_FK on INVENTARIOINSTRUMENTO (
   IDINSTRUMENTOPFK ASC
);

/*==============================================================*/
/* Table: LABORPERSONAOBRA                                      */
/*==============================================================*/
create table LABORPERSONAOBRA (
   CONSECLABOR          NUMBER                not null,
   IDPERIODOPKFK        INTEGER               not null,
   CODACTIVIDADFK       VARCHAR2(5)           not null,
   IDTIPOCALENPKFK      VARCHAR2(2),
   IDOBRAKKFK           VARCHAR2(4),
   CONSECALENDARIOFK    NUMBER,
   CODUNIDADFK          VARCHAR2(5),
   ROLFK                NUMBER,
   ICODEMPLEADOFK       VARCHAR2(40),
   IDPERSONAOBRAFK      NUMBER,
   NOHORAS              NUMBER                not null,
   constraint PK_LABORPERSONAOBRA primary key (CONSECLABOR)
);

/*==============================================================*/
/* Index: PERTENECE_FK                                          */
/*==============================================================*/
create index PERTENECE_FK on LABORPERSONAOBRA (
   IDPERIODOPKFK ASC,
   CODACTIVIDADFK ASC
);

/*==============================================================*/
/* Index: CONTIENEN_FK                                          */
/*==============================================================*/
create index CONTIENEN_FK on LABORPERSONAOBRA (
   IDTIPOCALENPKFK ASC,
   IDOBRAKKFK ASC,
   CONSECALENDARIOFK ASC
);

/*==============================================================*/
/* Index: PUEDE_ESTAR_FK                                        */
/*==============================================================*/
create index PUEDE_ESTAR_FK on LABORPERSONAOBRA (
   CODUNIDADFK ASC,
   ROLFK ASC,
   ICODEMPLEADOFK ASC,
   IDPERSONAOBRAFK ASC
);

/*==============================================================*/
/* Table: LISTAACTIVIDADUD                                      */
/*==============================================================*/
create table LISTAACTIVIDADUD (
   IDPERIODOFK          INTEGER               not null,
   CODACTIVIDAD         VARCHAR2(5)           not null,
   DESCACTIVIDAD        VARCHAR2(40)          not null,
   VALORHORA            NUMBER                not null,
   MAXHORAS             NUMBER                not null,
   constraint PK_LISTAACTIVIDADUD primary key (IDPERIODOFK, CODACTIVIDAD)
);

/*==============================================================*/
/* Index: ES_PARTE_DE_FK                                        */
/*==============================================================*/
create index ES_PARTE_DE_FK on LISTAACTIVIDADUD (
   IDPERIODOFK ASC
);

/*==============================================================*/
/* Table: LISTAGASTOSUD                                         */
/*==============================================================*/
create table LISTAGASTOSUD (
   IDPERIODOPFK         INTEGER               not null,
   CODGASTOS            VARCHAR2(5)           not null,
   constraint PK_LISTAGASTOSUD primary key (IDPERIODOPFK, CODGASTOS)
);

/*==============================================================*/
/* Index: GUARDA_FK                                             */
/*==============================================================*/
create index GUARDA_FK on LISTAGASTOSUD (
   IDPERIODOPFK ASC
);

/*==============================================================*/
/* Table: NECESITA                                              */
/*==============================================================*/
create table NECESITA (
   IDOBRAPKFK           VARCHAR2(4)           not null,
   IDINSTRUMENTOPKFK    VARCHAR2(4)           not null,
   constraint PK_NECESITA primary key (IDOBRAPKFK, IDINSTRUMENTOPKFK)
);

/*==============================================================*/
/* Index: NECESITA2_FK                                          */
/*==============================================================*/
create index NECESITA2_FK on NECESITA (
   IDINSTRUMENTOPKFK ASC
);

/*==============================================================*/
/* Index: NECESITA_FK                                           */
/*==============================================================*/
create index NECESITA_FK on NECESITA (
   IDOBRAPKFK ASC
);

/*==============================================================*/
/* Table: OBRA                                                  */
/*==============================================================*/
create table OBRA (
   IDOBRA               VARCHAR2(4)           not null,
   IDPERIODO            INTEGER,
   IDGENEROOBRA         VARCHAR2(2)           not null,
   CODPAIS              VARCHAR2(3)           not null,
   IDCOMPOSITOR         VARCHAR2(3)           not null,
   FECHAOBRA            DATE                  not null,
   TITULO               VARCHAR2(30)          not null,
   ESTADO               SMALLINT              not null,
   constraint PK_OBRA primary key (IDOBRA)
);

/*==============================================================*/
/* Index: ALMACENA_FK                                           */
/*==============================================================*/
create index ALMACENA_FK on OBRA (
   IDPERIODO ASC
);

/*==============================================================*/
/* Index: CLASIFICAN_FK                                         */
/*==============================================================*/
create index CLASIFICAN_FK on OBRA (
   IDGENEROOBRA ASC
);

/*==============================================================*/
/* Index: SE_CREAN_FK                                           */
/*==============================================================*/
create index SE_CREAN_FK on OBRA (
   CODPAIS ASC
);

/*==============================================================*/
/* Index: CREA_FK                                               */
/*==============================================================*/
create index CREA_FK on OBRA (
   IDCOMPOSITOR ASC
);

/*==============================================================*/
/* Table: PAIS                                                  */
/*==============================================================*/
create table PAIS (
   CODPAIS              VARCHAR2(3)           not null,
   NOMPAIS              VARCHAR2(30)          not null,
   constraint PK_PAIS primary key (CODPAIS)
);

/*==============================================================*/
/* Table: PARTICIPACIONESTUDIANTE                               */
/*==============================================================*/
create table PARTICIPACIONESTUDIANTE (
   CONSECASIS           NUMBER                not null,
   CODESTUDIANTEPKFK    VARCHAR2(10)          not null,
   IDTIPOCALENPKFK      VARCHAR2(2)           not null,
   IDOBRAFFK            VARCHAR2(4)           not null,
   CONSECALENDARIO      NUMBER                not null,
   constraint PK_PARTICIPACIONESTUDIANTE primary key (CONSECASIS)
);

/*==============================================================*/
/* Index: PARTICIPA_FK                                          */
/*==============================================================*/
create index PARTICIPA_FK on PARTICIPACIONESTUDIANTE (
   CODESTUDIANTEPKFK ASC
);

/*==============================================================*/
/* Index: CONTIENE_FK                                           */
/*==============================================================*/
create index CONTIENE_FK on PARTICIPACIONESTUDIANTE (
   IDTIPOCALENPKFK ASC,
   IDOBRAFFK ASC,
   CONSECALENDARIO ASC
);

/*==============================================================*/
/* Table: PERIODO                                               */
/*==============================================================*/
create table PERIODO (
   IDPERIODO            INTEGER               not null,
   constraint PK_PERIODO primary key (IDPERIODO)
);

/*==============================================================*/
/* Table: PERSONALOBRA                                          */
/*==============================================================*/
create table PERSONALOBRA (
   CODUNIDADPFK         VARCHAR2(5)           not null,
   ROLPFK               NUMBER                not null,
   ICODEMPLEADOPFK      VARCHAR2(40)          not null,
   IDPERSONAOBRA        NUMBER                not null,
   IDOBRAPKFK           VARCHAR2(4)           not null,
   FECHAINICIO          DATE                  not null,
   constraint PK_PERSONALOBRA primary key (CODUNIDADPFK, ROLPFK, ICODEMPLEADOPFK, IDPERSONAOBRA)
);

/*==============================================================*/
/* Index: ES_UN_FK                                              */
/*==============================================================*/
create index ES_UN_FK on PERSONALOBRA (
   CODUNIDADPFK ASC,
   ROLPFK ASC,
   ICODEMPLEADOPFK ASC
);

/*==============================================================*/
/* Index: SE_BENEFICIA_FK                                       */
/*==============================================================*/
create index SE_BENEFICIA_FK on PERSONALOBRA (
   IDOBRAPKFK ASC
);

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
create table ROL (
   ROL                  NUMBER                not null,
   DESROL               VARCHAR2(15)          not null,
   constraint PK_ROL primary key (ROL)
);

/*==============================================================*/
/* Table: TIPOCALENDARIO                                        */
/*==============================================================*/
create table TIPOCALENDARIO (
   IDTIPOCALEN          VARCHAR2(2)           not null,
   DESCTIPOCALENDARIO   VARCHAR2(20)          not null,
   constraint PK_TIPOCALENDARIO primary key (IDTIPOCALEN)
);

/*==============================================================*/
/* Table: TIPOUNIDAD                                            */
/*==============================================================*/
create table TIPOUNIDAD (
   TIPOUNIDAD           VARCHAR2(2)           not null,
   DESCTIPOUNI          VARCHAR2(3)           not null,
   constraint PK_TIPOUNIDAD primary key (TIPOUNIDAD)
);

/*==============================================================*/
/* Table: UNIDAD                                                */
/*==============================================================*/
create table UNIDAD (
   CODUNIDAD            VARCHAR2(5)           not null,
   UNI_CODUNIDAD        VARCHAR2(5),
   TIPOUNIDADFK         VARCHAR2(2)           not null,
   NOMUNIDAD            VARCHAR2(40)          not null,
   constraint PK_UNIDAD primary key (CODUNIDAD)
);

/*==============================================================*/
/* Index: ES_FK                                                 */
/*==============================================================*/
create index ES_FK on UNIDAD (
   UNI_CODUNIDAD ASC
);

/*==============================================================*/
/* Index: ES_DE_FK                                              */
/*==============================================================*/
create index ES_DE_FK on UNIDAD (
   TIPOUNIDADFK ASC
);

alter table CALENDARIO
   add constraint FK_CALENDAR_ES_TIPO_TIPOCALE foreign key (IDTIPOCALENPKFK)
      references TIPOCALENDARIO (IDTIPOCALEN);

alter table CALENDARIO
   add constraint FK_CALENDAR_LLENA_OBRA foreign key (IDOBRAKFK)
      references OBRA (IDOBRA);

alter table CALENDARIO
   add constraint FK_CALENDAR_POSEE_ESTADO foreign key (IDESTADOFK)
      references ESTADO (IDESTADO);

alter table COMPOSITOR
   add constraint FK_COMPOSIT_VIVEN_PAIS foreign key (CODPAISFK)
      references PAIS (CODPAIS);

alter table CONVOCATORIAESTUDIANTE
   add constraint FK_CONVOCAT_ADMITE_INSTRUME foreign key (IDINSTRUMENTOFK)
      references INSTRUMENTO (IDINSTRUMENTO);

alter table CONVOCATORIAESTUDIANTE
   add constraint FK_CONVOCAT_PARTICIPA_ESTUDIAN foreign key (CODESTUDIANTEFK)
      references ESTUDIANTE (CODESTUDIANTE);

alter table CONVOCATORIAESTUDIANTE
   add constraint FK_CONVOCAT_REALIZA_OBRA foreign key (IDOBRAFK)
      references OBRA (IDOBRA);

alter table EMPLEADO
   add constraint FK_EMPLEADO_AGRUPA_UNIDAD foreign key (CODUNIDADPKFK)
      references UNIDAD (CODUNIDAD);

alter table EMPLEADO
   add constraint FK_EMPLEADO_TIENE_ROL foreign key (ROLPKFK)
      references ROL (ROL);

alter table ESTUDIANTE
   add constraint FK_ESTUDIAN_ESTA_UNIDAD foreign key (CODUNIDADFFK)
      references UNIDAD (CODUNIDAD);

alter table GASTOOBRA
   add constraint FK_GASTOOBR_ATESORA_OBRA foreign key (IDOBRA)
      references OBRA (IDOBRA);

alter table GASTOOBRA
   add constraint FK_GASTOOBR_ESTIMA_LISTAGAS foreign key (IDPERIODOPFK, CODGASTOS)
      references LISTAGASTOSUD (IDPERIODOPFK, CODGASTOS);

alter table INVENTARIOINSTRUMENTO
   add constraint FK_INVENTAR_REVISA_ESTADOIN foreign key (IDESTADOINSTRUMENTOFK)
      references ESTADOINSTRUMENTO (IDESTADOINSTRUMENTO);

alter table INVENTARIOINSTRUMENTO
   add constraint FK_INVENTAR_SE_GUARDA_INSTRUME foreign key (IDINSTRUMENTOPFK)
      references INSTRUMENTO (IDINSTRUMENTO);

alter table LABORPERSONAOBRA
   add constraint FK_LABORPER_CONTIENEN_CALENDAR foreign key (IDTIPOCALENPKFK, IDOBRAKKFK, CONSECALENDARIOFK)
      references CALENDARIO (IDTIPOCALENPKFK, IDOBRAKFK, CONSECALENDARIO);

alter table LABORPERSONAOBRA
   add constraint FK_LABORPER_PERTENECE_LISTAACT foreign key (IDPERIODOPKFK, CODACTIVIDADFK)
      references LISTAACTIVIDADUD (IDPERIODOFK, CODACTIVIDAD);

alter table LABORPERSONAOBRA
   add constraint FK_LABORPER_PUEDE_EST_PERSONAL foreign key (CODUNIDADFK, ROLFK, ICODEMPLEADOFK, IDPERSONAOBRAFK)
      references PERSONALOBRA (CODUNIDADPFK, ROLPFK, ICODEMPLEADOPFK, IDPERSONAOBRA);

alter table LISTAACTIVIDADUD
   add constraint FK_LISTAACT_ES_PARTE__PERIODO foreign key (IDPERIODOFK)
      references PERIODO (IDPERIODO);

alter table LISTAGASTOSUD
   add constraint FK_LISTAGAS_GUARDA_PERIODO foreign key (IDPERIODOPFK)
      references PERIODO (IDPERIODO);

alter table NECESITA
   add constraint FK_NECESITA_NECESITA_OBRA foreign key (IDOBRAPKFK)
      references OBRA (IDOBRA);

alter table NECESITA
   add constraint FK_NECESITA_NECESITA2_INSTRUME foreign key (IDINSTRUMENTOPKFK)
      references INSTRUMENTO (IDINSTRUMENTO);

alter table OBRA
   add constraint FK_OBRA_ALMACENA_PERIODO foreign key (IDPERIODO)
      references PERIODO (IDPERIODO);

alter table OBRA
   add constraint FK_OBRA_CLASIFICA_GENEROOB foreign key (IDGENEROOBRA)
      references GENEROOBRA (IDGENEROOBRA);

alter table OBRA
   add constraint FK_OBRA_CREA_COMPOSIT foreign key (IDCOMPOSITOR)
      references COMPOSITOR (IDCOMPOSITOR);

alter table OBRA
   add constraint FK_OBRA_SE_CREAN_PAIS foreign key (CODPAIS)
      references PAIS (CODPAIS);

alter table PARTICIPACIONESTUDIANTE
   add constraint FK_PARTICIP_CONTIENE_CALENDAR foreign key (IDTIPOCALENPKFK, IDOBRAFFK, CONSECALENDARIO)
      references CALENDARIO (IDTIPOCALENPKFK, IDOBRAKFK, CONSECALENDARIO);

alter table PARTICIPACIONESTUDIANTE
   add constraint FK_PARTICIP_PARTICIPA_ESTUDIAN foreign key (CODESTUDIANTEPKFK)
      references ESTUDIANTE (CODESTUDIANTE);

alter table PERSONALOBRA
   add constraint FK_PERSONAL_ES_UN_EMPLEADO foreign key (CODUNIDADPFK, ROLPFK, ICODEMPLEADOPFK)
      references EMPLEADO (CODUNIDADPKFK, ROLPKFK, ICODEMPLEADO);

alter table PERSONALOBRA
   add constraint FK_PERSONAL_SE_BENEFI_OBRA foreign key (IDOBRAPKFK)
      references OBRA (IDOBRA);

alter table UNIDAD
   add constraint FK_UNIDAD_ES_UNIDAD foreign key (UNI_CODUNIDAD)
      references UNIDAD (CODUNIDAD);

alter table UNIDAD
   add constraint FK_UNIDAD_ES_DE_TIPOUNID foreign key (TIPOUNIDADFK)
      references TIPOUNIDAD (TIPOUNIDAD);

