import 'package:faal_new2/views/home/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Models/product_model.dart';
import '../controllers/cart_list_controller.dart';
import '../helps/rules.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

// ignore: must_be_immutable
class ProductTile extends StatefulWidget {
  ProductModel product;
  ProductTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
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
              if (Get.previousRoute == '/CategoriePage' ||
                  Get.previousRoute == '/ResultPage') {
                Get.to(
                  () => ProductDetail(model: widget.product),
                  transition: Transition.rightToLeft,
                );
              }
              Get.back();
              Get.to(
                () => ProductDetail(model: widget.product),
                transition: Transition.rightToLeft,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            widget.product.categories![0]['name'].length > 10
                                ? '${widget.product.categories![0]['name'].substring(0, 10)}...'
                                : widget.product.categories![0]['name'],
                            style: tagProduct,
                          ),
                        ),
                      ],
                    ),
                    Hero(
                      tag: 'productImage${widget.product.id}',
                      child: FadeInImage.assetNetwork(
                        height: 130,
                        width: 190,
                        placeholder: 'assets/placeholder.jpg',
                        image: widget.product.images![0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.product.name!.length > 25
                            ? widget.product.name!
                                .toUpperCase()
                                .substring(0, 25)
                            : widget.product.name!.toUpperCase(),
                        textAlign: TextAlign.start,
                        style: titleProduct,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    helpRules.isValidDescont(widget.product)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${widget.product.price!.replaceAll('.', ',')}',
                                style: priceDescontProduct,
                              ),
                              Text(
                                '\$${double.parse(widget.product.salePrice!).toStringAsFixed(2).replaceAll('.', ',')}',
                                style: priceProduct,
                              ),
                            ],
                          )
                        : Text(
                            widget.product.price!.length > 7
                                ? '\$ ${widget.product.price!.replaceAll('.', ',').replaceRange(7, null, '')}'
                                : '\$ ${widget.product.price!}',
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
                _.selectExistProductInList(widget.product);
              },
              child: _.validatinExistInList(widget.product)
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
