import 'package:lucifer/lucifer.dart';

import 'routes.dart';
void main() async {
  app.use(logger());
  app.use('/',login);
  await app.listen(port);

  print("servidor prueba  rutas apartes");

  app.checkRoutes();
}