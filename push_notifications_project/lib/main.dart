import 'package:flutter/material.dart';
import 'package:push_notifications_project/screens/home_screen.dart';
import 'package:push_notifications_project/screens/message_screen.dart';
import 'package:push_notifications_project/services/push_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    PushNotificationService.messagesStream.listen((message) {
      print('MyApp');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "home",
      routes: {'home': (_) => HomeScreen(), 'message': (_) => MessageScreen()},
    );
  }
}
