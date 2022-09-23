import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/products/products_controller.dart';
import '../../../controllers/scroll_controllers.dart';
import '../../../widgets/anim/delayed_reveal.dart';
import '../../../widgets/product_tile.dart';
import '../../../widgets/title_line.dart';
import 'category_flag.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  ScrollController? _scrollController = ScrollController();

  var scrollService = Get.find<ScrollControllers>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (_) {
        return Column(
          children: [
            const TitleLine(title: 'DESTACADOS'),
            CategoryFlag(),

            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 300,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: _.productsList.sublist(0, 9).length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 165,
                  childAspectRatio: 0.2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return DelayedReveal(
                    delay: const Duration(milliseconds: 100),
                    child: ProductTile(
                      product: _.productsList[index],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 300,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: _.productsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 165,
                  childAspectRatio: 0.2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return DelayedReveal(
                    delay: const Duration(milliseconds: 100),
                    child: ProductTile(
                      product: _.productsList[index >= 10 ? index : index + 10],
                    ),
                  );
                },
              ),
            ),

            // const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
