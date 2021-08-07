import 'package:flutter/material.dart';
import 'package:appwidgets/src/providers/menu_provider.dart';
import 'package:appwidgets/src/utils/icons_util.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _lista(),
    );
  }
}

Widget _lista() {
  print("lista");
  return FutureBuilder(
    future: menuProvider.loadData(),
    initialData: [],
    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
      return ListView(
        children: _listaItems(snapshot.data, context),
      );
    },
  );
}

List<Widget> _listaItems(List<dynamic>? data, BuildContext context) {
  final List<Widget> list = [];
  data!.forEach((element) {
    final temp = ListTile(
      title: Text(element['texto']),
      leading: getIcon(element['icon']),
      trailing: getIcon(element['icon']),
      onTap: () {
        Navigator.pushNamed(context, element['ruta']);
      },
    );

    list.add(temp);
  });

  return list;
}
