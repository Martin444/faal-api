import 'dart:convert';

import 'package:faal_new2/Models/notifications_model.dart';
import 'package:faal_new2/services/notify_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../helps/snacks_messages.dart';

class NotificationsControllers extends GetxController {
  final FirebaseMessaging _fmc = FirebaseMessaging.instance;

  String? message;

  Future<String?> registerOnFirebase() async {
    try {
      _fmc.requestPermission();
      _fmc.subscribeToTopic('news');
      _fmc.getToken();
      return await _fmc.getToken();
    } catch (e) {
      throw Exception(e);
    }
  }

  void getMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      printInfo(info: '[Firebase Messaging] onMessage: $message');
      // setState(() {
      //   this.message = message.notification!.body;
      // });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      printInfo(info: '[Firebase Messaging] onMessageOpenedApp: $message');
      // setState(() {
      //   this.message = message.notification!.body;
      // });
    });
  }

  bool isSending = false;
  bool isLoadingNotifications = false;

  var listNotificationsHistory = <NotificationsModels>[];

  Future<int> sendnotificationusers(String title, String description) async {
    try {
      isSending = true;
      update();
      var response = await NotifyService().newNotify(title, description);

      if (response.statusCode == 201) {
        printInfo(info: 'Status ${response.statusCode}');
        printInfo(info: 'Body ${response.body}');
        isSending = false;
        update();
        getAllNotifications();
        return response.statusCode;
      } else {
        SnackMessagesHandle().snackErrorHandle(
          'Hubo un error, intenta nuevamente.',
        );
        return 0;
      }
    } catch (e) {
      SnackMessagesHandle().snackErrorHandle('Error: $e');
      throw Exception(e);
    }
  }

  void getAllNotifications() async {
    isLoadingNotifications = true;
    update();
    var response = await NotifyService().getNotify();

    if (response.statusCode == 200) {
      listNotificationsHistory = [];
      var jsonResponse = jsonDecode(response.body);

      jsonResponse.forEach((e) {
        listNotificationsHistory.add(NotificationsModels(
          id: e['id'],
          title: e['title'],
          body: e['body'],
        ));
      });
      isLoadingNotifications = true;
      update();
    }
  }
}
