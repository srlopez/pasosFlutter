import 'package:flutter/material.dart';
import 'controllers/user_controller.dart';
import 'screens/home_page.dart';

import 'services/user_services.dart';

void main() async {
  var services = HttpServices();
  var controller = UserController(services);

  runApp(MyApp(controller: controller));
}

class MyApp extends StatelessWidget {
  final UserController controller;

  MyApp({this.controller});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        controller: controller,
      ),
    );
  }
}
