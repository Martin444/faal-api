import 'package:faal_new2/controllers/navigations_controller.dart';
import 'package:faal_new2/utils/text_styles.dart';
import 'package:faal_new2/views/orders/widgets/list_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  var navigate = Get.find<NavigationsControllers>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigate.setIndexPage(1);
        return false;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mis ordenes',
              style: titleAppBar,
            ),
            const SizedBox(
              height: 20,
            ),
            const ListOrders()
          ],
        ),
      ),
    );
  }
}
