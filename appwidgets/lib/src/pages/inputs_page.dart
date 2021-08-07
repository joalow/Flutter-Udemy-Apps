import 'package:flutter/material.dart';

class InputsPage extends StatefulWidget {
  InputsPage({Key? key}) : super(key: key);

  @override
  _InputsPageState createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  String _nombre = '';
  String _email = '';
  String _password = '';
  String _fecha = '';
  String _opt = 'Volar';

  TextEditingController _inputDateController = new TextEditingController();
  List<String> _poderes = ['Volar', 'Nadar', 'Saltar'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inputs page"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          _crearInput(),
          SizedBox(
            height: 20,
          ),
          _crearEmail(),
          SizedBox(
            height: 20,
          ),
          _crearPassword(),
          SizedBox(
            height: 20,
          ),
          _crearFecha(context),
          SizedBox(
            height: 20,
          ),
          _crearDropDown(),
          SizedBox(
            height: 20,
          ),
          _crearPersona(),
        ],
      ),
    );
  }

  Widget _crearInput() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        counter: Text('${_nombre.length} characters'),
        hintText: ('Nombre de la persona'),
        labelText: ('Nombre'),
        helperText: 'Solo el nombre',
        suffixIcon: Icon(Icons.person_pin),
        icon: Icon(Icons.people_alt),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        setState(() => _nombre = valor);
      },
    );
  }

  Widget _crearEmail() {
    return TextField(
      //autofocus: true,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: ('Email'),
        labelText: ('Email'),
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        setState(() => _email = valor);
      },
    );
  }

  Widget _crearPassword() {
    return TextField(
      //autofocus: true,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: ('Password'),
        labelText: ('Password'),
        suffixIcon: Icon(Icons.ac_unit_sharp),
        icon: Icon(Icons.password),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        setState(() => _password = valor);
      },
    );
  }

  Widget _crearFecha(BuildContext context) {
    return TextField(
      //autofocus: true,
      enableInteractiveSelection: true,
      controller: _inputDateController,
      keyboardType: TextInputType.visiblePassword,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: ('Fecha'),
        labelText: ('Fecha'),
        suffixIcon: Icon(Icons.calendar_today),
        icon: Icon(Icons.calendar_view_month),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: DateTime(2018),
        locale: Locale('en'),
        lastDate: DateTime(2022));

    if (picked != null) {
      _fecha = picked.toString();
      _inputDateController.text = _fecha;
    }
  }

  List<DropdownMenuItem<String>> _getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = [];
    _poderes.forEach((element) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return lista;
  }

  Widget _crearDropDown() {
    return Row(
      children: [
        Icon(Icons.select_all),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: DropdownButton(
            value: _opt,
            items: _getOpcionesDropdown(),
            onChanged: (option) {
              setState(() {
                _opt = option.toString();
              });
            },
          ),
        )
      ],
    );
  }

  Widget _crearPersona() {
    return ListTile(
      title: Text('Bienvenido $_nombre'),
      subtitle: Text('$_email'),
      trailing: Text(_opt),
    );
  }
}
