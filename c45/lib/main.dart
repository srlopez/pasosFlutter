import 'package:c45/controllers/favorito_controller.dart';
import 'package:c45/services/favorito_services_hive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/constantes_model.dart';
import 'pages/candidatos_page.dart';
import 'pages/dummy_page.dart';
import 'providers/favoritos_provider.dart';
import 'services/candidato_services_randomuser.dart';
import 'controllers/candidato_controller.dart';
import 'services/favorito_services_file.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var httpCandidatoService = HttpRandomUserServices();
  var candidatoCtrl = CandidatoController(httpCandidatoService);

  //var localFavoritoService = FavoritoServicesFile();
  var localFavoritoService = FavoritoServiceHive();
  await localFavoritoService.init();
  var favoritoCtrl = FavoritoController(localFavoritoService);

  runApp(ChangeNotifierProvider<Favoritos>(
    create: (_) => Favoritos(controller: favoritoCtrl),
    child: MyApp(controller: candidatoCtrl),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({this.controller});

  final CandidatoController controller;
  var _pageCtrl = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    var candidatosPage = MisConstantes(
        // Constantes como si fuera un provider
        child: CandidatosPage(
            title: 'Flutter Demo Home Page', candidatoCtrl: controller));

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: candidatosPage,
        home: PageView(
          controller: _pageCtrl,
          children: [
            DummyPage(title: 'Dummy {'),
            candidatosPage,
            DummyPage(title: '} Dummy '),
          ],
        )

        // Hacemos rutas de push/pop
        // Las nombradas hace que Candidatos Page se vuelva a cargar
        // routes: {
        //   pageRoutes.home: (context) => HomePage(),
        //   pageRoutes.candidatos: (context) => candidatosPage,
        //   pageRoutes.contact: (context) => ContactPage(),
        //   pageRoutes.event: (context) => EventPage(),
        //   pageRoutes.profile: (context) => ProfilePage(),
        //   pageRoutes.notification: (context) => NotificationPage(),
        // },
        );
  }
}
