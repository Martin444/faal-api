import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_list_controller.dart';

class ResumeCard extends StatelessWidget {
  const ResumeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartListController>(builder: (_) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          // color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total a pagar:',
              // style: primaryTextWhite,
            ),
            Hero(
              tag: 'price',
              child: Row(
                children: [
                  const Text(
                    r'$',
                    // style: primaryTextWhite,
                  ),
                  Text(
                    '${_.totalPrice}',
                    // style: primaryTextWhite,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
