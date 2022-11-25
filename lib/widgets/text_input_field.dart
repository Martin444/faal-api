import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';

// ignore: must_be_immutable
class TextInputField extends StatelessWidget {
  String labelText;
  TextEditingController controller;
  TextInputType inputType;
  TextInputAction? textInputAction;
  bool visibleText;
  bool isPass;
  String? errorText;
  Function? function;
  Function(String)? functionSubmited;
  Function(String)? onFunctionSubmited;

  TextInputField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.inputType,
    required this.visibleText,
    required this.isPass,
    this.errorText,
    this.function,
    this.functionSubmited,
    this.onFunctionSubmited,
    this.textInputAction,
  }) : super(key: key);

  Widget getIcon() {
    if (isPass) {
      return visibleText
          ? Container(
              margin: const EdgeInsets.only(right: 10, top: 25),
              child: GestureDetector(
                child: SvgPicture.asset(
                  'assets/eye-close.svg',
                  height: 20,
                ),
                onTap: () {
                  function!();
                },
              ),
            )
          : Container(
              margin: const EdgeInsets.only(right: 10, top: 25),
              child: GestureDetector(
                child: SvgPicture.asset(
                  'assets/eye-open.svg',
                  height: 22,
                  fit: BoxFit.fitHeight,
                ),
                onTap: () {
                  function!();
                },
              ),
            );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          controller: controller,
          cursorColor: kredDesensa,
          keyboardType: inputType,
          obscureText: visibleText,
          textInputAction: textInputAction,
          inputFormatters: inputType == TextInputType.number
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ]
              : [],
          textCapitalization: TextCapitalization.sentences,
          onChanged: functionSubmited,
          onSubmitted: onFunctionSubmited,
          style: inputSearchStyle,
          decoration: InputDecoration(
            errorText: errorText,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black87,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: kredDesensa,
              ),
            ),
            focusColor: kredDesensa,
            labelStyle: inputSearchStyle,
            alignLabelWithHint: true,
            hoverColor: kredDesensa,
            labelText: labelText,
          ),
        ),
        getIcon()
      ],
    );
  }
}
