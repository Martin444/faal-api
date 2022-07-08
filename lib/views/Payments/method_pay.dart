import 'package:faal/utils/styles_context.dart';
import 'package:faal/utils/text_styles.dart';
import 'package:faal/views/Payments/list_cards.dart';
import 'package:faal/views/Payments/widgets/pay_icons.dart';
import 'package:faal/views/Payments/widgets/title_expand.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/order_controller.dart';
import '../../widgets/button_primary.dart';
import 'Cards/create_card_page.dart';
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
                  const SizedBox(height: 10),
                  ExpansionTile(
                    tilePadding: const EdgeInsets.all(0),
                    title: TitleExpand(
                      path: 'assets/cash.svg',
                      title: 'PAGO EN EFECTIVO EN EL LOCAL:',
                      subtitle: 'ACERCATE A NUESTRO LOCAL Y PAGÁ EN EFECTIVO',
                    ),
                  ),
                  ExpansionTile(
                    tilePadding: const EdgeInsets.all(0),
                    title: TitleExpand(
                      path: 'assets/library.svg',
                      title: 'PAGO CON TRANSFERENCIA:',
                      subtitle:
                          'COPIA NUESTRO CBU PARA EFECTUAR EL PAGO. DESPUES, AGREGA EL COMPROBANTE EN EL DETALLE DE TU PEDIDO EN LA SECCION DE “MIS PEDIDOS” EN TU PERFIL ',
                    ),
                  ),
                  ExpansionTile(
                    tilePadding: const EdgeInsets.all(0),
                    title: TitleExpand(
                      path: 'assets/credit.svg',
                      title: 'PAGO CON TARJETA:',
                      subtitle: 'ELIGE ALGUNA DE LAS TARJETAS DE TU BILLETERA.',
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
                    disabled: _.selectedCard == null,
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
