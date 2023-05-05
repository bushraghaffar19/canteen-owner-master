import 'package:canteen_owner_app/core/constants/app_colors.dart';
import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class AppMainButton extends StatelessWidget {
  const AppMainButton({
    this.buttonColor = AppColors.kButtonColor,
    this.textStyle = AppFonts.kFont16ptWhite,
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  final Color buttonColor;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          height: screenSize.height * .06,
          width: screenSize.width * 0.7,
          decoration: BoxDecoration(
            color: buttonColor,

           borderRadius: BorderRadius.circular(26),

          ),
          child: Center(
            child: Text(
              title,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
