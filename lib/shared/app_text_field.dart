import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:control_style/control_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    this.leadingIcon,
    this.textInputType,
    this.isPassword = false,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final Function validator;
  final String hintText;
  final Widget? leadingIcon;
  final TextInputType? textInputType;
  final bool isPassword;
  static bool obscureText = true;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isPassword == false && maxLines > 1
          ? TextInputType.multiline
          : textInputType,
      style: AppFonts.kFont16pt,
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      validator: (value) => validator(value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: isPassword == false && maxLines > 1 ? maxLines : 1,
      decoration: InputDecoration(
        prefixIcon: leadingIcon,
          fillColor: Colors.white.withOpacity(0.8),
          filled: true,
          hintText: hintText,
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: () {
                    obscureText = !obscureText;
                    (context as Element).markNeedsBuild();
                  },
                  child: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,

          contentPadding:
              const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
          hintStyle: AppFonts.kFont12pt,
          border: DecoratedInputBorder(
            child: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,

            ),
            shadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 1,
              )
            ],
          )),
    );
  }
}
