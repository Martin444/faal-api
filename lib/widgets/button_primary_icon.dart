import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';

// ignore: must_be_immutable
class ButtonPrimaryIcon extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  String path;
  bool load;

  ButtonPrimaryIcon({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.path,
    required this.load,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kYellow),
          overlayColor: MaterialStateProperty.all(
            Colors.white.withOpacity(0.2),
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
          children: [
            // Text(''),

            !load
                ? Row(
                    children: [
                      SvgPicture.asset(
                        path,
                        height: 25,
                        color: kTextColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: buttonStylePrimary,
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
