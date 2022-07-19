import 'package:faal/utils/styles_context.dart';
import 'package:faal/utils/text_styles.dart';
import 'package:faal/views/Payments/Order/qr_viewer.dart';
import 'package:faal/views/Payments/Order/widget/pr_tile.dart';
import 'package:faal/views/responses/wait_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Models/order_model.dart';
import '../../../controllers/order_controller.dart';
import '../../../widgets/button_primary.dart';

// ignore: must_be_immutable
class SuccesOrderPage extends StatefulWidget {
  String? order;

  SuccesOrderPage({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SuccesOrderPageState createState() => _SuccesOrderPageState();
}

class _SuccesOrderPageState extends State<SuccesOrderPage> {
  var orderGet = Get.find<OrderController>();

  @override
  void initState() {
    orderGet.getOneOrderDetail(widget.order);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (_) {
        if (_.isLoadDetailOrder) {
          return const WaitPage();
        } else {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: systemDart,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                '¡Gracias por tu compra!',
                style: titleAppBar,
              ),
              centerTitle: true,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset('assets/logo.png'),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    'Datos de compra:',
                    style: titleDetail,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'N° de pedido: ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _.orderDetail!.woorderId!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Dirección: ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${_.orderDetail!.deliveryAddress!.address}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _.orderDetail!.methodPay!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total: ',
                              style: priceTotalItems,
                            ),
                            Text(
                              '\$${_.orderDetail!.amount!.toStringAsFixed(2)}',
                              style: priceTotalItems,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ButtonPrimary(
                    title: 'Ir al inicio',
                    onPressed: () {
                      // _.newOrder();
                      Get.back();
                      Get.back();
                    },
                    load: _.isLoadingOrder,
                    disabled: _.isLoadingOrder,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
