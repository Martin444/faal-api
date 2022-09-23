import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/text_styles.dart';
import '../../../utils/colors.dart';
import '../../categorie/categorie_page.dart';

class CategoryFlag extends StatefulWidget {
  const CategoryFlag({Key? key}) : super(key: key);

  @override
  State<CategoryFlag> createState() => _CategoryFlagState();
}

class _CategoryFlagState extends State<CategoryFlag> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => const CategoriePage(),
          transition: Transition.rightToLeftWithFade,
        );
      },
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        decoration: BoxDecoration(
          // color: kpurplecolor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: kredDesensa,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/tag.svg',
                    color: kBackground,
                    fit: BoxFit.contain,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    'VER CATEGORIAS',
                    style: titleButtonFlag,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kredDesensa,
                borderRadius: BorderRadius.circular(50),
              ),
              child: SvgPicture.asset(
                'assets/arrowrigth.svg',
                color: kBackground,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
