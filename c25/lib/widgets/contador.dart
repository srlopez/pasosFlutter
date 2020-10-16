import 'package:flutter/material.dart';
import '../models/contador.dart';

class ContadorWidget extends StatefulWidget {
  ContadorWidget({Key key, this.item}) : super(key: key);
  final Contador item;

  @override
  _ContadorWidgetState createState() => _ContadorWidgetState();
}

class _ContadorWidgetState extends State<ContadorWidget> {
  // Los eventos que modifican el estado
  void _incrementCounter(int delta) {
    widget.item.valor += delta;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // recubrimos el Text con Un FutureBuilder
        // Y mostramos los que nos indique el snapshot
        FutureBuilder(
          future: widget.item.nombre,
          builder: (_, AsyncSnapshot<String> snapshot) {
            var response = (snapshot.hasData)
                ? '${snapshot.data}'
                : (snapshot.hasError)
                    ? 'Error: ${snapshot.error}'
                    : 'Sin name...';
            return Text(response,
                style: TextStyle(fontStyle: FontStyle.italic));
          },
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              onPressed: () => _incrementCounter(1),
              icon: Icon(Icons.add),
              color: Colors.green),
          Text(
            '${widget.item.valor}',
            style: Theme.of(context).textTheme.headline3,
          ),
          IconButton(
              onPressed: () => _incrementCounter(-1),
              icon: Icon(Icons.remove),
              color: Colors.red),
        ]),
      ],
    );
  }
}
