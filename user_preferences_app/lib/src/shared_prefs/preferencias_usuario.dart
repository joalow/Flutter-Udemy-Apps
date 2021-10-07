import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  PreferenciasUsuario._internal();

  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool? _colorSecundario;
  int? _genero;
  String? _nombre;

  int get genero {
    return _prefs.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _prefs.setInt('genero', value);
  }

  bool get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? true;
  }

  set colorSecundario(bool color) {
    _prefs.setBool('colorSecundario', color);
  }

  String get usuario {
    return _prefs.getString('usuario') ?? "Pedro";
  }

  set usuario(String user) {
    _prefs.setString('usuario', user);
  }

  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? "home";
  }

  set ultimaPagina(String ultimaPagina) {
    _prefs.setString('ultimaPagina', ultimaPagina);
  }
}
