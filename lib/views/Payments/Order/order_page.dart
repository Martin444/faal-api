import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/order_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles_context.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/button_primary.dart';
import 'widget/list_prod_details.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final eventResponse = const EventChannel('faal.martinfarel.com/response');
  var orderproces = Get.find<OrderController>();

  // ignore: unused_field
  StreamSubscription? _suscriptiomStream;

  @override
  void initState() {
    _suscriptiomStream = eventResponse.receiveBroadcastStream().listen(
      (event) {
        orderproces.processPaymentResponse(event);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: systemDart,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                margin: const EdgeInsets.only(left: 15),
                child: SvgPicture.asset('assets/back.svg'),
              ),
            ),
            leadingWidth: 45,
            title: Text(
              'Resumen',
              style: titleAppBar,
            ),
            centerTitle: true,
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: Get.height,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      // Details products

                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 13,
                        ),
                        decoration: BoxDecoration(
                          color: kModalcolor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 8),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detalle del pedido:',
                              style: titleAppBar,
                            ),
                            const SizedBox(height: 16),
                            const ListProdetails(),
                            const Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                            if (_.methodPaySelect == 'Mercado pago')
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset('assets/mercado.png'),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Comisión de mercado pago:',
                                          style: titlePromotionProduct,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '\$${_.mpComision.toStringAsFixed(2)}',
                                      style: titleAppBar,
                                    )
                                  ],
                                ),
                              ),
                            // Total a pagar
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total a pagar: ',
                                        style: titleAppBar,
                                      ),
                                      Text(
                                        '\$${_.totalPayment.toStringAsFixed(2)}',
                                        style: priceTotalItems,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      // Detail payment
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 8),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Elige el método de pago:',
                              style: titleAppBar,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButton<String>(
                                key: const Key('3'),
                                value: _.methodPaySelect,
                                elevation: 2,
                                items: [
                                  DropdownMenuItem(
                                    key: const Key('1'),
                                    value: 'Mercado pago',
                                    child: Text(
                                      'Mercado pago',
                                      style: titlePromotionProduct,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    key: const Key('2'),
                                    value: 'Pago adelantado en el local',
                                    child: Text(
                                      'Pago adelantado en el local',
                                      style: titlePromotionProduct,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    key: const Key('4'),
                                    value: 'Pago adelantado por transferencia',
                                    child: Text(
                                      'Pago adelantado por transferencia',
                                      style: titlePromotionProduct,
                                    ),
                                  ),
                                ],
                                onChanged: (c) {
                                  _.selectMethodPay(c!);
                                },
                              ),
                            ),
                            if (_.methodPaySelect! ==
                                'Pago adelantado por transferencia')
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Tap para copiar:',
                                    style: titleAppBar,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(
                                        const ClipboardData(
                                          text: '0720327320000000378440',
                                        ),
                                      ).then(
                                        (value) => {
                                          Get.showSnackbar(
                                            const GetSnackBar(
                                              duration: Duration(seconds: 1),
                                              message: 'CBU Copiado!',
                                            ),
                                          ),
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: kgraycolor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/duplicate.svg'),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '0720327320000000378440',
                                            style: titleAppBar,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _.deliverySelected == 'Retiro en persona'
                                    ? Text(
                                        'Retira en:',
                                        style: titleAppBar,
                                      )
                                    : Text(
                                        'Dirección de entrega:',
                                        style: titleAppBar,
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/location-marker.svg'),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '${_.myAddress!.city}, ${_.myAddress!.address}',
                                      style: titleAppBar,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonPrimary(
                      title: 'Finalizar compra',
                      onPressed: () {
                        _.newOrder();
                      },
                      load: _.isLoadingOrder,
                      disabled: _.isLoadingOrder,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
