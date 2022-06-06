import 'package:faal/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/cart_list_controller.dart';
import '../../utils/text_styles.dart';
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
      backgroundColor: kBackground,
      appBar: AppBar(
        leading: GetBuilder<CartListController>(
          builder: (_) {
            return SizedBox(
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
            );
          },
        ),
        title: Text(
          'Mi carrito',
          style: titleAppBar,
        ),
        backgroundColor: kBackground,
        elevation: 0,
        centerTitle: true,
        actions: [
          GetBuilder<CartListController>(
            builder: (_) {
              return SizedBox(
                height: 40,
                child: TextButton(
                  onPressed: () {
                    _.clearList();
                  },
                  child: SvgPicture.asset(
                    'assets/trash.svg',
                    width: 30,
                    height: 30,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: GetBuilder<CartListController>(builder: (_) {
        return SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _.listCart!.length > 1
                          ? '${_.listCart!.length} ARTICULOS AGREGADOS'
                          : '${_.listCart!.length} ARTICULO AGREGADO',
                      style: subtitleCart,
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 20),
                    const ListCarts(),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              GetBuilder<CartListController>(
                builder: (_) {
                  return Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
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
                              child: Hero(
                                tag: 'price',
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // const Text(r'$', style: primaryText),
                                    const Text(
                                      'Total a pagar',
                                      // style: primaryText1,
                                    ),
                                    Text(
                                      _.totalPrice.toString().length > 4
                                          ? '\$ ${_.totalPrice.toString().replaceAll('.', ',').replaceRange(7, null, '')}'
                                          : '\$ ${_.totalPrice.toString().replaceAll('.', ',')}',
                                      style: priceTotalItems,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: ButtonPrimary(
                                title: 'SIGUIENTE',
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
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
