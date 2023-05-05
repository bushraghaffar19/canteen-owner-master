import 'package:canteen_owner_app/core/constants/app_colors.dart';
import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/modules/orders/widgets/order_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kLightButtonColor,
        title: const Text(
          'Orders',
          style: AppFonts.kFont16ptBold,

        ),
      ),
      body: Obx(() =>
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: orderController.allUserOrders.length,
            itemBuilder: (context, index) => OrderContainer(
              orders: orderController.allUserOrders[index],
            ),
          ),
      ),
    );
  }
}
