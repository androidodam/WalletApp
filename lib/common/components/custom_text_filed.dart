import 'package:flutter/material.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/export.dart';

class CustomTextFiled extends StatelessWidget {
  final label;
  final TextEditingController controller;
  final Widget? suffix;
  final Widget? preffix;
  final Color borderColor;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String keyboardType;
  CustomTextFiled(
      {super.key,
      required this.label,
      required this.controller,
      this.suffix,
      this.preffix,
      required this.borderColor,
      this.validator,
      this.onChanged,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    ThemeData tema = Theme.of(context);
    return TextFormField(
      keyboardType:
          keyboardType == "number" ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.o),
          borderSide: BorderSide(
            color: borderColor,
            width: 1.o,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.o),
          borderSide: BorderSide(
            color: borderColor,
            width: 1.o,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.o),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.o,
          ),
        ),
        hintText: label,
        hintStyle: theme.testStyle.copyWith(
          fontSize: 14,
          fontFamily: theme.fontAbys,
          color: tema.primaryColorDark,
        ),
      ),
    );
  }
}
