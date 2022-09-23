import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/order_controller.dart';
import '../../../../utils/text_styles.dart';
import 'pr_tile.dart';

class ListProdetails extends StatefulWidget {
  const ListProdetails({
    Key? key,
  }) : super(key: key);

  @override
  State<ListProdetails> createState() => _ListProdetailsState();
}

class _ListProdetailsState extends State<ListProdetails> {
  var text = 'Mostrar productos';
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (_) {
        var prodAr = <ProductAr>[];
        for (var e in _.productBuy) {
          prodAr.add(ProductAr(
            detail: e,
            isMyorer: true,
          ));
        }
        return ExpansionTile(
          tilePadding: const EdgeInsets.all(0),
          onExpansionChanged: (va) {
            printInfo(info: '$va');
            if (va) {
              setState(() {
                text = 'Ocultar productos';
              });
            } else {
              setState(() {
                text = 'Mostrar productos';
              });
            }
          },
          title: Text(
            '$text (${_.productBuy.length})',
            style: titlePromotionProduct,
          ),
          children: prodAr,
        );
      },
    );
  }
}
