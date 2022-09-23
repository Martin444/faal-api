import 'package:faal_new2/controllers/notifications_controllers.dart';
import 'package:faal_new2/utils/text_styles.dart';
import 'package:faal_new2/views/notifications/widget/history_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/anim/delayed_reveal.dart';

class HistoryNotifications extends StatefulWidget {
  const HistoryNotifications({Key? key}) : super(key: key);

  @override
  State<HistoryNotifications> createState() => _HistoryNotificationsState();
}

class _HistoryNotificationsState extends State<HistoryNotifications> {
  var notHistory = Get.find<NotificationsControllers>();

  @override
  void initState() {
    notHistory.getAllNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsControllers>(
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Historial de notificationces',
              style: titleAppBar,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: Get.height * 0.50,
              child: ListView.builder(
                itemCount: _.listNotificationsHistory.length,
                itemBuilder: (context, index) {
                  return DelayedReveal(
                    delay: const Duration(milliseconds: 100),
                    child: HistoryCard(
                      model: _.listNotificationsHistory[index],
                      length: _.listNotificationsHistory.length,
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
