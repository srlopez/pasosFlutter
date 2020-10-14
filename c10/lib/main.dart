import 'package:flutter/material.dart';
import 'model/contador.dart';

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

  void _newContador() {
    setState(() {
      _list.add(Contador('Contador #${_list.length + 1}'));
    });
  }

  void _incrementCounter(Contador item, int delta) {
    setState(() {
      item.valor += delta;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),

          //for (var item in _list) ...[ContadorWidget(item: item), Divider()],
          for (var item in _list) ...[
            Text(item.nombre, style: TextStyle(fontStyle: FontStyle.italic)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                  onPressed: () => _incrementCounter(item, 1),
                  icon: Icon(Icons.add),
                  color: Colors.green),
              Text(
                '${item.valor}',
                style: Theme.of(context).textTheme.headline3,
              ),
              IconButton(
                  onPressed: () => _incrementCounter(item, -1),
                  icon: Icon(Icons.remove),
                  color: Colors.red),
            ]),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newContador,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
