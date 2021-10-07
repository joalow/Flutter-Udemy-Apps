import 'package:flutter/material.dart';
import 'package:user_preferences_app/src/shared_prefs/preferencias_usuario.dart';
import 'package:user_preferences_app/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static final routeName = "settings";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final PreferenciasUsuario _prefs = PreferenciasUsuario();

  bool _colorSecundario = false;
  int _genero = 1;
  String _nombre = "Pedro";

  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    _cargarPref();
  }

  _cargarPref() {
    _genero = _prefs.genero;
    _colorSecundario = _prefs.colorSecundario;
    _nombre = _prefs.usuario;
    _textEditingController = TextEditingController(text: _prefs.usuario);
    _prefs.ultimaPagina = 'settings';
    setState(() {});
  }

  _setSelectedRadio(int? valor) async {
    _prefs.genero = ((valor ?? 1));

    _genero = valor ?? 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes"),
        backgroundColor: _colorSecundario ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
          ),
          Text(
            "Settings",
            style: TextStyle(fontSize: 40.0),
          ),
          Divider(),
          SwitchListTile(
              value: _colorSecundario,
              title: Text("Color secundario:"),
              onChanged: (value) => setState(() {
                    _colorSecundario = value;
                    _prefs.colorSecundario = (value);
                  })),
          RadioListTile<int>(
              value: 1,
              title: Text("Masculino"),
              groupValue: _genero,
              onChanged: _setSelectedRadio),
          RadioListTile<int>(
              value: 2,
              title: Text("Femenino"),
              groupValue: _genero,
              onChanged: _setSelectedRadio),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                  labelText: 'Nombre',
                  helperText: 'Nombre de la persona que usa el telf'),
              onChanged: (value) => setState(() => _prefs.usuario = value),
            ),
          )
        ],
      ),
    );
  }
}
