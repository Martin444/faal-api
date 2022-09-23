import 'package:faal_new2/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Models/product_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/text_styles.dart';

// ignore: must_be_immutable
class ProductAr extends StatefulWidget {
  ProductModel detail;
  bool? isMyorer = true;
  ProductAr({
    Key? key,
    required this.detail,
    required this.isMyorer,
  }) : super(key: key);

  @override
  State<ProductAr> createState() => _ProductArState();
}

class _ProductArState extends State<ProductAr> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (_) {
        return Container(
          // height: 130,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(10)),
                child: Image.network(
                  widget.detail.images![0],
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.detail.name!,
                            style: titleProduct,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '\$${(double.parse(widget.detail.price!) * widget.detail.quantity!).toStringAsFixed(2)}',
                          style: titlePromotionProduct,
                        ),
                      ],
                    ),
                    widget.isMyorer!
                        ? SizedBox(
                            width: 90,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                widget.detail.quantity! > 1
                                    ? GestureDetector(
                                        onTap: () {
                                          _.removeItemQuantityProduct(
                                              widget.detail);
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
                                      )
                                    : const SizedBox(
                                        width: 25,
                                      ),
                                Text(
                                  '${widget.detail.quantity}',
                                  style: priceCartItem,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _.addItemQuantityProduct(widget.detail);
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
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
