import 'package:get/get.dart';

class NavigationsControllers extends GetxController {
  var indexPage = 0;

  void setIndexPage(int page) {
    indexPage = page;
    update();
  }
}
