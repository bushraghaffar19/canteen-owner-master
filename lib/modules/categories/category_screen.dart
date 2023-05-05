import 'package:canteen_owner_app/core/constants/app_colors.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/model/category_model.dart';
import 'package:canteen_owner_app/modules/categories/update_category_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_fonts.dart';
import '../../shared/custom_dialogue.dart';
import 'add_category_popup.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kLightButtonColor,
        title: const Text(
          'Your Category',
          style: AppFonts.kFont16ptBold,
        ),
      ),
      body: Obx(() {
        return categoryController.category.isNotEmpty ?
          ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          itemCount: categoryController.category.length,
          itemBuilder: ((context, index) => SingleCategory(
            categoryModel: categoryController.category[index],
          )),
        ):const Center(
          child: Text("category not found"),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddCategoryPopup(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SingleCategory extends StatelessWidget {
  final CategoryModel categoryModel;
  const SingleCategory({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade50,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 3,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(categoryModel.categoryName ??'',
            style: AppFonts.kFont16ptBold,
          ),
          const Spacer(),
          GestureDetector(
            onTap: (){
              confirmationDialogue(title: "Confirmation",
                  bodyText: "Are you sure you want to delete the details of category?",
                  function: (){
                    categoryController.deleteCategory(categoryModel.categoryId??"", context).catchError((e){
                      Navigator.pop(context);
                      customDialogue(
                          title: "Something went wrong",
                          bodyText: e.message.toString(),
                          context: context
                      );
                    });
                  },
                  context: context
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 3,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete,
                size: 12,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 20,),
          GestureDetector(
            onTap: (){
              showDialog(
                context: context,
                builder: (context) =>  UpdateCategory(categoryModel: categoryModel),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 3,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit,
                size: 12,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
