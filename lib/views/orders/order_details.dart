import 'package:faal_new2/Models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/styles_context.dart';
import '../../utils/text_styles.dart';
import '../../widgets/button_primary.dart';
import '../Payments/Order/widget/pr_tile.dart';

class OrderDetailPage extends StatefulWidget {
  OrderModel orderDetail;
  OrderDetailPage({
    Key? key,
    required this.orderDetail,
  }) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  var text = 'Mostrar productos';
  @override
  Widget build(BuildContext context) {
    var prodAr = <ProductAr>[];
    for (var e in widget.orderDetail.products!) {
      prodAr.add(ProductAr(
        detail: e,
        isMyorer: false,
      ));
    }
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
          'Detalle de compra',
          style: titleAppBar,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                height: Get.height,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpansionTile(
                      tilePadding: const EdgeInsets.all(0),
                      onExpansionChanged: (va) {
                        printInfo(info: '$va');
                        if (va) {
                          setState(() {
                            text = 'Ocultar productos';
                          });
                        } else {
                          setState(() {
                            text = 'Mostrar productos';
                          });
                        }
                      },
                      title: Text(
                        '$text (${prodAr.length})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: prodAr,
                    ),
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
                                widget.orderDetail.woorderId!,
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
                                '${widget.orderDetail.deliveryAddress!.address}',
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
                                '${widget.orderDetail.deliveryType}',
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
                                widget.orderDetail.methodPay!,
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
                                '\$${widget.orderDetail.amount!.toStringAsFixed(2)}',
                                style: priceTotalItems,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              decoration: const BoxDecoration(color: Colors.white),
              child: ButtonPrimary(
                title: 'Cerrar',
                onPressed: () {
                  // _.newOrder();
                  Get.back();
                },
                load: false,
                disabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
