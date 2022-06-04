import 'package:faal/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/text_styles.dart';

// ignore: must_be_immutable
class TextInputSearch extends StatelessWidget {
  String labelText;
  TextEditingController controller;
  TextInputType inputType;
  TextInputAction? textInputAction;
  bool visibleText;
  bool isPass;
  String? errorText;
  Function? function;
  Function(String)? functionSubmited;

  TextInputSearch({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.inputType,
    required this.visibleText,
    required this.isPass,
    this.errorText,
    this.function,
    this.functionSubmited,
    this.textInputAction,
  }) : super(key: key);

  Widget getIcon() {
    return SizedBox(
      child: SvgPicture.asset(
        height: 20,
        'assets/searchicon.svg',
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: kModalcolor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(26, 0, 0, 0),
            blurRadius: 22,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        cursorColor: kYellow,
        keyboardType: inputType,
        obscureText: visibleText,
        textInputAction: textInputAction,
        textCapitalization: TextCapitalization.sentences,
        onChanged: functionSubmited,
        style: inputSearchStyle,
        decoration: InputDecoration(
          fillColor: Colors.amber,
          suffix: getIcon(),
          errorText: errorText,
          border: InputBorder.none,
          hintStyle: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            fontFamily: 'Barlow',
            fontSize: 15,
          ),
          hoverColor: kYellow,
          hintText: labelText,
        ),
      ),
    );
  }
}
