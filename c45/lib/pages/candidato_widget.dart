import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/candidato_model.dart';
import '../providers/favoritos_provider.dart';

class CandidatoWidget extends StatefulWidget {
  CandidatoWidget({Key key, this.item, this.index}) : super(key: key);
  final Candidato item;
  final int index;

  @override
  _CandidatoWidgetState createState() => _CandidatoWidgetState();
}

class _CandidatoWidgetState extends State<CandidatoWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person),
          Text('${widget.index + 1}'),
        ],
      ),
      title: Text(widget.item.nombre),
      subtitle: Text(widget.item.email),
      trailing: Consumer<Favoritos>(
        builder: (BuildContext context, favoritos, Widget child) =>
            favoritos.esFavorito(widget.item)
                ? InkWell(
                    child: Icon(Icons.hail),
                    onTap: () => favoritos.removeFavorito(widget.item))
                : InkWell(
                    child: Text("+Fav"),
                    onTap: () => favoritos.addFavorito(widget.item),
                  ),
      ),
    );
  }
}
