import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'products/products_controller.dart';

class ScrollControllers extends GetxController {
  ScrollController? scrollControllerHome;

  bool scrollUpHome = false;

  var prodService = Get.find<ProductsController>();

  int page = 2;

  scrollListenHome(ScrollController scrollController) async {
    if (scrollController.position.pixels > 10) {
      scrollControllerHome!.animateTo(
        300,
        duration: const Duration(milliseconds: 100),
        curve: Curves.bounceOut,
      );
      update();
    } else {
      scrollControllerHome!.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      if (!prodService.isLoadingInit) {
        prodService.setIsLoading(true);
        await prodService.getProductsPage(page);
        page++;
        prodService.setIsLoading(false);
        update();
      }
    }
  }
}
