import 'package:faal_new2/controllers/cart_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/order_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles_context.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/button_primary.dart';
import '../../responses/wait_page.dart';

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
  var cartList = Get.find<CartListController>();

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
            backgroundColor: Colors.white,
            appBar: AppBar(
              systemOverlayStyle: systemDart,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: SizedBox(
                height: 40,
                child: TextButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    'assets/back.svg',
                    width: 30,
                    height: 30,
                    color: Colors.black,
                  ),
                ),
              ),
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
                  const SizedBox(height: 26),
                  Center(
                    child: SvgPicture.asset('assets/okeylogo.svg'),
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
                              'Tipo: ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${_.orderDetail!.deliveryType}',
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    decoration: decorationMethod,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/cash.svg',
                              color: kpurplecolor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              _.orderDetail!.methodPay!,
                              style: titleAppBar,
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
                      cartList.clearList();
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
