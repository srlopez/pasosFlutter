import 'package:flutter/material.dart';

//https://stackoverflow.com/questions/54069239/whats-the-best-practice-to-keep-all-the-constants-in-flutter
class MisConstantes extends InheritedWidget {
  // Hacemos que pueda ser accedido desde el arbol con el child:
  static MisConstantes of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MisConstantes>();

  MisConstantes({Widget child, Key key}) : super(key: key, child: child);

  // Horario
  final alturaPie = 70.0;

  @override
  bool updateShouldNotify(MisConstantes oldWidget) => false;
}
