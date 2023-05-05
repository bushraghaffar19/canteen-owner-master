import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../controller/image_controller.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utilities/app_imports.dart';
import '../../../core/utilities/validators.dart';
import '../../../model/category_model.dart';
import '../../../model/product_model.dart';
import '../../../shared/app_button.dart';
import '../../../shared/app_text_field.dart';
import '../../../shared/dropdown_text_field.dart';
import '../../../shared/loading_widget.dart';
import '../widgets/add_image_container.dart';

class UpdateProductScreen extends StatefulWidget {
  final ProductModel product;
  const UpdateProductScreen({Key? key, required this.product}) : super(key: key);
  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
   final TextEditingController nameController = TextEditingController();
   final TextEditingController descriptionController = TextEditingController();
   final TextEditingController priceController = TextEditingController();
  bool value = false;
  final GlobalKey<FormState> productFormKey = GlobalKey<FormState>();
  CategoryModel? selectedCategory;
  List<CategoryModel> category = [];
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
    nameController.text = widget.product.name ??'';
    value = widget.product.isProductAvailable ?? false ;
    descriptionController.text = widget.product.description ??'';
    priceController.text = widget.product.price.toString() ??'';
    selectedCategory = categoryController.category.where((element) => element.categoryId == widget.product.categoryId).first;
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
  Widget build(BuildContext context) {  return Container(
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
        title: const Text(
          'Update Product',
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
            child: image != null ? AddImageContainer(
              image: image,
              title: 'Add an product image',
            ):
            Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Colors.grey.shade50,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 3,
                        blurRadius: 20,
                        offset: Offset(0, 6),
                      ),
                    ],
                    image: DecorationImage(
                        image: NetworkImage(widget.product.image ??''),
                        fit: BoxFit.fill
                    )
                )),
          ),
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
              title: 'Update',
              onPressed: () {
                if(image == null && productFormKey.currentState!.validate()){
                  loadingDialogue(context: context);
                  ProductModel productModel  = ProductModel(
                    name: nameController.text,
                    id: widget.product.id,
                    image: widget.product.image,
                    description: descriptionController.text,
                    categoryId: selectedCategory?.categoryId ??'',
                    price: double.parse(priceController.text),
                    isProductAvailable: value,
                  );
                  productController.updateProduct(productModel, context);
                }
                else if(productFormKey.currentState!.validate()){
                  ImageController().uploadImageToFirebase('Product Images',nameController.text,image!,context).then((url) {
                    ProductModel productModel  = ProductModel(
                      name: nameController.text,
                      image: url,
                      id: widget.product.id,
                      description: descriptionController.text,
                      categoryId: selectedCategory?.categoryId ??'',
                      price: double.parse(priceController.text),
                      isProductAvailable: value,
                    );
                    productController.updateProduct(productModel, context);
                  }).catchError((error) {
                    Navigator.pop(context);
                    Get.snackbar(
                      "Something went wrong",
                      error.message.toString(),
                      colorText:  Colors.black,
                    );
                  });
                }
              })
        ],
      ),
    ),);
  }
}
