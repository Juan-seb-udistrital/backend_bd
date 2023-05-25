import 'package:lucifer/lucifer.dart';


final app =App();
final port =env('PORT') ?? 3000;

var rutas = Router(app);


// Peteciones Registro

var register = rutas.post('/register', (Req req, Res res) async{

});

// Peticiones de login
var login=rutas.post('/login', (Req req, Res res) async {
    await res.send('Hello mi perro');
});

//-------------------------------

var calendar =rutas.get('/calendar', (Req req ,Res res) async {

});

// rutas

