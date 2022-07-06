import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_list_controller.dart';

class DataPersonal extends StatefulWidget {
  const DataPersonal({
    Key? key,
  }) : super(key: key);

  @override
  State<DataPersonal> createState() => _DataPersonalState();
}

class _DataPersonalState extends State<DataPersonal> {
  var cart = Get.find<CartListController>();

  final TextEditingController _nameSellerController = TextEditingController();
  final TextEditingController _nameBuyerController = TextEditingController();

  @override
  initState() {
    super.initState();
    _nameBuyerController.text = cart.nameBuyer!;
    _nameSellerController.text = cart.nameSeller!;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartListController>(builder: (_) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  children: [
                    // TextInputField(
                    //   labelText: 'Nombre del vendedor',
                    //   controller: _nameSellerController,
                    //   inputType: TextInputType.name,
                    //   errorText: _.errorNameSeller,
                    //   visibleText: false,
                    //   isPass: false,
                    //   functionSubmited: (v) {
                    //     cart.setNameSeller(v);
                    //   },
                    // ),
                    Row(
                      children: [
                        const Text('o'),
                        SizedBox(
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                Colors.white.withOpacity(0.3),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                Colors.transparent,
                              ),
                            ),
                            child: Row(
                              children: const [
                                Text('Inicia sesión'),
                              ],
                            ),
                            // tooltip: 'Añadir producto',
                            onPressed: () {
                              // Get.to(() => const LoginPage());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/profilew.jpg'),
              ),
              SizedBox(
                width: 10,
              ),
              // Flexible(
              //   child: TextInputField(
              //     labelText: 'Nombre del comprador',
              //     controller: _nameBuyerController,
              //     errorText: _.errorNameBuyer,
              //     inputType: TextInputType.name,
              //     visibleText: false,
              //     isPass: false,
              //     functionSubmited: (c) {
              //       cart.setNameBuyer(c);
              //     },
              //   ),
              // )
            ],
          ),
        ],
      );
    });
  }
}
