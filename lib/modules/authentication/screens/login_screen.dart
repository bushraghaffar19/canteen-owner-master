import 'package:canteen_owner_app/core/constants/app_colors.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/modules/authentication/screens/forget_password_screen.dart';
import 'package:canteen_owner_app/modules/authentication/widgets/navigation_text.dart';
import 'package:canteen_owner_app/modules/superadmin/phone.dart';
import 'package:canteen_owner_app/shared/app_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utilities/validators.dart';
import '../../../shared/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailTextController = TextEditingController();

  final TextEditingController passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  // ============================================================================
  @override
  Widget build(BuildContext context) {
    return Container(
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

       body: Center(


        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),

          children: [

            // =================================================================
            // Sign Up text
            // =================================================================
            const Text(
              'Login',
              //style: GoogleFonts.getFont('Lato'),
              style: AppFonts.khead,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            // =================================================================
            // Login Form
            // =================================================================
            Form(
              key: loginFormKey,
              child: Column(
                children: [
                  // ===========================================================
                  // Email Text Field
                  // ===========================================================
                  AppTextField(

                    controller: emailTextController,
                    validator: (email) => TextFieldValidations.emailValidation(email),
                    hintText: 'Enter your email',
                    leadingIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.black,
                    ),

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // ===========================================================
                  // Password Text Field
                  // ===========================================================
                  AppTextField(
                    controller: passwordTextController,
                    validator: (password) =>
                        TextFieldValidations.passwordValidation(password),
                    hintText: 'Enter your password',
                    isPassword: true,
                    leadingIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // =================================================================
            // Forget Password Button
            // =================================================================
            Align(
              alignment: Alignment.centerRight,
              child: NavigationText(
                title: '',
                boldedText: 'Forget Password?',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgetPasswordScreen(),
                    ),
                  );
                },
              ),
            ),
            // =================================================================
            // Login Button
            // =================================================================
            AppMainButton(
              title: 'Submit',
              onPressed: () {
                if(emailTextController.text == 'foodiedmn@gmail.com' && passwordTextController.text == 'Admin@123') {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) =>MyPhone() ,
                    ),);
                }
                else if(loginFormKey.currentState!.validate()) {
                  authController.logIn(emailTextController.text, passwordTextController.text, context);
                }
                },
            ),
            // =================================================================
            // Don't have an account
            // =================================================================
            NavigationText(
              title: 'Do not have an account?',
              boldedText: 'Sign up',
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),),
    );
  }
}
