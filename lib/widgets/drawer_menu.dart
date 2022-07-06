import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';

class DrawMenu extends StatelessWidget {
  const DrawMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: ListView(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SizedBox(
                    child: SvgPicture.asset(
                      'assets/back.svg',
                      color: kTextColor,
                      height: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  child: SvgPicture.asset(
                    'assets/faaltext.svg',
                    color: kTextColor,
                    height: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            MenuTile(
              title: 'HOME',
              onTaping: () {
                Get.back();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MenuTile(
              title: 'MIS PEDIDOS',
              onTaping: () {
                Get.back();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MenuTile(
              title: 'ATENCION AL CLIENTE',
              onTaping: () {
                Get.back();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MenuTile(
              title: 'QUIENES SOMOS',
              onTaping: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MenuTile extends StatelessWidget {
  String? title;
  VoidCallback? onTaping;

  MenuTile({
    Key? key,
    required this.title,
    required this.onTaping,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaping,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title!,
          style: titleSecundary,
        ),
      ),
    );
  }
}
