import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/order_controller.dart';

class SuccessPayment extends StatefulWidget {
  const SuccessPayment({Key? key}) : super(key: key);

  @override
  State<SuccessPayment> createState() => _SuccessPaymentState();
}

class _SuccessPaymentState extends State<SuccessPayment> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (_) {
      return Scaffold(
        body: Column(
          children: const [],
        ),
      );
    });
  }
}
