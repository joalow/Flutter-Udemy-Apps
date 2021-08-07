import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showAlert(context),
          child: Text("Button click"),
          style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey, shape: StadiumBorder()),
        ),
      ),
      appBar: AppBar(
        title: Text('AlertPage'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.reset_tv_rounded),
          onPressed: () => Navigator.pop(context)),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text("Dialog alert"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Este es el contenido de la alerta"),
                FlutterLogo(
                  size: 100.0,
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
              ),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Confirm"))
            ],
          );
        });
  }
}
