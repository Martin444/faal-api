import 'package:faal/Models/product_model.dart';
import 'package:faal/controllers/cart_list_controller.dart';
import 'package:faal/helps/capitalize.dart';
import 'package:faal/helps/modals.dart';
import 'package:faal/helps/rules.dart';
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
    var helpCap = Capitalization();
    var helpRules = RulesFunctions();

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
                            product.categories!.join(', ').length > 10
                                ? '${product.categories!.join(', ').substring(0, 12)}...'
                                : product.categories!.join(', '),
                            style: tagProduct,
                          ),
                        ),
                      ],
                    ),
                    FadeInImage.assetNetwork(
                      height: 130,
                      width: 190,
                      placeholder: 'assets/placeholder.jpg',
                      image: product.images![0],
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        product.name!.length > 16
                            ? '${helpCap.capitalizarPrimeraLetra(product.name)!.substring(0, 16)}...'
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
                    helpRules.isValidDescont(product)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${product.price!.replaceAll('.', ',')}',
                                style: priceDescontProduct,
                              ),
                              Text(
                                '\$${double.parse(product.salePrice!).toStringAsFixed(2).replaceAll('.', ',')}',
                                style: priceProduct,
                              ),
                            ],
                          )
                        : Text(
                            product.price!.length > 7
                                ? '\$ ${product.price!.replaceAll('.', ',').replaceRange(7, null, '')}'
                                : '\$ ${product.price!}',
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
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: kredDesensa,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/plus.svg',
                        color: Colors.white,
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: kgreenSucces,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                        ),
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
