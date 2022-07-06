import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Models/category_model.dart';
import '../../../utils/text_styles.dart';
import '../result_page.dart';

// ignore: must_be_immutable
class CategoryTile extends StatelessWidget {
  CategoryModel model;
  CategoryTile({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ResultPage(result: model),
          transition: Transition.rightToLeft,
        );
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
