import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

// ignore: must_be_immutable
class ButtonSecondary extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  bool? isPro = false;

  ButtonSecondary({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.isPro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor:
              MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
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
          children: [
            const Text(''),
            Text(
              title,
              textAlign: TextAlign.center,
              style: isPro! ? buttonStylePrimaryBlue : buttonStylePrimaryBlack,
            ),
          ],
        ),
      ),
    );
  }
}
