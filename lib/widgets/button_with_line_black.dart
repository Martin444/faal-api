import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

// ignore: must_be_immutable
class ButtonWithLine extends StatelessWidget {
  String title;
  VoidCallback onPressed;

  ButtonWithLine({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.all(
          Colors.blueGrey.withOpacity(0.2),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10),
        ),
        side: MaterialStateProperty.all(
          const BorderSide(
            width: 2,
            color: Colors.black,
          ),
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
          Text(
            title,
            textAlign: TextAlign.center,
            style: buttonStylePrimaryBlack,
          ),
        ],
      ),
    );
  }
}
