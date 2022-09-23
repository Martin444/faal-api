import 'package:get/get.dart';

import '../Models/product_model.dart';
import '../views/home/widgets/detail_modal.dart';

class ModalsHelpers {
  void showDetailProduct(ProductModel product) {
    Get.dialog(
      DetailModal(
        product: product,
      ),
    );
  }
}
