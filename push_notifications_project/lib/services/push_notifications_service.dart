//SHA-1:  83:79:42:68:C1:7A:10:73:8E:74:EF:45:CC:01:DB:71:55:A5:53:AF

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream =
      // ignore: unnecessary_new
      new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    print('Background handler ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'Default title');
  }

  static Future _onMessagedHandler(RemoteMessage message) async {
    _messageStream.add(message.notification?.title ?? 'Default title');
    print('message handler ${message.messageId}');
  }

  static Future _onOpendHandler(RemoteMessage message) async {
    _messageStream.add(message.notification?.title ?? 'Default title');
    print('open handler ${message.messageId}');
  }

  static Future initializeApp() async {
    //Push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    print('Token $token');

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessagedHandler);
    //FirebaseMessaging.onMessageOpenedApp.listen(_onOpendHandler);
  }

  static closeStreams() {
    _messageStream.close();
  }
}
