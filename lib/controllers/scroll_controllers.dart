import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ScrollControllers extends GetxController {
  ScrollController? scrollControllerHome;

  bool scrollUpHome = false;

  scrollListenHome(ScrollController scrollController) {
    if (scrollController.position.pixels > 10) {
      printInfo(info: scrollController.offset.toString());

      scrollUpHome = false;
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
      // if (!scrollUpHome) {
      //   scrollUpHome = true;
      //   update();
      // }
    }
  }
}
