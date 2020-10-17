import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserWidget extends StatefulWidget {
  UserWidget({Key key, this.item}) : super(key: key);
  final User item;

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  // Los eventos que modifican el estado
  void _incrementCounter(int delta) {
    setState(() {
      widget.item.valor += delta;
    });
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
            style: Theme.of(context).textTheme.headline5.apply(
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
