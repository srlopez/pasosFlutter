import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/candidato_controller.dart';
import '../models/candidato_model.dart';
import '../models/constantes_model.dart';
import '../providers/favoritos_provider.dart';
import '../widgets/circular_progress_widget.dart';
import '../widgets/favoritos_contador.dart';
import 'candidato_widget.dart';
import 'favoritos_page.dart';
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
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // OJO: PROBLEMA DE NAVEGACION SI SE 'PUSH' ESTA PAGINA DE NUEVO
    // 0.- Se vuelve a invocar initState
    // 1.- El Stream ya esta tomado
    // 2.- Perdemos la página anterior
    super.initState();

    // Shortcut a la lista
    _lista = widget.candidatoCtrl.candidatos;

    // SI NO HAY LISTENER
    //if (!widget.candidatoCtrl.hasListener) {
    // Stream de información si está cargando elementos...
    widget.candidatoCtrl.onSync.listen((bool syncState) {
      //if (!mounted) return;
      setState(() {
        print('onSync $syncState');
        _estaCargando = syncState;
      });
    });
    // Primera lectura de datos
    this._fechtProximaPagina();
    //}

    // Lectura de página si hacemos scroll hacia arriba
    _scrollCtrl = ScrollController();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels == _scrollCtrl.position.maxScrollExtent)
        _fechtProximaPagina();
    });
  }

  Future _fechtProximaPagina() async {
    if (_estaCargando) return;
    print('cargando...${widget.candidatoCtrl.pagina + 1}');
    // En modo sincrono se queda bloqueada cuando hemos vuelto de otroa página
    //_lista = await widget.candidatoCtrl.fechtCandidatos();
    widget.candidatoCtrl.fechtCandidatos().then((_) => {});
    //setState(() { print('then'); }));
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
                    Stack(
                      children: [
                        if (favoritos.lista.length > 0)
                          Positioned(
                              top: 20,
                              child: FavoritosContador(favoritos.lista.length)),
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: favoritos.lista.length < 1
                                ? Colors.amber
                                : Colors.white,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                        ),
                      ],
                    )),
            SizedBox(
              width: 15,
            )
          ],
        ),
        drawer: NavigationDrawer(),
        endDrawer: FavoritosPage(
          title: 'Favoritos',
        ),
        body: Column(
          children: [
            // LISTVIEW
            // Expand <- me gusta más, pero por no añadir más widgets
            Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight -
                    ctes.alturaPie,
                child: ListView.builder(
                  controller: _scrollCtrl,
                  key: PageStorageKey('candidatos'), // par mantener el Estado
                  itemCount: _lista.length + 1, //+1 para forzar scroll
                  itemBuilder: (_, i) {
                    if (i == _lista.length)
                      return CircularProgress(_estaCargando);
                    return CandidatoWidget(item: _lista[i], index: i);
                  },
                )),
            //PIE
            Container(
                height: ctes.alturaPie,
                child: Center(
                    child: _estaCargando
                        ? Text('Cargando. . .')
                        : Text('Items: ${_lista.length}'))),
          ],
        ));
  }
}
