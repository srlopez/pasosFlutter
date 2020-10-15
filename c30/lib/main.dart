import 'package:c05/widget/circular_progress.dart';
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
  var _isLoading = false;

  StreamController<Contador> _streamController;
  Stream<Contador> _stream;

  ScrollController _scrollController;
  // = ScrollController(); //<-? inicializamos en initState?

  @override
  void initState() {
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels > 0)
          // en bottom
          // Acabamos de llegar al final del ultimo Widget pintado en pantall
          // es hora de añadir uno mas al sink
          _newContadorScroll();
        // else {
        //   //en top
        //   assert(_scrollController.position.pixels == 0);
        // }
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
    _streamController.sink.add(Contador(_nombre, _list.length));

    if (_scrollController.positions.isNotEmpty)
      _scrollController.jumpTo(//fuerza un scroll
          //para que no lance un scroll y añada un nuevo contador resto -1
          _scrollController.position.maxScrollExtent - 1);
  }

  void _newContadorScroll() {
    final _nombre = 'scroll ${_nominar()}';
    _streamController.sink.add(Contador(_nombre, -_list.length));
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
              controller: _scrollController,
              itemCount: _list.length + 1,
              itemBuilder: (_, i) {
                print('${_scrollController.position.pixels}');
                return i < _list.length
                    ? ContadorWidget(item: _list[i])
                    : CircularProgress(_scrollController.position.pixels > 0);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _newContador,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
