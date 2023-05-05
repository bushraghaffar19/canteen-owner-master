
import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/core/constants/app_colors.dart';
import 'package:canteen_owner_app/modules/categories/category_screen.dart';
import 'package:canteen_owner_app/modules/home/utils/home_utils.dart';
import 'package:canteen_owner_app/modules/home/utils/product_slider.dart';
import 'package:canteen_owner_app/modules/home/widgets/home_data_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:canteen_owner_app/modules/orders/screens/orders_screen.dart';
import '../../../core/utilities/app_imports.dart';
import '../../categories/add_category_popup.dart';
import '../../products/screens/add_product_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kLightButtonColor,
        title: const Text(
          'Foodie',
          style: AppFonts.kFont16ptBold,
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const ClampingScrollPhysics(),
          children:  [
            // ===================================================================
            // Slider
            // ===================================================================
            const ProductSlider(),
            // ===================================================================
            // Orders
            // ===================================================================
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Your Data',
              style: AppFonts.kFont16ptBold,
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => HomeDataContainer(
              text: 'You have gotten new orders',
              boldedText: orderController.allUserOrders.length.toString(),
              isPopup: false,
              route: const OrdersScreen(),
            ),),
            Obx(() => HomeDataContainer(
              text: 'Your Total Products',
              boldedText: productController.products.length.toString(),
              trailingText: 'Click to add new',
              route: const AddProductScreen(),
              isPopup: false,),),
            Obx(() => HomeDataContainer(
              text: 'Your Total Categories',
              boldedText: categoryController.category.length.toString(),
              route: const CategoryScreen(),
              isPopup: false,
            ))
          ],
      )
    );
  }
}
