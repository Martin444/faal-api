import 'package:flutter/material.dart';

import '../../../../Models/product_model.dart';
import '../../../../utils/text_styles.dart';

// ignore: must_be_immutable
class ProductAr extends StatelessWidget {
  ProductModel detail;
  ProductAr({
    Key? key,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10)),
            child: Image.network(
              detail.images![0],
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    '${detail.name!} x${detail.quantity}',
                    style: titleProduct,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '\$${(double.parse(detail.price!) * detail.quantity!).toStringAsFixed(2)}',
                  style: titlePromotionProduct,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
