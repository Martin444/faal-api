import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

class TitleLine extends StatelessWidget {
  const TitleLine({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Divider(
            height: 20,
            color: Colors.black,
            thickness: 2,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            title,
            style: titleSecundary,
          ),
        ),
        const Expanded(
          flex: 1,
          child: Divider(
            height: 20,
            color: Colors.black,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
