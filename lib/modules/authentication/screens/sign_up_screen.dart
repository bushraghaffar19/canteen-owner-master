import 'dart:io';
import 'package:canteen_owner_app/core/constants/app_colors.dart';
import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/modules/authentication/widgets/navigation_text.dart';
import 'package:canteen_owner_app/shared/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/image_controller.dart';
import '../../../core/utilities/validators.dart';
import '../../../model/auth_model.dart';
import '../../../shared/app_text_field.dart';
import '../../products/widgets/add_image_container.dart';
import '../widgets/checbox_row.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  final TextEditingController nameTextController = TextEditingController();

  final TextEditingController emailTextController = TextEditingController();

  final TextEditingController passwordTextController = TextEditingController();

  final TextEditingController confirmPasswordTextController =
  TextEditingController();

  final TextEditingController phoneNoTextController = TextEditingController();

  bool isTermsAccepted = false;
  File? image;
  Future pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file == null) return null;
    setImage(File(file.path));
  }
  void setImage(File? newImage) {
    image = newImage;
   setState(() {
   });
  }
// ===========================================================================
  @override
  void dispose() {
    nameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    phoneNoTextController.dispose();
    super.dispose();
  }

// =============================================================================
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

  body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 50,
          ),
          children: [
            // =================================================================
            // Sign Up text
            // =================================================================
            const Text(
              'Sign Up',
              style: AppFonts.khead,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            // ===================================================================
            // Add Image
            // ===================================================================
        GestureDetector(
            onTap: (){
              pickImage();
            },
            child: AddImageContainer(
              image: image,
              title: 'Add an canteen image',
            )
        ),
            const SizedBox(
              height: 15,
            ),
            // =================================================================
            // Sign Up Form
            // =================================================================
          Form(
          key: signUpFormKey,
          child: Column(
            children: [
              // ===========================================================
              // Name Text Field
              // ===========================================================
              AppTextField(
                controller: nameTextController,
                validator: (name) => TextFieldValidations.nameValidation(name),
                hintText: 'Enter canteen name',
                leadingIcon: Icon(
                  Icons.restaurant,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // ===========================================================
              // Email Text Field
              // ===========================================================
              AppTextField(
                controller: emailTextController,
                validator: (email) => TextFieldValidations.emailValidation(email),
                hintText: 'Enter your email',
                leadingIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // ===========================================================
              // Phone number Text Field
              // ===========================================================
              AppTextField(
                controller: phoneNoTextController,
                validator: (phoneNo) =>
                    TextFieldValidations.phoneNumberValidation(phoneNo),
                hintText: 'Enter your phone number',
                leadingIcon: Icon(
                  Icons.phone,
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
                  Icons.lock,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // =========================================================
              // Confirm Password Text Field
              // =========================================================
              AppTextField(
                controller: confirmPasswordTextController,
                validator: (password) =>
                    TextFieldValidations.confirmPasswordValidation(
                      password,
                      originalPassword: passwordTextController.text.trim(),
                    ),
                hintText: 'Confirm Password',
                isPassword: true,
                leadingIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.black,
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              // =========================================================
              // Accept Terms and Conditions
              // =========================================================
              CheckboxRow(
                value: isTermsAccepted,
                onChanged: (bool value) {
                  isTermsAccepted = value;
                  (context as Element).markNeedsBuild();
                },
              ),
            ],
          ),
        ),
            // ===============================================================
            // Button
            // ===============================================================
            const SizedBox(
              height: 20,
            ),
            AppMainButton(
              title: 'Submit',
              onPressed: () {
                if (signUpFormKey.currentState!.validate()) {
                   if(image == null){
                    Get.snackbar(
                        colorText:Colors.black,
                        "Canteen image is necessary",
                        "please select image for canteen");
                  }
                  else if(!isTermsAccepted){
                    Get.snackbar(
                        colorText:Colors.black,
                        "Accept terms and conditions",
                        "you need to accept the terms and condition before signin process");
                  }
                  else{
                     ImageController().uploadImageToFirebase('Canteen Images',nameTextController.text,image!,context).then((url) {
                       AuthModel authModel  = AuthModel(
                           name: nameTextController.text,
                           email: emailTextController.text,
                           password: passwordTextController.text,
                           mobile: phoneNoTextController.text,
                           image: url
                       );
                       authController.signUp(authModel, context);
                     }).catchError((error) {
                       Navigator.pop(context);
                       Get.snackbar(
                         "Something went wrong",
                         error.message.toString(),
                         colorText:  Colors.black,
                       );
                     });
                     Get.snackbar(
                         colorText:Colors.black,
                         'Information Saved Successfully',
                         'Your information is saved now wait for admin to approve your request');
                   }
                }

              },
            ),
            // ===============================================================
            // Already have an account
            // ===============================================================
            NavigationText(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            )
          ],
        ),
      ),
    ),);
  }
}
