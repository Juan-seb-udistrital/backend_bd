import 'package:lucifer/lucifer.dart';
import 'routes.dart';


void main() async {
  loadroutes();
  app.use(logger());
  app.use(json());
  app.use('/calendar',calendar);
  app.use('/navbar',navbar);
  app.use('/selection', selection);
  await app.listen(port,'127.0.0.1');

  print("servidor prueba  rutas apartes");

  app.checkRoutes();
}
