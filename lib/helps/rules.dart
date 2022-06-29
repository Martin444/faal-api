import 'package:faal/Models/product_model.dart';

class RulesFunctions {
  bool isValidDescont(ProductModel prod) {
    if (prod.salePrice!.isEmpty) {
      return false;
    }
    if (double.parse(prod.salePrice!) < double.parse(prod.regularPrice!)) {
      return true;
    }
    return false;
  }
}
