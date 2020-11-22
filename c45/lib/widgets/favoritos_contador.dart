import 'package:flutter/material.dart';

class FavoritosContador extends StatelessWidget {
  FavoritosContador(@required int this.valor, {Key key}) : super(key: key);

  int valor = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 25.0,
        height: 25.0,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
        child: Center(
          child: Text(
            '$valor',
            style: TextStyle(
              //fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ));
  }
}
