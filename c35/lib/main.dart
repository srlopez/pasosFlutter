import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/user.dart';
import 'widget/circular_progress.dart';

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
  var _page = 1;
  var _rows = 20;
  bool _isLoading = false;

  var _ulist = <User>[];
  // Podría ser una lista dynamic
  // var _mlist = <dynamic>[];

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
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

    var _users = await UserRepository.fechtNextPage(_page, _rows);
    _ulist.addAll(_users);
    _page++;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var detalleHeight = 300.0;

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
                      //return Text(_mlist[i]['name']['first'],
                      return Text(_ulist[i].nombre,
                          style: Theme.of(context).textTheme.headline4);
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
