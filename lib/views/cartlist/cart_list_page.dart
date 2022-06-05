import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/cart_list_controller.dart';
import '../../widgets/button_primary.dart';
import 'Widgets/cart_list.dart';

class CartListPage extends StatefulWidget {
  const CartListPage({Key? key}) : super(key: key);

  @override
  _CartListPageState createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Lista de compra',
                        // style: ,
                      ),
                      GetBuilder<CartListController>(builder: (_) {
                        return SizedBox(
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              _.clearList();
                            },
                            child: SvgPicture.asset(
                              'assets/trashicon.svg',
                              width: 40,
                              height: 40,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  const ListCarts(),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            GetBuilder<CartListController>(builder: (_) {
              return Container(
                height: 170,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Añade un producto',
                      // style: primaryText1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   children: [
                    //     Flexible(
                    //       child: ButtonWithLineBlack(
                    //         title: 'Con codigo',
                    //         onPressed: () {
                    //           _.addProductWithBarcode();
                    //         },
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       width: 5,
                    //     ),
                    //     Flexible(
                    //       child: ButtonWithLineBlack(
                    //         title: 'Sin codigo',
                    //         onPressed: () {
                    //           // Get.back();
                    //           Get.to(
                    //             () => const ListProductsWithOutCode(),
                    //             transition: Transition.rightToLeft,
                    //           );
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: ButtonPrimary(
                            title: 'Vender',
                            onPressed: () {
                              // _.listCart!.isEmpty
                              //     ? Get.snackbar(
                              //         '¡Pará emoción!',
                              //         'Carga un producto antes',
                              //         backgroundColor: Colors.red,
                              //         colorText: Colors.white,
                              //         snackPosition: SnackPosition.TOP,
                              //       )
                              //     : Get.to(() => const PaymentDetailsPage());
                            },
                            load: false,
                          ),
                        ),
                        Flexible(
                          child: Hero(
                            tag: 'price',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // const Text(r'$', style: primaryText),
                                // Text('${_.totalPrice}', style: priceText),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
