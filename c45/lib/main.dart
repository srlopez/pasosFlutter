import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/constantes_model.dart';
import 'providers/favoritos_provider.dart';
import 'services/candidato_services_randomuser.dart';
import 'controllers/candidato_controller.dart';

import 'routes/pageRoute.dart';

void main() {
  var httpRandomUserServices = HttpRandomUserServices();
  var candidatoCtrl = CandidatoController(httpRandomUserServices);

  runApp(ChangeNotifierProvider<Favoritos>(
    create: (_) => Favoritos(),
    child: MyApp(controller: candidatoCtrl),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({this.controller});

  final CandidatoController controller;

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
      home: candidatosPage,
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
