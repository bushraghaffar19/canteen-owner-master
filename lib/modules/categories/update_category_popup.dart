import 'package:canteen_owner_app/model/category_model.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_fonts.dart';
import '../../core/utilities/app_imports.dart';
import '../../core/utilities/validators.dart';
import '../../shared/app_button.dart';
import '../../shared/app_text_field.dart';

class UpdateCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  const UpdateCategory({Key? key, required this.categoryModel}) : super(key: key);

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
   final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController.text = widget.categoryModel.categoryName ??'';
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
                'Update Category',
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
            title: 'Update',
            onPressed: () {
              if (categoryFormKey.currentState!.validate()){
                categoryController.updateCategory(nameController.text,widget.categoryModel.categoryId ??'', context);
              }
            },
          ),
        ],
      ),
    );
  }
}
