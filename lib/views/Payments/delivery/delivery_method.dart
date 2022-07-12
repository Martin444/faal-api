import 'package:faal/utils/colors.dart';
import 'package:faal/utils/styles_context.dart';
import 'package:faal/utils/text_styles.dart';
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
                  '¿Como quieres recibir el producto?',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                DeliveryTile(
                  selected: _.deliverySelected == 'Entrega en persona',
                  brand: Text(
                    'Retiro en persona',
                    style: titleAppBar,
                  ),
                  onTaper: () {
                    _.selectDelivery('Retiro en persona');
                  },
                ),
                const SizedBox(height: 20),
                _.deliverySelected != null
                    ? Column(
                        children: [
                          const Text(
                            '¿Dónde quieres recibir el producto?',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 20),
                          DeliveryTile(
                            selected: _.myAddress == 'Dirección 1',
                            brand: Text(
                              'Dirección 1',
                              style: titleAppBar,
                            ),
                            onTaper: () {
                              _.selectMyAddress('Dirección 1');
                            },
                          ),
                          DeliveryTile(
                            selected: _.myAddress == 'Dirección 2',
                            brand: Text(
                              'Dirección 2',
                              style: titleAppBar,
                            ),
                            onTaper: () {
                              _.selectMyAddress('Dirección 2');
                            },
                          ),
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
          color: selected ? kredDesensa : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: brand!,
      ),
    );
  }
}
