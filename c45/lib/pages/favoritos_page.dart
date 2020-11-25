import 'dart:math';

import 'package:c45/models/favorito_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favoritos_provider.dart';

class FavoritosPage extends StatelessWidget {
  FavoritosPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var favoritos = Provider.of<Favoritos>(context);

    // Si estamos borrando es posible que no tengamos nada que presentar
    // entonces Volvemos
    if (favoritos.lista.length < 1)
      try {
        Navigator.of(context).pop();
      } catch (e) {}

    return Drawer(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: favoritos.lista.length,
        itemBuilder: (BuildContext context, int index) {
          return FavoritoWidget(favoritos.lista[index]);
        },
        //),
        //  ),
      ),
    );
  }
}

class FavoritoWidget extends StatelessWidget {
  FavoritoWidget(this.favorito, {Key key}) : super(key: key);

  Favorito favorito;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        //height: 450,
        //padding: EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 20,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.face, size: 40),
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    favorito.nombre,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              //Text(favorito.id, style: TextStyle(fontSize: 13.0)),

              Consumer<Favoritos>(
                builder: (BuildContext context, favoritos, Widget child) =>
                    ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                            child: Icon(Icons.add),
                            onTap: () => favoritos.addIncrement(favorito, 1)),
                        InkWell(
                            child: Icon(Icons.remove),
                            onTap: () => favoritos.addIncrement(favorito, -1)),
                      ],
                    ),
                    Text('${favorito.puntos}',
                        style: TextStyle(fontSize: 41.0)),
                    InkWell(
                        child: Icon(
                          Icons.person_remove,
                          color: Colors.red[100],
                        ),
                        onTap: () => favoritos.removeFavorito(favorito))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
