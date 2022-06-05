import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_list_controller.dart';
import '../../../widgets/button_primary.dart';

class ActionsBtn extends StatelessWidget {
  const ActionsBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartListController>(builder: (_) {
      return Column(
        children: [
          ButtonPrimary(
            title: 'Confirmar',
            onPressed: () {
              // _.processBuy();
            },
            load: false,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    });
  }
}
