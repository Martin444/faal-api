import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/products/products_controller.dart';
import '../../../controllers/scroll_controllers.dart';
import '../../../widgets/anim/delayed_reveal.dart';
import '../../../widgets/anim/loader_widget.dart';
import '../../../widgets/product_tile.dart';

class RelationatedList extends StatefulWidget {
  const RelationatedList({
    Key? key,
  }) : super(key: key);

  @override
  State<RelationatedList> createState() => _RelationatedListState();
}

class _RelationatedListState extends State<RelationatedList> {
  var scrollService = Get.find<ScrollControllers>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (_) {
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            _.loadCategorisProduct!
                ? SizedBox(
                    height: 300,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisExtent: 165,
                        childAspectRatio: 0.2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return LoadAnimation(
                          child: Container(
                            color: Colors.grey[300],
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: 300,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _.productbyCategorie.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisExtent: 165,
                        childAspectRatio: 0.2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return DelayedReveal(
                          delay: const Duration(milliseconds: 200),
                          child: ProductTile(
                            product: _.productbyCategorie[index],
                          ),
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }
}
