import 'package:faal/controllers/products_controller.dart';
import 'package:faal/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../widgets/promotion_tile.dart';
import '../../../widgets/title_line.dart';

class PromotionList extends StatefulWidget {
  const PromotionList({
    Key? key,
  }) : super(key: key);

  @override
  State<PromotionList> createState() => _PromotionListState();
}

class _PromotionListState extends State<PromotionList> {
  PageController controller = PageController(
    initialPage: 0,
    // viewportFraction: 0.9,
  );
  var productsController = Get.find<ProductsController>();

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: productsController.promotionsList.length - 1,
      keepPage: true,
      // viewportFraction: 0.9,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (_) {
        return Column(
          children: [
            const TitleLine(title: 'PROMOCIONES'),
            SizedBox(
              height: Get.height * 0.22,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _.promotionsList.length,
                physics: const BouncingScrollPhysics(),
                controller: controller,
                itemBuilder: (context, index) {
                  return PromotionTile(
                    product: _.promotionsList[index],
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: _.promotionsList.length,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: kYellow,
                dotColor: const Color(0xFFC4C4C4),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              height: 30,
              color: Colors.black,
              thickness: 2,
            ),
          ],
        );
      },
    );
  }
}
