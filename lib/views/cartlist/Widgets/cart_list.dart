import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_list_controller.dart';
import '../../../widgets/anim/delayed_reveal.dart';
import 'cart_tile.dart';

class ListCarts extends StatelessWidget {
  const ListCarts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartListController>(
      builder: (_) {
        return SizedBox(
          height: Get.height * 0.7,
          child: ListView.builder(
              itemCount: _.listCart!.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return DelayedReveal(
                  delay: Duration(milliseconds: index * 200),
                  child: CartTile(
                    product: _.listCart![index],
                  ),
                );
              }),
        );
      },
    );
  }
}
