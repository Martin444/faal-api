import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationsControllers extends GetxController {
  final FirebaseMessaging _fmc = FirebaseMessaging.instance;

  String? message;

  _registerOnFirebase() {
    _fmc.requestPermission();
    _fmc.subscribeToTopic('news');
    _fmc.getToken().then((token) {
      print('[Firebase Messaging] FCM Token: $token');
    });
  }

  void getMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('[Firebase Messaging] onMessage: $message');
      // setState(() {
      //   this.message = message.notification!.body;
      // });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('[Firebase Messaging] onMessageOpenedApp: $message');
      // setState(() {
      //   this.message = message.notification!.body;
      // });
    });
  }
}
