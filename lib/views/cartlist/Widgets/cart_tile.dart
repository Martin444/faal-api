import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Models/product_model.dart';
import '../../../controllers/cart_list_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';

class CartTile extends StatelessWidget {
  final ProductModel product;
  const CartTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartListController>(builder: (_) {
      return Container(
        margin: const EdgeInsets.only(
          bottom: 15,
        ),
        child: Container(
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 180,
                  width: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.images![0]),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name!,
                        style: titleProduct,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '\$ ${product.price!.replaceAll('.', ',')}',
                        style: priceCartItem,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 90,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _.removeItemQuantityProduct(product);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: kTextColor,
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${product.quantity}',
                                    style: priceCartItem,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _.addItemQuantityProduct(product);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: kTextColor,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GetBuilder<CartListController>(
                              builder: (_) {
                                return SizedBox(
                                  // height: 40,
                                  child: TextButton(
                                    onPressed: () {
                                      // _.clearList();
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
