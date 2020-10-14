import 'package:flutter/material.dart';
import 'dart:async';

import 'model/contador.dart';
import 'widget/contador.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _list = <Contador>[];

  StreamController<Contador> _streamController;
  Stream<Contador> _stream;

  var _sc = ScrollController(); //<-? inicializamos en initState?

  @override
  void initState() {
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;

    _sc.addListener(() {
      if (_sc.position.atEdge) {
        if (_sc.position.pixels == 0)
          print('en top');
        else {
          print('en bottom');
          // Acabamos de llegar al final del ultimo Widget pintado en pantall
          // es hora de añadir uno mas
          _newContadorScroll();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  var _nominar = () {
    // Este ejemplo es un poco friki
    // ya que _nominar se crea invocando el propio cuerpo de la expresion
    var i = 0;
    var names = [
      'lunes',
      'martes',
      'miercoles',
      'jueves',
      'viernes',
      // 'sabado',
      // 'domingo'
    ];
    return () => names[i++ % names.length];
  }();

  void _newContador() async {
    // Enviamos una instancia del modelo al stream
    final _nombre = 'floating ${_nominar()}';
    print(_nombre);
    //await _fetchNombre();
    _streamController.sink.add(Contador(_nombre, _list.length));
    // No tenemos que llamar setState ?¿?¿
    if (_sc.positions.isNotEmpty)
      setState(() {
        print('floating me muevo al final');
        _sc.jumpTo(//fuerza un scroll
            //para que no lance un scroll y añada un nuevo contador resto -1
            _sc.position.maxScrollExtent - 1);
      });
  }

  void _newContadorScroll() {
    final _nombre = 'scroll ${_nominar()}';
    print(_nombre);

    _streamController.sink.add(Contador(_nombre, -_list.length));

    // setState(() {
    //   // Como lo añadimos a la lista y no al Stream OBLIGAMOS A PINTAR
    //   _list.add(Contador(_nominar(), _list.length));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<Contador>(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.data == null)
              return Center(
                  child: Text(
                'Todavía nada ...',
                style: Theme.of(context).textTheme.headline5,
              ));
            _list.add(snapshot.data);
            return ListView.builder(
              controller:
                  _sc, //<- necesario para controlar el scroll y preguntar
              itemCount: _list.length +
                  1, //<- necesario para obligar a mostrar un elemento más y poder preguntar
              itemBuilder: (_, i) {
                return Column(children: [
                  if (i < _list.length)
                    ContadorWidget(item: _list[i])
                  else ...[
                    // Text(
                    //     '${_sc.position.atEdge} ${_sc.position.pixels} ${_sc.position.maxScrollExtent}',
                    //     style: Theme.of(context).textTheme.headline6),
                    if ((_sc.position?.maxScrollExtent ?? 0) > 0)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                  ]
                ]);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _newContador,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
