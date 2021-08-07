import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class _MenuProvider {
  List<dynamic> opciones = [];

  _MenuProvider();

  Future<List<dynamic>> loadData() async {
    final resp = await rootBundle.loadString('data/menu_opts.json');

    Map dataMap = jsonDecode(resp);
    opciones = dataMap['rutas'];
    print(opciones);
    return opciones;
  }
}

final menuProvider = new _MenuProvider();
