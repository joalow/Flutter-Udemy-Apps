import 'dart:async';

import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  ListViewPage({Key? key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  List<int> _nums = [];
  int _last = 0;
  bool _isLoading = false;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("List Page")),
        body: Stack(children: [_crearLista(), _crearLoading()]));
  }

  Widget _crearLista() {
    return RefreshIndicator(
      onRefresh: _getPagina1,
      child: ListView.builder(
          controller: _scrollController,
          itemCount: _nums.length,
          itemBuilder: (BuildContext context, int index) {
            final imagen = _nums[index];
            return FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image:
                    NetworkImage('https://picsum.photos/id/$imagen/500/300'));
          }),
    );
  }

  void _addTen() {
    for (int i = 0; i < 10; i++) {
      _last++;
      _nums.add(_last);
    }
    setState(() {});
  }

  Future _fetchData() async {
    _isLoading = true;
    setState(() {
      final duration = new Duration(seconds: 2);
      Timer(duration, () => repuestaHttp());
    });
  }

  void repuestaHttp() {
    _isLoading = false;
    _scrollController.animateTo(_scrollController.position.pixels + 100.0,
        duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
    _addTen();
  }

  Widget _crearLoading() {
    if (_isLoading) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()])
          ]);
    }
    return Container();
  }

  Future<Null> _getPagina1() {
    Timer(Duration(seconds: 2), () {
      _nums.clear();
      _last++;
      _addTen();
    });
    return Future.delayed(Duration(seconds: 2));
  }
}
