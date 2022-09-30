import 'package:faal_new2/utils/colors.dart';
import 'package:faal_new2/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void modalConfirm() {
    Get.dialog(
      Dialog(
        // color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                '¿Querés salir de F.A.A.L?',
                style: titleSecundary,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'No',
                      style: titleProduct,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black.withOpacity(0.1),
                      ),
                    ),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text(
                      'Si',
                      style: titleProduct,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
