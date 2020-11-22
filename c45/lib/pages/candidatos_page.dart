import 'package:c45/models/constantes_model.dart';
import 'package:c45/providers/favoritos_provider.dart';
import 'package:c45/widgets/favoritos_contador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/candidato_model.dart';
import '../widgets/circular_progress_widget.dart';
import '../controllers/candidato_controller.dart';

import 'candidato_widget.dart';
import 'navigation_drawer.dart';

class CandidatosPage extends StatefulWidget {
  CandidatosPage({Key key, @required this.title, @required this.candidatoCtrl})
      : super(key: key);

  final String title;
  final CandidatoController candidatoCtrl;

  static const String routeName = '/candidatosPage';

  @override
  _CandidatosPageState createState() => _CandidatosPageState();
}

class _CandidatosPageState extends State<CandidatosPage> {
  var _lista = <Candidato>[];
  bool _estaCargando = false;

  ScrollController _scrollCtrl;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // OJO: PROBLEMA DE NAVEGACION SI SE 'PUSH' ESTA PAGINA DE NUEVO
    // 0.- Se vuelve a invocar initState
    // 1.- El Stream ya esta tomado <-
    // 2.- Perdemos la página anterior
    super.initState();

    // Shorcut a la lista
    _lista = widget.candidatoCtrl.candidatos;

    // Stream de información si está cargando elementos...
    widget.candidatoCtrl.onSync.listen((bool syncState) {
      //if (!mounted) return;
      setState(() {
        _estaCargando = syncState;
      });
    });

    // Lectura de página si hacemos scroll hacia arriba
    _scrollCtrl = ScrollController();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels == _scrollCtrl.position.maxScrollExtent)
        _fechtProximaPagina();
    });

    // Primera lectura de datos
    this._fechtProximaPagina();
  }

  Future _fechtProximaPagina() async {
    if (_estaCargando) return;
    //_lista = podemos reasiganarla pero ya está en el intState
    await widget.candidatoCtrl.fechtCandidatos();
  }

  @override
  Widget build(BuildContext context) {
    var ctes = MisConstantes.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Consumer<Favoritos>(
                builder: (BuildContext context, favoritos, Widget child) =>
                    FavoritosContador(favoritos.lista.length)),
            SizedBox(
              width: 15,
            )
          ],
        ),
        drawer: NavigationDrawer(),
        body: Column(
          children: [
            // Dividimos la pantalla en dos áreas
            // Expand <- me gusta más, pero por no añadir más widgets
            Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight -
                    ctes.alturaPie,
                child: ListView.builder(
                  controller: _scrollCtrl,
                  itemCount: _lista.length + 1, //+1 para forzar scroll
                  itemBuilder: (_, i) {
                    if (i >= _lista.length)
                      return CircularProgress(_estaCargando);
                    return CandidatoWidget(item: _lista[i], index: i);
                  },
                )),
            Container(
                height: ctes.alturaPie,
                child: Center(
                    child: _estaCargando
                        ? Text('Cargando...')
                        : Text('Items: ${_lista.length}'))),
          ],
        ));
  }
}
