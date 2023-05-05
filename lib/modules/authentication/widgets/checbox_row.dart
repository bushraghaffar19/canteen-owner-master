import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class CheckboxRow extends StatelessWidget {
  const CheckboxRow({
    super.key,
    required this.value,
    required this.onChanged,
    this.title = 'I accept the',
    this.boldedText = 'Terms and Conditions',
    this.textOnPressed,
  });
  final bool value;
  final Function onChanged;
  final String title;
  final String boldedText;
  final Function? textOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (newVal) => onChanged(newVal),
        ),
        RichText(
          text: TextSpan(
            text: title,
            style: AppFonts.kFont16pt,
            children: [
              TextSpan(
                  text: ' $boldedText', style: AppFonts.kFont16ptUnderlineBold),
            ],
          ),
        ),
      ],
    );
  }
}
