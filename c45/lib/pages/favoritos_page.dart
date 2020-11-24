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
    return

        // Scaffold(
        //   appBar: AppBar(
        //     title: Text(title),
        //   ),
        //   body:
        //   Center(
        // child:
        GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: favoritos.lista.length,
      itemBuilder: (BuildContext context, int index) {
        return MiCardWidget(favoritos.lista[index]);
      },
      //),
      //  ),
    );
  }
}

class MiCardWidget extends StatelessWidget {
  MiCardWidget(this.favorito, {Key key}) : super(key: key);

  Favorito favorito;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 177,
            //height: 450,
            //padding: EdgeInsets.all(10.0),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                //color: Colors.red,
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person, size: 60),
                    Text(favorito.nombre, style: TextStyle(fontSize: 15.0)),
                    Text(favorito.id, style: TextStyle(fontSize: 13.0)),
                    Text('${favorito.puntos}',
                        style: TextStyle(fontSize: 40.0)),
                    Consumer<Favoritos>(
                      builder:
                          (BuildContext context, favoritos, Widget child) =>
                              ButtonBar(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          InkWell(
                              child: Icon(Icons.add),
                              onTap: () => favoritos.addIncrement(favorito, 1)),
                          InkWell(
                              child: Icon(Icons.remove),
                              onTap: () =>
                                  favoritos.addIncrement(favorito, -1)),
                          InkWell(
                              child: Icon(Icons.person_remove),
                              onTap: () => favoritos.removeFavorito(favorito))
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
