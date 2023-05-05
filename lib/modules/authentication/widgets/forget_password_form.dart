import 'package:canteen_owner_app/core/utilities/validators.dart';
import 'package:canteen_owner_app/shared/app_text_field.dart';
import 'package:flutter/material.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key, required this.forgetPasswordFormKey});

  final GlobalKey<FormState> forgetPasswordFormKey;

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final TextEditingController forgetPasswordController =
      TextEditingController();

  @override
  void dispose() {
    forgetPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.forgetPasswordFormKey,
      child: AppTextField(
        controller: forgetPasswordController,
        validator: (email) => TextFieldValidations.emailValidation(email),
        hintText: 'Enter your email',
        leadingIcon: Icon(
          Icons.email,
          color: Colors.black,
        ),
      ),
    );
  }
}
