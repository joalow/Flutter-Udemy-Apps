import 'package:flutter/material.dart';
import 'package:productos_app/src/screens/screens.dart';
import 'package:productos_app/src/services/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProductService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: ,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.indigo,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo, elevation: 0)),
      scaffoldMessengerKey: NotificationsService.messengerKey,
      initialRoute: "check",
      routes: {
        'check': (BuildContext context) => CheckAuthScreen(),
        "home": (BuildContext context) => HomeScreen(),
        "product": (BuildContext context) => ProductScreen(),
        "login": (BuildContext context) => LoginScreen(),
        "register": (BuildContext context) => RegisterScreen(),
      },
    );
  }
}
