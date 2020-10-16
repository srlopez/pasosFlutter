import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:math';
import 'dart:convert';
import 'dart:async';

import 'models/contador.dart';
import 'widgets/contador.dart';

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
  // State
  var _list = <Contador>[];
  var _rnd = Random();

  StreamController<Contador> _streamController;
  Stream<Contador> _stream;

  @override
  void initState() {
    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  @override
  void dispose() {
    _streamController.close();
  }

  void _newContador() {
    int sg = _rnd.nextInt(7);
    // Enviamos una instancia del modelo al stream
    _streamController.sink.add(Contador(_nombrarConRetraso(sg), sg));
    // No tenemos que llamar setState
  }

  Future<String> _nombrarConRetraso(int sg) =>
      Future.delayed(Duration(seconds: sg), _fetchNombre);

  Future<String> _fetchNombre() async {
    final response =
//https://randomuser.me/api/?page=1&results=20&seed=123
        await http.get('https://randomuser.me/api/');

    if (response.statusCode == 200) {
      var name = jsonDecode(response.body)["results"][0]['name'];
      return '${name["title"]}. ${name["first"]} ${name["last"]} ';
    } else {
      print('response.statusCode $response.statusCode');
      throw Exception('No se encuentra un nombre');
    }
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
              itemCount: _list.length,
              itemBuilder: (_, i) {
                return ContadorWidget(item: _list[i]);
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
