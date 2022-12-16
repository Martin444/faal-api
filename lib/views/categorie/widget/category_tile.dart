import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Models/category_model.dart';
import '../../../utils/text_styles.dart';
import '../result_page.dart';

// ignore: must_be_immutable
class CategoryTile extends StatelessWidget {
  CategoryModel model;
  bool? isSubCat;
  CategoryTile({
    Key? key,
    required this.model,
    required this.isSubCat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        try {
          if (isSubCat!) {
            Get.back();
            Get.to(
              () => ResultPage(result: model),
              transition: Transition.fade,
            );
          } else {
            Get.to(
              () => ResultPage(result: model),
              transition: Transition.rightToLeft,
            );
          }
        } catch (e) {
          rethrow;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              model.name!,
              style: titlePromotionProduct,
            ),
            SvgPicture.asset('assets/arrowrigth.svg'),
          ],
        ),
      ),
    );
  }
}
