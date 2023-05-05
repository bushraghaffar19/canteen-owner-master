import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/modules/categories/add_category_popup.dart';
import 'package:canteen_owner_app/modules/home/models/bottom_navbar_model.dart';
import 'package:canteen_owner_app/modules/home/models/home_data_model.dart';
import 'package:canteen_owner_app/modules/home/screens/home_page.dart';
import 'package:canteen_owner_app/modules/orders/screens/orders_screen.dart';
import 'package:canteen_owner_app/modules/products/screens/add_product_screen.dart';
import 'package:canteen_owner_app/modules/products/screens/products_screen.dart';
import 'package:canteen_owner_app/modules/profile/profile_screen.dart';
import 'package:canteen_owner_app/modules/analytics/analytics.dart';
import 'package:flutter/material.dart';

class HomeUtils {
  // ===========================================================================
  // Selected Index for our navbar
  // ===========================================================================
  static int selectedScreen = HomeScreens.home.index;

  // ===========================================================================
  // List of Bottom Navbar Items
  // ===========================================================================
  static final List<BottomNavItemModel> bottomNavItems = [
    BottomNavItemModel(
      label: 'Orders',
      icon: Icons.delivery_dining,
      homeScreenItem: HomeScreens.orders,
    ),
    BottomNavItemModel(
      label: 'Products',
      icon: Icons.restaurant_menu,
      homeScreenItem: HomeScreens.products,
    ),
    BottomNavItemModel(
      label: 'Home',
      icon: Icons.home,
      homeScreenItem: HomeScreens.home,
    ),
    BottomNavItemModel(
      label: 'Analytics',
      icon: Icons.bar_chart,
      homeScreenItem: HomeScreens.analytics,
    ),
    BottomNavItemModel(
      label: 'Profile',
      icon: Icons.person,
      homeScreenItem: HomeScreens.profile,
    ),
  ];

  static final List<Widget> listScreens = [
    const OrdersScreen(),
    const ProductsScreen(),
    const HomePage(),
    const ProfileScreen(),
    const AnalyticsScreen(),
  ];

  static final List<HomeDataModel> homeDataContainers = [
    HomeDataModel(
      text: 'You have gotten new orders',
      boldedText: '14',
    ),
    HomeDataModel(
      text: 'Your Total Products',
      boldedText: productController.products.length.toString(),
      trailingText: 'Click to add new',
      route: const AddProductScreen(),
    ),
    HomeDataModel(
      text: 'Add new',
      boldedText: 'Categories',
      route: const AddCategoryPopup(),
      isPopup: true,
    ),
  ];
}

enum HomeScreens {
  orders,
  products,
  home,

  profile,
  analytics,
}
