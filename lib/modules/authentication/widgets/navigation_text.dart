import 'package:flutter/material.dart';

import '../../../core/constants/app_fonts.dart';

class NavigationText extends StatelessWidget {
  const NavigationText(
      {super.key,
      this.title = 'Already have an account?',
      this.boldedText = 'Login',
      required this.onPressed,});
  final String title;
  final String boldedText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextButton(
        onPressed: () => onPressed(),
        autofocus: true,
        child: RichText(
          text: TextSpan(
            text: title,

            style: AppFonts.kFont16pt,
            children: [
              TextSpan(
                  text: ' $boldedText', style: AppFonts.kFont16ptBoldPrimary),
            ],
          ),
        ),
      ),
    );
  }
}
