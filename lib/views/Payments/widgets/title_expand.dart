import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/text_styles.dart';

// ignore: must_be_immutable
class TitleExpand extends StatelessWidget {
  String? path;
  String? title;
  String? subtitle;
  TitleExpand({
    Key? key,
    required this.path,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(path!),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: Text(
                title!,
                style: titleAppBar,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          subtitle!,
          style: inputSearchStyle,
        ),
      ],
    );
  }
}
