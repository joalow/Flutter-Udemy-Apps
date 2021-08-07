import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  final _opciones = ['Uno', 'Dos', 'Tres'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: ListView(children: _crearItemsCorta()),
    );
  }

  List<Widget> _createItems() {
    List<Widget> list = [];

    for (String opt in _opciones) {
      final tempWidget = ListTile(
        title: Text(opt),
      );
      list..add(tempWidget)..add(Divider());
    }

    return list;
  }

  List<Widget> _crearItemsCorta() {
    var widgets = _opciones.map((opt) {
      return Column(children: [
        ListTile(
          trailing: Icon(Icons.rowing),
          leading: Icon(Icons.done),
          subtitle: Text('SubTitle'),
          title: Text(opt + ' item!'),
          onTap: () {},
        ),
        Divider()
      ]);
    }).toList();
    return widgets;
  }
}
