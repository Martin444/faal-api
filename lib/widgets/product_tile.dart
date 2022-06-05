import 'package:faal/Models/product_model.dart';
import 'package:faal/controllers/cart_list_controller.dart';
import 'package:faal/helps/modals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';

// ignore: must_be_immutable
class ProductTile extends StatelessWidget {
  ProductModel product;
  ProductTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: kModalcolor,
            borderRadius: BorderRadius.circular(0),
          ),
          child: GestureDetector(
            onTap: () {
              ModalsHelpers().showDetailProduct(product);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/tag.svg'),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '${product.categories!.join(', ').substring(0, 15)}...',
                            style: tagProduct,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(product.images![0]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        product.name!.length > 20
                            ? '${product.name!.substring(0, 20)}...'
                            : product.name!,
                        style: titleProduct,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.price!.length > 7
                          ? '\$ ${product.price!.replaceAll('.', ',').replaceRange(7, null, '')}'
                          : product.price!,
                      style: priceProduct,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        GetBuilder<CartListController>(
          builder: (_) {
            return GestureDetector(
              onTap: () {
                _.selectExistProductInList(product);
              },
              child: _.validatinExistInList(product)
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: kYellow,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12)),
                      ),
                      child: SvgPicture.asset('assets/plus.svg'),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: kgreenSucces,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12)),
                      ),
                      child: SvgPicture.asset('assets/check.svg'),
                    ),
            );
          },
        ),
      ],
    );
  }
}
