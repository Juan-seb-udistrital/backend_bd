insert into GeneroObra values ('01', 'Musica culta');
insert into GeneroObra values ('02', 'Musica folclorica');
insert into GeneroObra values ('03', 'Musica popular');


insert into Pais VALUES ('001','Colombia');
insert into Pais VALUES ('002','Italia');
insert into Pais VALUES ('003','Polonia');
insert into Pais VALUES ('004','Mexico');


insert into Compositor values ('aa1','002','Antonio Vivaldi');
insert into Compositor values ('aa2','003','Frederic Chopin');
insert into Compositor values ('aa3','001','Jorge Velosa');
insert into Compositor values ('aa4','004','Joan Sebastian');
insert into Compositor values ('aa5','001','Jorge Villamil');

insert into Periodo VALUES ('202202');
insert into Periodo VALUES ('202301');
insert into Periodo VALUES ('202302');

insert into Obra values ('0001','202202','01','002','aa1','10/10/1721','Invierno','1');
insert into Obra values ('0002','202202','01','003','aa2','07/07/1830','Nocturne','0');
insert into Obra values ('0003','202301','02','001','aa3','05/05/2000','La cucharita','0');
insert into Obra values ('0004','202301','03','004','aa4','28/02/2020','Que sea','1');
insert into Obra values ('0005','202302','02','001','aa5','11/11/2008','Los guaduales','0');

insert into Instrumento VALUES('0001','Piano');
insert into Instrumento VALUES('0002','Violinsolista');
insert into Instrumento VALUES('0003','Viola');
insert into Instrumento VALUES('0004','Violinchelo');
insert into Instrumento VALUES('0005','Contrabajo');
insert into Instrumento VALUES('0006','Violin1');
insert into Instrumento VALUES('0007','Trompeta');
insert into Instrumento VALUES('0008','Flauta');
insert into Instrumento VALUES('0009','Viola');
insert into Instrumento VALUES('0010','Guitarra');
insert into Instrumento VALUES('0011','Triple');
insert into Instrumento VALUES('0012','Requinto');
insert into Instrumento VALUES('0013','Guacharaca');
insert into Instrumento VALUES('0014','Acordeon');
insert into Instrumento VALUES('0015','Guitarra electrica');
insert into Instrumento VALUES('0016','Trombon');
insert into Instrumento VALUES('0017','Bateria');
insert into Instrumento VALUES('0018','Cuatro');
insert into Instrumento VALUES('0019','Uquelele');


insert into TipoCalendario VALUES ('01','Planeacion');
insert into TipoCalendario VALUES ('02','Convocatoria');
insert into TipoCalendario VALUES ('03','Seleccion');
insert into TipoCalendario VALUES ('04','Ensayo');
insert into TipoCalendario VALUES ('05','Funcion');

insert into ListaActividadUD VALUES ('202202','00001','Direccion musical','150000','2');
insert into ListaActividadUD VALUES ('202202','00002','Evaluador musical','80000','2');
insert into ListaActividadUD VALUES ('202301','00003','Coordinador sinfonica','100000','2');
insert into ListaActividadUD VALUES ('202301','00004','Auxiliar general','25000','2');
insert into ListaActividadUD VALUES ('202302','00005','Auxiliar instrumentos','45000','2');


insert into Rol VALUES ('1','Director');
insert into Rol VALUES ('2','Coor general');
insert into Rol VALUES ('3','Evaluador');
insert into Rol VALUES ('4','Luminotecnico');
insert into Rol VALUES ('5','Coor instru');
insert into Rol VALUES ('6','Aux general');
insert into Rol VALUES ('7','Aux instru');


insert into TipoUnidad values('F','Fac');
insert into TipoUnidad values('P','Pro');
insert into TipoUnidad values('R','Rec');
insert into TipoUnidad values('V','Vic');
insert into TipoUnidad values('C','Coo');

insert into Unidad values('RR','','R','Rectoria');
insert into Unidad values('VRA','RR','V','Vice Academica');
insert into Unidad values('VRF','RR','V','Vice Financiera');
insert into Unidad values('CRH','VRF','C','Recursos humanos');
insert into Unidad values('CRF','VRF','C','Recursos financieros');
insert into Unidad values('FI','VRA','F','Ingenieria');
insert into Unidad values('FA','VRA','F','Artes');
insert into Unidad values('FCE','VRA','F','Ciencias y educación');
insert into Unidad values('FT','VRA','F','Tecnologica');
insert into Unidad values('FMR','VRA','F','Medio ambiente y recursos naturales');
insert into Unidad values('PS','FI','P','Sistemas');
insert into Unidad values('PI','FI','P','Industrial');
insert into Unidad values('PE','FI','P','Electronica');
insert into Unidad values('PEL','FI','P','Electrica');
insert into Unidad values('PF','FMR','P','Forestal');
insert into Unidad values('PMAT','FCE','P','Matematicas');
insert into Unidad values('PLC','FCE','P','Licenciatura');
insert into Unidad values('PM','FA','P','Musica');



insert into Estudiante values ('2018202001','PS','Jonathan', 'Santos','15/05/2023','fnac','jasantoss@udistrital.edu.co');
insert into Estudiante VALUES ('2018202002','PS','Johan','Aguirre','12/05/2023','10/10/2000','jaaguirre@udistrital.edu.co');
insert into Estudiante VALUES ('2018202003','PS','Jeasson','Suarez','19/05/2023','10/11/2001','jasuarezs@udistrital.edu.co');
insert into Estudiante VALUES ('2018202004','PS','Andrea','Gomez','13/05/2023','04/10/2002','ancgomezc@udistrital.edu.co');
insert into Estudiante VALUES ('2018202005','PI','Gabriela','Martinez','11/05/2023','25/02/2000','Gmartinezc@udistrital.edu.co');
insert into Estudiante VALUES ('2018202006','PI','Gabriela','Salazar','19/05/2023','25/12/1999','Gsalazarm@udistrital.edu.co');
insert into Estudiante VALUES ('2018202007','PE','Alfonso','Vargas','09/05/2023','29/05/1998','alvargass@udistrital.edu.co');
insert into Estudiante VALUES ('2018202008','PE','Francisco','Torres','08/05/2023','10/12/2000','fjtorresd@udistrital.edu.co');
insert into Estudiante VALUES ('2018202009','PF','Jesus','Aponte','19/05/2023','05/07/2000','jdapontes@udistrital.edu.co');
insert into Estudiante VALUES ('2018202010','PMAT','Daniela','Garcia','19/05/2023','08/07/2001','dgarciaa@udistrital.edu.co');
insert into Estudiante VALUES ('2018202011','PEL','Natalia','Florez','19/05/2023','05/03/2002','naflorezs@udistrital.edu.co');
insert into Estudiante VALUES ('2018202012','PM','Juana','Lopez','08/05/2023','01/09/2003','jalopezg@udistrital.edu.co');
insert into Estudiante VALUES ('2018202013','PLC','Juan','Sanchez','15/05/2023','02/06/1998','jasancheza@udistrital.edu.co');
insert into Estudiante VALUES ('2018202014','PF','Miguel','Aguilar','10/05/2023','05/09/1999','maguilarf@udistrital.edu.co');
insert into Estudiante VALUES ('2018202015','PMAT','Andres','Gomez','06/05/2023','01/01/2001','agomezb@udistrital.edu.co');

insert into ConvocatoriaEstudiante values ('0001','1','0001','2018202001','05/05/2023','20/05/2023',4.2);
insert into ConvocatoriaEstudiante values ('0001','2','0002','2018202002','05/05/2023','20/05/2023',4.5);
insert into ConvocatoriaEstudiante values ('0001','3','0003','2018202003','05/05/2023','20/05/2023',4.7);
insert into ConvocatoriaEstudiante values ('0001','4','0004','2018202004','05/05/2023','20/05/2023',4.8);
insert into ConvocatoriaEstudiante values ('0001','5','0005','2018202005','05/05/2023','20/05/2023',4.9);
insert into ConvocatoriaEstudiante values ('0001','6','0006','2018202006','05/05/2023','20/05/2023',4.3);
insert into ConvocatoriaEstudiante values ('0001','7','0003','2018202007','05/05/2023','20/05/2023',4.2);
insert into ConvocatoriaEstudiante values ('0001','8','0004','2018202008','05/05/2023','20/05/2023',4.4);
insert into ConvocatoriaEstudiante values ('0001','9','0005','2018202009','05/05/2023','20/05/2023',3.2);
insert into ConvocatoriaEstudiante values ('0001','10','0006','2018202010','05/05/2023','20/05/2023',4.0);

 
insert into Empleado values ('CRH','6','20102020','Sebastian','Angulo','10002345','3052582930');
insert into Empleado values ('CRF','6','20102021','Roman','Amaya','10022300','3122582930');
insert into Empleado values ('CRF','7','20102022','Andres','Diaz','11112390','3012567920');
insert into Empleado values ('CRH','7','20102023','Alex','Rodriguez','12222310','3022582640');
insert into Empleado values ('PS','1','20102024','Humberto','Garcia','13302348','3102521212');
insert into Empleado values ('PS','2','20102025','Carolina','Diaz','12342347','3112590087');
insert into Empleado values ('PLC','3','20102026','Camila','Suarez','13452335','3151023490');
insert into Empleado values ('PI','5','20102027','Diana','Lopez','14562323','3102222930');
insert into Empleado values ('PF','1','20102028','Laura','Garcia','10232322','3203452930');
insert into Empleado values ('PMAT','1','20102029','Alejandra','Gonzalez','12300343','3052583456');

insert into PersonalObra values ('PMAT','1','20102029',1,'0001','25/02/2023');
insert into PersonalObra values ('PF','1','20102028',2,'0001','25/02/2023');
insert into PersonalObra values ('PS','1','20102025',3,'0001','25/02/2023');

