import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../widgets/circular_progress_widget.dart';
import '../widgets/user_widget.dart';
import '../services/user_services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _page = 1;
  var _rows = 20;
  bool _isLoading = false;

  var _ulist = <User>[];

  ScrollController _scrollController;
  HttpServices _userServices;

  @override
  void initState() {
    super.initState();

    _userServices = HttpServices();
    this._getNextPage();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) _getNextPage();
    });
  }

  Future _getNextPage() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    var _users = await _userServices.fechtNextPage(_page, _rows);
    _ulist.addAll(_users);
    _page++;

    setState(() {
      _isLoading = false;
    });
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
                      // return Text(_ulist[i].nombre,
                      //     style: Theme.of(context).textTheme.headline4);
                      return UserWidget(item: _ulist[i]);
                    }
                  },
                )),
            Container(
                height: detalleHeight,
                child: Container(
                  height: 0,
                  width: 0,
                )),
          ],
        ));
  }
}
