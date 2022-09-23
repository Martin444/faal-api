import 'package:faal_new2/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Models/notifications_model.dart';
import '../../../helps/rules.dart';
import '../../../utils/styles_context.dart';

class HistoryCard extends StatelessWidget {
  NotificationsModels model;
  int? length;

  HistoryCard({
    Key? key,
    required this.model,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: Get.width * 0.05),
          child: const Dashes(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          width: Get.width,
          decoration: decorationMethod,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.title!,
                style: priceProduct,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model.body!,
                style: titleProduct,
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Dashes extends StatelessWidget {
  const Dashes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 100,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainHeight();
          const dashWidth = 2.0;
          const dashHeight = 5.0;
          final dashCount = (boxWidth / (5 * dashWidth)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.vertical,
            children: List.generate(
              dashCount,
              (_) {
                return SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xff8F959A).withOpacity(0.7),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
