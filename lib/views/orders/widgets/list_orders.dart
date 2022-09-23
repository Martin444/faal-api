import 'package:faal_new2/controllers/order_controller.dart';
import 'package:faal_new2/utils/text_styles.dart';
import 'package:faal_new2/views/orders/widgets/card_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/anim/delayed_reveal.dart';

class ListOrders extends StatefulWidget {
  const ListOrders({Key? key}) : super(key: key);

  @override
  State<ListOrders> createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  var orderCtrl = Get.find<OrderController>();

  @override
  void initState() {
    super.initState();
    orderCtrl.getOrdersProfile();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (_) {
        if (_.isLoadDetailOrderList) {
          return Center(
            child: SizedBox(
              height: 170,
              child: Image.asset('assets/logo-animate.gif'),
            ),
          );
        }
        return SizedBox(
            height: Get.height - 180,
            child: _.orderDetails.isNotEmpty
                ? ListView.builder(
                    itemCount: _.orderDetails.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return DelayedReveal(
                        delay: const Duration(milliseconds: 100),
                        child: CardOrder(
                          model: _.orderDetails[index],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No hay ninguna orden aún',
                      style: titleAppBar,
                    ),
                  ));
      },
    );
  }
}
