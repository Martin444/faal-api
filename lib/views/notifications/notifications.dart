import 'package:faal_new2/views/notifications/sections/history_send.dart';
import 'package:faal_new2/views/notifications/sections/sender_not.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 10,
        ),
        SenderNotify(),
        HistoryNotifications(),
      ],
    );
  }
}
