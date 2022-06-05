import 'package:faal/controllers/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/scroll_controllers.dart';
import '../../../widgets/product_tile.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  ScrollController? _scrollController;

  var scrollService = Get.find<ScrollControllers>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      scrollService.scrollListenHome(_scrollController!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (_) {
        return SizedBox(
          height: Get.height * 0.85,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            itemCount: _.productsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 320,
              mainAxisSpacing: 24,
              childAspectRatio: 0.8,
              crossAxisSpacing: 24,
            ),
            // physics: const BouncingScrollPhysics(),
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
