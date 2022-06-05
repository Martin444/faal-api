import 'package:faal/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/product_model.dart';
import '../helps/modals.dart';
import '../utils/text_styles.dart';

// ignore: must_be_immutable
class PromotionTile extends StatelessWidget {
  ProductModel product;

  PromotionTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ModalsHelpers().showDetailProduct(product);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 40, right: 15),
        child: Container(
          // padding: const EdgeInsets.symmetric(
          //   vertical: 20,
          // ),
          width: Get.width,
          decoration: BoxDecoration(
            color: kModalcolor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: const Alignment(0.9, 1.3),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(product.images![0]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        product.name!,
                        style: titlePromotionProduct,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: kYellow,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 12),
                        spreadRadius: 0,
                      ),
                    ]),
                child: Text(
                  '\$ ${product.price!.replaceAll('.', ',')}',
                  style: pricePromotionProduct,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
