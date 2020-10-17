import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../widgets/circular_progress_widget.dart';
import '../widgets/user_widget.dart';
import '../controllers/user_controller.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.controller}) : super(key: key);

  final String title;
  final UserController controller;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _page = 1;
  var _rows = 20;
  bool _isLoading = false;

  var _ulist = <User>[];

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    widget.controller.onSync.listen((bool syncState) => setState(() {
          _isLoading = syncState;
        }));

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) _getUsers();
    });

    this._getUsers();
  }

  Future _getUsers() async {
    _ulist = await widget.controller.fechtUsers(_page, _rows);
    print('length: ${_ulist.length}');
    _page++;
  }

  @override
  Widget build(BuildContext context) {
    var detalleHeight = 100.0;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight -
                    detalleHeight,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _ulist.length + 1,
                  itemBuilder: (_, i) {
                    if (i == _ulist.length)
                      return CircularProgress(_isLoading);
                    else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('#$i'),
                          SizedBox(width: 5),
                          UserWidget(item: _ulist[i]),
                        ],
                      );
                    }
                  },
                )),
            Container(
                height: detalleHeight,
                child: Center(
                    child: _isLoading
                        ? Text('Cargando...')
                        : Text('Items: ${_ulist.length}'))),
          ],
        ));
  }
}
