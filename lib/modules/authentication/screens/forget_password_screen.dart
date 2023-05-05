import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/core/constants/app_colors.dart';
import 'package:canteen_owner_app/modules/authentication/widgets/forget_password_form.dart';
import 'package:canteen_owner_app/shared/app_button.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // ===========================================================================
  // Build
  // ===========================================================================
  @override
  Widget build(BuildContext context) { return Container(
      // decoration: BoxDecoration(image: DecorationImage(image: AssetImage('bg2.jpg'),fit: BoxFit.cover)),
      decoration: BoxDecoration(gradient:LinearGradient(
      colors: [
      AppColors.kLightButtonColor,
      AppColors.kLightTextColor,
      AppColors.kButtonTextColor
      ],
      begin:Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [
      0.1,
      0.4,
      0.6
      ]
  ) ),
  child: Scaffold(
  backgroundColor: Colors.transparent,

  // =======================================================================
      // Appbar
      // =======================================================================
      appBar: AppBar(),
      // =======================================================================
      // Body (ListView)
      // =======================================================================
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          children: [
            // ===================================================================
            // Heading
            // ===================================================================
            const Text(
              'Reset Password',
              style: AppFonts.khead,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Please enter email for reset your password.",
              style: AppFonts.kFont16pt,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            // ===================================================================
            // Forget Password Form
            // ===================================================================
            ForgetPasswordForm(
              forgetPasswordFormKey: forgetPasswordFormKey,
            ),
            const SizedBox(
              height: 40,
            ),
            // ===================================================================
            // Submit Button
            // ===================================================================
            AppMainButton(
                title: 'Submit',
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    ),);
  }
}
