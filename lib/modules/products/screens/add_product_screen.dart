import 'dart:io';
import 'package:canteen_owner_app/core/constants/app_colors.dart';
import 'package:canteen_owner_app/controller/image_controller.dart';
import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/core/utilities/validators.dart';
import 'package:canteen_owner_app/model/product_model.dart';
import 'package:canteen_owner_app/modules/products/widgets/add_image_container.dart';
import 'package:canteen_owner_app/shared/app_button.dart';
import 'package:canteen_owner_app/shared/app_text_field.dart';
import 'package:canteen_owner_app/shared/dropdown_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/category_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;
  bool value = false;
  final GlobalKey<FormState> productFormKey = GlobalKey<FormState>();
  CategoryModel? selectedCategory;
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

  @override
  void initState() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
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

  // =======================================================================
      // Appbar
      // =======================================================================
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor,
        title: const Text(
          'Add Product',
          style: AppFonts.kFont16ptBold,
        ),
      ),
      // =======================================================================
      // Body
      // =======================================================================
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          // ===================================================================
          // Add Image
          // ===================================================================
          GestureDetector(
              onTap: (){
                pickImage();
              },
              child: AddImageContainer(
                image: image,
                title: 'Add an product image',
              )),
          const SizedBox(
            height: 20,
          ),
          // ===================================================================
          // Form
          // ===================================================================
          Form(
            key: productFormKey,
            child: Column(
              children: [
                AppTextField(
                  controller: nameController,
                  validator: (name) =>
                      TextFieldValidations.nameValidation(name),
                  hintText: 'Product Name',
              leadingIcon: Icon(
                Icons.fastfood_outlined,
                color: Colors.black,
              ),

                ),
                const SizedBox(
                  height: 20,
                ),
                DropDownTextField(
                  hintText: 'Select Category',
                  options: categoryController.category,
                  value: selectedCategory,
                  onChanged: (CategoryModel? value) {
                    setState(() {
                      selectedCategory = value ;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  controller: descriptionController,
                  validator: (descripion) =>
                      TextFieldValidations.descriptionValidation(descripion),
                  hintText: 'Enter your product description...',
                  maxLines: 6,
                  leadingIcon: Icon(
                    Icons.description_outlined,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  controller: priceController,
                  validator: (price) =>
                      TextFieldValidations.priceValidation(price),
                  hintText: 'Price',
                  textInputType: TextInputType.number,
                  leadingIcon: Icon(
                    Icons.price_change_outlined,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: value,
                      onChanged: (newVal){
                        setState(() {
                          value = newVal!;
                        });
                      },
                    ),
                    const Text("Is available in Stock",style: AppFonts.kFont16pt,)
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          AppMainButton(
              title: 'Add',
              onPressed: () {
                if (productFormKey.currentState!.validate()){
                  if(image == null){
                    Get.snackbar(
                        colorText:Colors.black,
                        "Product image is necessary",
                        "please select image for product");
                  }
                  else if(selectedCategory == null){
                    Get.snackbar(
                        colorText:Colors.black,
                        "field is necessary",
                        "please select category for product");
                  }
                  else{
                    ImageController().uploadImageToFirebase('Product Images',nameController.text,image!,context).then((url) {
                      ProductModel productModel  = ProductModel(
                          name: nameController.text,
                          image: url,
                          description: descriptionController.text,
                          categoryId: selectedCategory?.categoryId ??'',
                          price: double.parse(priceController.text),
                          isProductAvailable: value,
                      );
                      productController.addProduct(productModel, context);
                    }).catchError((error) {
                      Navigator.pop(context);
                      Get.snackbar(
                        "Something went wrong",
                        error.message.toString(),
                        colorText:  Colors.black,
                      );
                    });
                  }
                }
              })
        ],
      ),
    ),);
  }
}
