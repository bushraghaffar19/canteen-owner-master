import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/core/utilities/validators.dart';
import 'package:canteen_owner_app/shared/app_button.dart';
import 'package:canteen_owner_app/shared/app_text_field.dart';
import 'package:flutter/material.dart';

class AddCategoryPopup extends StatefulWidget {
  const AddCategoryPopup({super.key});

  @override
  State<AddCategoryPopup> createState() => _AddCategoryPopupState();
}

class _AddCategoryPopupState extends State<AddCategoryPopup> {
  late final TextEditingController nameController;
  final GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add Category',
                style: AppFonts.kFont16ptBoldPrimary,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 18,
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: categoryFormKey,
            child: AppTextField(
              controller: nameController,
              validator: (name) => TextFieldValidations.nameValidation(name),
              hintText: 'Category Name',
              leadingIcon: Icon(
                Icons.category_outlined,
                color: Colors.black,
              ),

            ),
          ),
          const SizedBox(
            height: 30,
          ),
          AppMainButton(
            title: 'Add',
            onPressed: () {
              if (categoryFormKey.currentState!.validate()){
                categoryController.addCategory(nameController.text, context);
              }
            },
          ),
        ],
      ),
    );
  }
}
