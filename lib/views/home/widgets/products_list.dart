import 'package:faal/controllers/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/product_tile.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (_) {
        return SizedBox(
          height: Get.height * 0.5,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _.productsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 320,
              mainAxisSpacing: 24,
              childAspectRatio: 0.8,
              crossAxisSpacing: 24,
            ),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ProductTile(
                product: _.productsList[index],
              );
            },
          ),
        );
      },
    );
  }
}
