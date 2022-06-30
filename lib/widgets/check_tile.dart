import 'package:faal/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckTile extends StatelessWidget {
  Widget rich;
  bool? isChecked;
  Function(bool?)? onChecked;

  CheckTile({
    Key? key,
    required this.rich,
    required this.isChecked,
    required this.onChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChecked,
          activeColor: kredDesensa,
        ),
        Expanded(child: rich),
      ],
    );
  }
}
