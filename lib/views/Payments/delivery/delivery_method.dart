import 'package:faal/controllers/address_controller.dart';
import 'package:faal/utils/colors.dart';
import 'package:faal/utils/styles_context.dart';
import 'package:faal/utils/text_styles.dart';
import 'package:faal/views/Login/login_page.dart';
import 'package:faal/views/Payments/delivery/create_address_page.dart';
import 'package:faal/views/Payments/delivery/list_addres.dart';
import 'package:faal/widgets/button_primary_icon.dart';
import 'package:faal/widgets/button_secundary.dart';
import 'package:faal/widgets/button_with_line_black.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/order_controller.dart';
import '../../../widgets/button_primary.dart';
import '../Order/order_page.dart';

class DeliveryMethodPage extends StatefulWidget {
  const DeliveryMethodPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DeliveryMethodPageState createState() => _DeliveryMethodPageState();
}

class _DeliveryMethodPageState extends State<DeliveryMethodPage> {
  var address = Get.find<AddressController>();

  @override
  void initState() {
    address.findMyAddress();
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
            title: Text(
              'Método de envío',
              style: titleAppBar,
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Text(
                  '¿Como querés recibir el pedido?',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                DeliveryTile(
                  selected: _.deliverySelected == 'Entrega a domicilio',
                  brand: Text(
                    'Entrega a domicilio',
                    style: _.deliverySelected != 'Entrega a domicilio'
                        ? titleAppBar
                        : titleAppBarWithe,
                  ),
                  onTaper: () {
                    _.selectDelivery('Entrega a domicilio');
                  },
                ),
                DeliveryTile(
                  selected: _.deliverySelected == 'Retiro en persona',
                  brand: Text(
                    'Retiro en persona',
                    style: _.deliverySelected != 'Retiro en persona'
                        ? titleAppBar
                        : titleAppBarWithe,
                  ),
                  onTaper: () {
                    _.selectDelivery('Retiro en persona');
                  },
                ),
                const SizedBox(height: 20),
                _.deliverySelected != null &&
                        _.deliverySelected == 'Entrega a domicilio'
                    ? Column(
                        children: [
                          const Text(
                            '¿Dónde querés recibir el pedido?',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const ListAddres(),
                          const SizedBox(height: 20),
                          ButtonPrimaryIcon(
                            path: 'assets/plus.svg',
                            title: 'Agregar direccion',
                            onPressed: () {
                              _.user.accessTokenID != null
                                  ? Get.to(() => const CreateAddressPage())
                                  : Get.bottomSheet(
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 30,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Para agregar una dirección tenes que iniciar sesión',
                                              textAlign: TextAlign.center,
                                              style: titleDetail,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ButtonPrimary(
                                              title: 'Iniciar sesión',
                                              onPressed: () {
                                                Get.back();
                                                Get.to(
                                                  () => const LoginPage(),
                                                );
                                              },
                                              load: false,
                                            ),
                                            ButtonWithLine(
                                              title: 'Continuar luego',
                                              onPressed: () {},
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                            },
                            load: false,
                          )
                        ],
                      )
                    : const SizedBox(),
                const Spacer(),
                ButtonPrimary(
                  title: 'Siguiente',
                  onPressed: () {
                    Get.off(
                      () => const OrderPage(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  load: false,
                  disabled: _.myAddress == null,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class DeliveryTile extends StatelessWidget {
  bool selected;
  Widget? brand;
  VoidCallback onTaper;
  DeliveryTile({
    required this.selected,
    required this.brand,
    required this.onTaper,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTaper();
      },
      child: Container(
        width: Get.width,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: selected ? kpurplecolor : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: brand!,
      ),
    );
  }
}
