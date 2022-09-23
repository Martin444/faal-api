import 'package:faal_new2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/text_styles.dart';

// ignore: must_be_immutable
class ButtonSecondaryIcon extends StatelessWidget {
  String title;
  String path;
  VoidCallback onPressed;
  bool? isPro = false;

  ButtonSecondaryIcon({
    Key? key,
    required this.title,
    required this.path,
    required this.onPressed,
    required this.isPro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          overlayColor: MaterialStateProperty.all(
            Colors.black.withOpacity(0.1),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              path,
              height: 25,
              color: isPro! ? kgreenSucces : Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: isPro! ? buttonStylePrimarygreen : buttonStylePrimaryBlack,
            ),
          ],
        ),
      ),
    );
  }
}
