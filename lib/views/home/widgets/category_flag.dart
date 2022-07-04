import 'package:faal/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/text_styles.dart';

class CategoryFlag extends StatefulWidget {
  const CategoryFlag({Key? key}) : super(key: key);

  @override
  State<CategoryFlag> createState() => _CategoryFlagState();
}

class _CategoryFlagState extends State<CategoryFlag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/tag.svg',
                color: kTextColor,
                height: 20,
              ),
              const SizedBox(width: 3),
              Text(
                'Ver todas las categorias',
                style: titleAppBar,
              ),
            ],
          ),
          SvgPicture.asset(
            'assets/arrowrigth.svg',
            color: kTextColor,
            height: 25,
          ),
        ],
      ),
    );
  }
}
