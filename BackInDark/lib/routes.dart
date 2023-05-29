import 'dart:convert';
import 'dart:js_interop';

import 'package:http/http.dart' as http;
import 'package:lucifer/lucifer.dart';

final app = App();
final port = env('PORT') ?? 3000;

var calendar = app.router();
var navbar = app.router();
var selection = app.router();

//---------------------------------------------------

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

  navbar.get('getAttendance', (Req req, Res res) async {
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
  selection.post('/participants', (Req req, Res res) async {
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
  selection.post('', (Req req, Res res) async {
    try {
      final Map<String, dynamic> requestBody = req.body;
      final id =requestBody['id'];
      var result =  await consult({"query":"insert into ParticipacionEstudiante VALUES (cpartest.nextval,:${id},'Cs','ob1','3')"});
      if (!result.isNull) {
        res.send({
        "inserted": true
      }); 
    }
    } catch (e) {
      print("ouch!--> error selection/participants");
      print(e);
      res.send({
      "error": true
      });
    }
  });
}
//-------------------------------

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
  routesNavBar();
  routesSelection();
}
