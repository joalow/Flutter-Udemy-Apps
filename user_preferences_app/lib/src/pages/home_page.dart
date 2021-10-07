import 'package:flutter/material.dart';
import 'package:user_preferences_app/src/shared_prefs/preferencias_usuario.dart';
import 'package:user_preferences_app/src/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static final routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();
    prefs.ultimaPagina = 'home';

    return Scaffold(
      appBar: AppBar(
        title: Text("Preferencias usuario"),
      ),
      drawer: MenuWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Color secundario: ${prefs.colorSecundario}"),
          Divider(),
          Text("Genero: ${prefs.genero}"),
          Divider(),
          Text("Nombre Usuario: ${prefs.usuario}"),
          Divider(),
        ],
      ),
    );
  }
}
