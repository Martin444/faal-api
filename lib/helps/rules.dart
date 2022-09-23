import 'package:flutter/material.dart';

import '../Models/product_model.dart';

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

  String validStatus(String status) {
    switch (status) {
      case 'pending':
        return 'Pendiente';
      case 'cancelled':
        return 'Cancelado';
      default:
        return 'En espera';
    }
  }

  Color validColorsStatus(String status) {
    switch (status) {
      case 'pending':
        return const Color(0xffFFBC3A);
      case 'cancelled':
        return const Color(0xffFF3A3A);
      default:
        return const Color(0xff79FF3A);
    }
  }
}
