import 'package:flutter/material.dart';
import 'package:productos_app/src/screens/home_screen.dart';
import 'package:productos_app/src/screens/login_screen.dart';
import 'package:productos_app/src/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: FutureBuilder(
        future: authService.isAuth(),
        //initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Text("Espere..");

          if (snapshot.data == '') {
            Future.microtask(() {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginScreen(),
                    transitionDuration: Duration(seconds: 1)),
              );
            });
          } else {
            Future.microtask(() {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HomeScreen(),
                    transitionDuration: Duration(seconds: 1)),
              );
            });
          }
          return Container();
        },
      ),
    );
  }
}
