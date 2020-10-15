import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:math';
import 'dart:convert';

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
  // State
  var _list = <Contador>[];
  var _rnd = Random();

  void _newContador() {
    int sg = _rnd.nextInt(7);

    setState(() {
      //_list.add(Contador(_nombrarConRetraso(sg), sg));
      //_list.add(Contador(_fetchNombre(), sg));
      _list.add(Contador(_nombre(sg), sg));
    });
  }

  Future<String> _nombre(int i) async => 'Espero $i sg';

  Future<String> _nombrarConRetraso(int sg) =>
      Future.delayed(Duration(seconds: sg), _fetchNombre);

  Future<String> _fetchNombre() async {
    int id = 1 + _rnd.nextInt(9);
    final response =
//await http.get('https://jsonplaceholder.typicode.com/users/$id');
//https://randomuser.me/api/?page=1&results=20&seed=123
        await http.get('https://randomuser.me/api/');

    if (response.statusCode == 200) {
      //return jsonDecode(response.body)["name"];
      var name = jsonDecode(response.body)["results"][0]['name'];
      print(name.toString());
      return '${name["title"]}. ${name["first"]} ${name["last"]}';
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
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (_, i) {
          return ContadorWidget(item: _list[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newContador,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
