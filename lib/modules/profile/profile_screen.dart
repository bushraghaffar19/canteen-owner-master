import 'dart:io';
import 'package:canteen_owner_app/core/utilities/app_assets.dart';
import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/core/utilities/validators.dart';
import 'package:canteen_owner_app/shared/app_button.dart';
import 'package:canteen_owner_app/shared/app_text_field.dart';
import 'package:canteen_owner_app/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/image_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../model/auth_model.dart';
import '../../shared/custom_dialogue.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneNumberController;
  File? image;
  Future pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file == null) return null;
    setImage(File(file.path));
  }
  void setImage(File? newImage) {
    setState(() {
      image = newImage;
    });
  }
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();

    nameController.text = authController.userData.value.name ?? 'Your Name';
    emailController.text = authController.userData.value.email ?? 'Your Name';
    phoneNumberController.text = authController.userData.value.mobile ?? 'Your Name';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {return Container(
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

  appBar: AppBar(
        title: const Text(
          'Edit profile',
          style: AppFonts.kFont16ptBold,
        ),
        actions: [
          IconButton(
              onPressed: (){
                confirmationDialogue(title: "Confirmation",
                    bodyText: "Are you sure you want to logout?",
                    function: (){
                      authController.signOut();
                    },
                    context: context
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Obx(() => ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                // Container(
                //   height: 180,
                //   width: 180,
                //   decoration:  BoxDecoration(
                //     shape: BoxShape.circle,
                //     image: DecorationImage(
                //       image:image == null ? NetworkImage(
                //         authController.userData.value.image ??'',
                //       ):NetworkImage(
                //         authController.userData.value.image ??'',
                //       ),
                //       fit: BoxFit.cover,
                //     ),
                //     boxShadow: const [
                //       BoxShadow(
                //         color: Colors.black12,
                //         spreadRadius: 3,
                //         blurRadius: 20,
                //         offset: Offset(0, 6),
                //       ),
                //     ],
                //   ),
                // ),
                ClipOval(
                    child: image != null ? Image(
                      image: FileImage(image!),
                      fit: BoxFit.cover,
                      width: 180.0,
                      height: 180.0,
                    ):
                    Image(
                      image: NetworkImage(authController.userData.value.image ??'',),
                      fit: BoxFit.cover,
                      width: 180.0,
                      height: 180.0,
                      color: AppColors.kBackgroundColor,
                    )
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(color: Colors.white,
                              width: 2
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          pickImage();
                        } ,
                        child:  const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.kButtonColor,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
              child: Column(
            children: [
              AppTextField(
                controller: nameController,
                validator: (name) => TextFieldValidations.nameValidation(name),
                hintText: 'Change your name',
              leadingIcon: Icon(
               Icons.person_outline_rounded,
                color: Colors.black,
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // AppTextField(
              //   controller: emailController,
              //   validator: (email) => TextFieldValidations.emailValidation(email),
              //   hintText: 'Change your name',
              // ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                controller: phoneNumberController,
                validator: (phone) =>
                    TextFieldValidations.phoneNumberValidation(phone),
                hintText: 'Change your phoneNo',
    leadingIcon: Icon(
    Icons.phone,
    color: Colors.black,
    ),
              ),
            ],
          )),
          const SizedBox(
            height: 50,
          ),
          AppMainButton(
            title: 'Submit',
            onPressed: () {
              if(image == null &&  _formKey.currentState!.validate()){
                loadingDialogue(context: context);
                authController.updateUserData({
                  AuthModel.userName : nameController.text,
                  AuthModel.userMobile : phoneNumberController.text,
                  AuthModel.canteenImage : authController.userData.value.image ?? ''
                }, context).then((value) {
                  Navigator.of(context).pop();
                  nameController.text = authController.userData.value.name ?? 'Your Name';
                  emailController.text = authController.userData.value.email ?? 'email';
                  phoneNumberController.text = authController.userData.value.mobile ?? 'mobile number';
                });
              }
              else if(_formKey.currentState!.validate()){
                ImageController().uploadImageToFirebase('Canteen Images',nameController.text,image!, context).then((value) {
                  authController.updateUserData({
                    AuthModel.userName : nameController.text,
                    AuthModel.userMobile : phoneNumberController.text,
                    AuthModel.canteenImage : value
                  }, context).then((value) {
                    Navigator.of(context).pop();
                    nameController.text = authController.userData.value.name ?? 'Your Name';
                    emailController.text = authController.userData.value.email ?? 'email';
                    phoneNumberController.text = authController.userData.value.mobile ?? 'mobile number';
                  });
                });
              }
            },
          ),
        ],
      ),)
    ),);
  }
}
