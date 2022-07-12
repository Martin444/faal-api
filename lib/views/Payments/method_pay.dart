import 'package:faal/utils/styles_context.dart';
import 'package:faal/utils/text_styles.dart';
import 'package:faal/views/Payments/Cards/create_card_page.dart';
import 'package:faal/views/Payments/widgets/pay_icons.dart';
import 'package:faal/views/Payments/widgets/title_expand.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../controllers/order_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/button_primary.dart';
import 'delivery/delivery_method.dart';

class MethodPay extends StatefulWidget {
  const MethodPay({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MethodPayState createState() => _MethodPayState();
}

class _MethodPayState extends State<MethodPay> {
  var cards = Get.find<OrderController>();

  @override
  void initState() {
    super.initState();
    cards.getMyCards();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (_) {
        // ignore: unnecessary_null_comparison
        if (_.myCards != null) {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: systemDart,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Método de pago',
                style: titleAppBar,
              ),
              centerTitle: true,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'ELEGÍ EL MEDIO DE PAGO MÁS COMODO PARA VOS',
                      textAlign: TextAlign.center,
                      style: titleSecundary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(10),
                    decoration: _.methodPaySelect == 1
                        ? decorationMethodSelected
                        : decorationMethod,
                    child: ExpansionTile(
                      onExpansionChanged: (va) {
                        _.selectMethodPay(1);
                      },
                      tilePadding: const EdgeInsets.all(0),
                      title: TitleExpand(
                        path: 'assets/cash.svg',
                        title: 'PAGO EN EFECTIVO EN EL LOCAL:',
                        subtitle: 'ACERCATE A NUESTRO LOCAL Y PAGÁ EN EFECTIVO',
                      ),
                      expandedAlignment: Alignment.topLeft,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '¿Cómo llegar?',
                            style: buttonStylePrimaryBlues,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(10),
                    decoration: _.methodPaySelect == 2
                        ? decorationMethodSelected
                        : decorationMethod,
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.all(0),
                      onExpansionChanged: (va) {
                        _.selectMethodPay(2);
                      },
                      title: TitleExpand(
                        path: 'assets/library.svg',
                        title: 'PAGO CON TRANSFERENCIA:',
                        subtitle:
                            'COPIA NUESTRO CBU PARA EFECTUAR EL PAGO. DESPUES, AGREGA EL COMPROBANTE EN EL DETALLE DE TU PEDIDO EN LA SECCION DE “MIS PEDIDOS” EN TU PERFIL ',
                      ),
                      children: [
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
                                SvgPicture.asset('assets/duplicate.svg'),
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
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(10),
                    decoration: _.methodPaySelect == 3
                        ? decorationMethodSelected
                        : decorationMethod,
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.all(0),
                      onExpansionChanged: (va) {
                        _.selectMethodPay(3);
                      },
                      title: TitleExpand(
                        path: 'assets/credit.svg',
                        title: 'PAGO CON TARJETA:',
                        subtitle:
                            'ELIGE ALGUNA DE LAS TARJETAS DE TU BILLETERA.',
                      ),
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => const CreateCardPage(),
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
                                  'assets/plus.svg',
                                  color: kpurplecolor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'AGREGA UNA TARJETA',
                                  style: buttonStylePrimaryBlues,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const PaymentsIcons(),
                  ButtonPrimary(
                    title: 'Siguiente',
                    onPressed: () {
                      Get.off(
                        () => const DeliveryMethodPage(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    load: false,
                    disabled: _.methodPaySelect == null,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
