import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  SliderPage({Key? key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valorSlider = 101.0;
  bool _bloquearCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider Page"),
      ),
      body: Container(
        child: Column(
          children: [
            _crearSlider(),
            _crearCheck(),
            _crearSwitch(),
            Expanded(
              child: _crearImagen(),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearSlider() {
    return Slider(
      onChanged: _bloquearCheck
          ? null
          : (double value) {
              setState(() {
                _valorSlider = value;
              });
            },
      label: 'Tamaño imagen',
      //divisions: 20,
      activeColor: Colors.indigo,
      value: _valorSlider,
      min: 100,
      max: 500,
    );
  }

  Widget _crearImagen() {
    return Image(
      fit: BoxFit.contain,
      width: _valorSlider,
      image: NetworkImage(
          'https://media1.tenor.com/images/24ccfcc1ef7e9b2de9dee881b7490e7f/tenor.gif?itemid=4476392'),
    );
  }

  _crearCheck() {
    return CheckboxListTile(
      title: Text('Bloquear Slider'),
      value: _bloquearCheck,
      onChanged: (valor) {
        setState(() {
          _bloquearCheck = valor!;
        });
      },
    );
  }

  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text('Bloquear Slider'),
      value: _bloquearCheck,
      onChanged: (valor) {
        setState(() {
          _bloquearCheck = valor;
        });
      },
    );
  }
}
