import 'package:canteen_owner_app/core/constants/app_colors.dart';
import 'package:canteen_owner_app/core/utilities/app_assets.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/modules/products/screens/add_product_screen.dart';
import 'package:canteen_owner_app/modules/products/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_fonts.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =======================================================================
      // Appbar
      // =======================================================================
      appBar: AppBar(
        backgroundColor: AppColors.kLightButtonColor,
        title: const Text(
          'Your Products',
          style: AppFonts.kFont16ptBold,
        ),
      ),
      // =======================================================================
      // Body
      // =======================================================================
      body: Obx(() {
        return
          productController.products.isNotEmpty ?
          GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 210,
          ),
          itemCount: productController.products.length,
          itemBuilder: ((context, index) => SingleProduct(
            product: productController.products[index],
          )),
        ):
        const Center(
        child: Text("product not found"),
        );
      }),
      // =======================================================================
      // Floating Action Button
      // =======================================================================
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(categoryController.category.isNotEmpty){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddProductScreen(),
              ),
            );
          }
          else{
            Get.snackbar(
                "Category not found",
                "you need to add category before adding the products",
              colorText: Colors.black
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
