import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_list_controller.dart';
// import 'package:stocky/Controllers/cart_list_controller.dart';
// import 'package:stocky/Widgets/const.dart';
// import 'package:stocky/Widgets/custom_switcher.dart';

class TypePayment extends StatelessWidget {
  const TypePayment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartListController>(
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Paga con:',
              // style: primaryText1,
            ),
            SwitchSelectType(
              title: 'Efectivo',
              value: !_.targetPay!,
              onChanged: (value) {
                _.setTargetPay(!value);
              },
            ),
            SwitchSelectType(
              title: 'Tarjeta',
              value: _.targetPay,
              onChanged: (value) {
                _.setTargetPay(value);
              },
            ),
          ],
        );
      },
    );
  }
}

// ignore: must_be_immutable
class SwitchSelectType extends StatelessWidget {
  String? title;
  bool? value;
  ValueChanged<bool>? onChanged;

  SwitchSelectType({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            // style: secundaryText,
          ),
          // CustomSwitch(
          //   value: value!,
          //   onChanged: onChanged!,
          // ),
        ],
      ),
    );
  }
}
