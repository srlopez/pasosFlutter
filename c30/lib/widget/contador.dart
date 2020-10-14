import 'package:flutter/material.dart';
import '../model/contador.dart';

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
        Text(widget.item.nombre, style: TextStyle(fontStyle: FontStyle.italic)),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              onPressed: () => _incrementCounter(1),
              icon: Icon(Icons.add),
              color: Colors.green),
          Text(
            '${widget.item.valor}',
            style: Theme.of(context).textTheme.headline3.apply(
                color: widget.item.valor < 0
                    ? Colors.amber
                    : Colors.grey.withOpacity(1)),
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
