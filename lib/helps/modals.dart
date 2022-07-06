import 'package:faal/Models/product_model.dart';
import 'package:faal/views/home/widgets/detail_modal.dart';
import 'package:get/get.dart';

class ModalsHelpers {
  void showDetailProduct(ProductModel product) {
    Get.dialog(
      DetailModal(
        product: product,
      ),
    );
  }
}
