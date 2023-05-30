import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lucifer/lucifer.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

final app = App();
final port = env('PORT') ?? 3000;

var attendance=app.router();
var calendar = app.router();
var liquidation = app.router();
var navbar = app.router();
var selection = app.router();

//---------------------------------------------------
// rutas atención
routeAttendance(){
  attendance.get("/todayAttendance", (Req req, Res res) async{
      try {
        var result = await consult({"query":'''SELECT E.CODESTUDIANTE, E.NOMBREES, E.apellidoes
    FROM  PERIODO P ,OBRA  O, CALENDARIO C, TIPOCALENDARIO T, ESTUDIANTE E, PARTICIPACIONESTUDIANTE R
    WHERE  P.IDPERIODO=O.IDPERIODO   and O.IDOBRA =C.IDOBRAKFK AND T.IDTIPOCALEN=C.IDTIPOCALENPKFK
    AND E.CODESTUDIANTE=R.CODESTUDIANTEPKFK AND R.IDTIPOCALENPKFK=C.IDTIPOCALENPKFK AND R.IDOBRAFFK=O.IDOBRA
    and lower(R.IDTIPOCALENPKFK) LIKE 'cs' '''});
        Map<String,dynamic> response = jsonDecode(result.body);
        Map<String, dynamic> students = response.map<String,Map<String,dynamic>>((key, row) =>MapEntry(key, {
        "id": row[0],
        "name": '${row[1]} ${row[2]}'
      }));
      
      } catch (e) {
         print("ouch!--> error liquidation/sendEmails");
         print(e);
      }
  });
}

// rutas para el calendario
routesCalendar() {
  calendar.get('/events', (Req req, Res res) async {
    try {
      var result = await consult({
        "query":
            "SELECT 'Actividad: '|| TC.DESCTIPOCALENDARIO Actividad, 'Obra: '|| O.TITULO OBRA, to_char(C.FECHAINICIO,'yyyy/mm/dd hh24:mi:ss') INICIO_ACTIVIDAD, to_char(C.FECHAFIN,'yyyy/mm/dd hh24:mi:ss') FINAL_ACTIVIDAD FROM CALENDARIO C, TIPOCALENDARIO TC, OBRA O WHERE O.IDOBRA=C.IDOBRAKFK AND TC.IDTIPOCALEN=C.IDTIPOCALENPKFK"
      });
      Map<String, dynamic> response = jsonDecode(result.body);
      await res.json(response);
    } catch (e) {
      print("ouch!--> error calendar/events");
      print(e);
    }
  });
// Peticiones de login
  calendar.patch('/inactiveParticipation', (Req req, Res res) async {});
}
//-------------------------------------------------------
// rutas liquidación

routeLiquidation() {
  liquidation.get('/reports', (Req req, Res res) async {
    try {
      var result = await consult({
        "query":
            '''Select A.CODESTUDIANTE,A.NOMBRE , A.TOTAL, U_E.NOMUNIDAD POYECTO,U_P.NOMUNIDAD FACULTAD FROM (Select distinct ENSAYO.CODESTUDIANTE, ENSAYO.NOMBRE , NVL(ENSAYO.HEnsayo,0)*2+NVL(Funcion.Hfuncion,0)*4 TOTAL
    From (SELECT E.CODESTUDIANTE, E.NOMBREES ||' '|| E.APELLIDOES NOMBRE, COUNT(E.CODESTUDIANTE) HEnsayo FROM 
    CALENDARIO C, PARTICIPACIONESTUDIANTE P, ESTUDIANTE E
    WHERE C.CONSECALENDARIO=P.CONSECALENDARIO and C.IDTIPOCALENPKFK=P.IDTIPOCALENPKFK and C.IDOBRAKFK =P.IDOBRAFFK and E.CODESTUDIANTE = P.CODESTUDIANTEPKFK and lower(C.IDTIPOCALENPKFK) LIKE 'ce'
    GROUP BY E.CODESTUDIANTE, E.NOMBREES ||' '|| E.APELLIDOES) Ensayo LEFT JOIN
    (SELECT E.CODESTUDIANTE,COUNT(E.CODESTUDIANTE) Hfuncion FROM CALENDARIO C, PARTICIPACIONESTUDIANTE P, ESTUDIANTE E
    WHERE C.CONSECALENDARIO=P.CONSECALENDARIO and C.IDTIPOCALENPKFK=P.IDTIPOCALENPKFK and C.IDOBRAKFK =P.IDOBRAFFK and E.CODESTUDIANTE = P.CODESTUDIANTEPKFK and lower(C.IDTIPOCALENPKFK) LIKE 'cf'
    GROUP BY E.CODESTUDIANTE) Funcion ON ENSAYO.CODESTUDIANTE=FUNCION.CODESTUDIANTE) A , ESTUDIANTE E, UNIDAD U_E ,UNIDAD U_P
    WHERE E.CODESTUDIANTE = A.CODESTUDIANTE and  U_E.CODUNIDAD=E.CODUNIDADFFK and U_E.UNI_CODUNIDAD=U_P.CODUNIDAD'''
      });
      Map<String, dynamic> response = jsonDecode(result.body);
      Map<String, dynamic> answer = response.map<String,Map<String,dynamic>>((key, row) =>MapEntry(key, {
        "id": row[0],
        "name": row[1],
        "project": "${row[4]}-${row[3]}",
        "hours": row[2],
      }));
      await res.json(answer);
    } catch (e) {
      print("ouch!--> error liquidation/reports");
      print(e);
    }
  });

  liquidation.get('/sendEmails', (Req req, Res res) async {
    try {
      var result = await consult({
        "query":
            '''Select A.CODESTUDIANTE,A.NOMBRE , A.TOTAL, U_E.NOMUNIDAD POYECTO,U_P.NOMUNIDAD FACULTAD, e.correo
    FROM (Select distinct ENSAYO.CODESTUDIANTE, ENSAYO.NOMBRE , NVL(ENSAYO.HEnsayo,0)*2+NVL(Funcion.Hfuncion,0)*4 TOTAL
    From (SELECT E.CODESTUDIANTE, E.NOMBREES ||' '|| E.APELLIDOES NOMBRE, COUNT(E.CODESTUDIANTE) HEnsayo FROM 
    CALENDARIO C, PARTICIPACIONESTUDIANTE P, ESTUDIANTE E
    WHERE C.CONSECALENDARIO=P.CONSECALENDARIO and C.IDTIPOCALENPKFK=P.IDTIPOCALENPKFK and C.IDOBRAKFK =P.IDOBRAFFK and E.CODESTUDIANTE = P.CODESTUDIANTEPKFK and lower(C.IDTIPOCALENPKFK) LIKE 'ce'
    GROUP BY E.CODESTUDIANTE, E.NOMBREES ||' '|| E.APELLIDOES) Ensayo LEFT JOIN
    (SELECT E.CODESTUDIANTE,COUNT(E.CODESTUDIANTE) Hfuncion FROM CALENDARIO C, PARTICIPACIONESTUDIANTE P, ESTUDIANTE E
    WHERE C.CONSECALENDARIO=P.CONSECALENDARIO and C.IDTIPOCALENPKFK=P.IDTIPOCALENPKFK and C.IDOBRAKFK =P.IDOBRAFFK and E.CODESTUDIANTE = P.CODESTUDIANTEPKFK and lower(C.IDTIPOCALENPKFK) LIKE 'cf'
    GROUP BY E.CODESTUDIANTE) Funcion ON ENSAYO.CODESTUDIANTE=FUNCION.CODESTUDIANTE) A , ESTUDIANTE E, UNIDAD U_E ,UNIDAD U_P
    WHERE E.CODESTUDIANTE = A.CODESTUDIANTE and  U_E.CODUNIDAD=E.CODUNIDADFFK and U_E.UNI_CODUNIDAD=U_P.CODUNIDAD
    and A.total =(select sum(to_char(fechafin,'HH24')-to_char(fechainicio,'HH24'))
    from calendario  WHERE LOWER(idtipocalenPKFK) IN ('ce','cf'))'''
    });
      Map<String,dynamic>response =jsonDecode(result.body);
      Map<String, dynamic> useremail = response.map<String,Map<String,dynamic>>((key, row) =>MapEntry(key, {
        "id": row[0],
        "name": row[1],
        "project": "${row[4]}-${row[3]}",
        "hours": row[2],
        "email": row[5] 
      }));
      useremail.forEach((key, value) async {
       await sendMail(value["id"],value["name"], value["project"],value["hours"],value["email"]);
      });
      res.send({"emailsSent":true});   
    } catch (e) {
      print("ouch!--> error liquidation/sendEmails");
      print(e);
      res.send({"emailsSent":false});
    }
  });

  liquidation.patch('/updateAllCalendar',(Req req, Res res) async{
    try {
      await consult({"quey":'''UPDATE CALENDARIO 
      SET IDESTADOFK='Inactivo'
      WHERE lower(IDTIPOCALENPKFK) IN ('cs','ce','cf')'''});
      res.send({"allUpdated": true});
    } catch (e) {
      print("ouch!--> error liquidation/updateAllCalendar");
      print(e);
    }
  });
}

//-------------------------------------------------------

// rutas para el navbar
routesNavBar() {
  navbar.get('/getPlanning', (Req req, Res res) async {
    try {
      var result = await consult({
        "query":
            "SELECT C.IDESTADOFK FROM TIPOCALENDARIO TC, CALENDARIO C WHERE TC.IDTIPOCALEN=C.IDTIPOCALENPKFK AND LOWER(C.IDESTADOFK) LIKE 'activo%' AND LOWER(TC.DESCTIPOCALENDARIO) LIKE 'planeacion%'"
      });
      Map<String, dynamic> response = jsonDecode(result.body);
      await res.json(response);
    } catch (e) {
      print("ouch!--> error navbar/getPlannig");
      print(e);
    }
  });

  navbar.get('/getAttendance', (Req req, Res res) async {
    try {
      final Map<String, dynamic> requestBody = req.body;
      final year = requestBody['year'];
      final month = requestBody['month'];
      await res.send({year, month});
    } catch (e) {
      print("ouch!--> error navbar/getAttendance");
      print(e);
    }
  });
}

//-------------------------------

// rutas para selección
routesSelection() {
  selection.get('/participants', (Req req, Res res) async {
    try {
      var result = await consult({
        "query":
            '''select e.codestudiante, e.nombrees,e.apellidoes, r.nomunidad,u.nomunidad,i.nominstrumento,c.calificacion
    from estudiante e, convocatoriaestudiante c,instrumento i, obra o, periodo p, unidad u, unidad r, tipounidad t
    where e.codestudiante=c.codestudianteFK and u.codunidad=e.codunidadFFK and i.idinstrumento=c.idinstrumentoFK and c.idobraFK=o.idobra 
    and t.tipounidad=r.tipounidadFK and r.codunidad=u.Uni_codunidad
    and o.idperiodo=p.idperiodo and (i.idinstrumento, i.nominstrumento,c.calificacion) in 
    (select i.idinstrumento, i.nominstrumento,max(c.calificacion) from convocatoriaestudiante c, instrumento i where  i.idinstrumento=c.idinstrumentoFK GROUP by i.idinstrumento,i.nominstrumento)'''
      });
      Map<String, dynamic> response = jsonDecode(result.body);
      await res.json(response);
    } catch (e) {
      print("ouch!--> error selection/participants");
      print(e);
    }
  });
  selection.post('/insertParticipant', (Req req, Res res) async {
    try {
      final Map<String, dynamic> requestBody = req.body;
      final id = requestBody['id'];
      var result = await consult({
        "query":
            "insert into ParticipacionEstudiante VALUES (cpartest.nextval,:${id},'Cs','ob1','3')"
      });
      if (result.body != "") {
        res.send({"inserted": true});
      }
    } catch (e) {
      print("ouch!--> error selection/participants");
      print(e);
      res.send({"error": true});
    }
  });
}
//-------------------------------


// envio de email
Future sendMail(var id, var name, var project , var hours,var email) async{
    try {
    final smtpServer=gmail("johanaguirrediaz244@gmail.com", "mwefnwpaenhfijtz");
    final message = Message();
    message.from=Address("johanaguirrediaz244@gmail.com");
    message.recipients=[email];
    message.subject="Electiva cursada en el grupo Sinfonica UD - periodo 20231";
    message.html=''''<div style="width: 100%; background-color: rgb(109, 109, 109); border-radius: 20px; border: 1px solid black; text-align: center; color: aliceblue;">
                                <p>Electiva cursada en el grupo Sinfonica UD - periodo 20231 e informando 
                                al proyecto curricular ${project}  que el estudiante ${name} con codigo ${id} curso la electiva 
                                participación sinfonicaUD durante el período 20231 con una cantidad de horas de ${hours}.</p>
                            </div>''';
      await send(message, smtpServer);
    } catch (e) {
      print("--> No se Pudo enviar el email ");
      print(e);
    }
}

// Consulta Data Base
Future<http.Response> consult(var query) async {
  return http.post(
    Uri.parse('http://127.0.0.1:8000/bd'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(query),
  );
}

loadroutes() {
  routesCalendar();
  routeLiquidation();
  routesNavBar();
  routesSelection();
}
