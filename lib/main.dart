import 'package:canteen_owner_app/controller/auth_controller.dart';
import 'package:canteen_owner_app/controller/category_controller.dart';
import 'package:canteen_owner_app/controller/customer_controller.dart';
import 'package:canteen_owner_app/controller/image_controller.dart';
import 'package:canteen_owner_app/controller/order_controller.dart';
import 'package:canteen_owner_app/controller/product_controller.dart';
import 'package:canteen_owner_app/core/utilities/material_color.dart';
import 'package:canteen_owner_app/modules/authentication/screens/sign_up_screen.dart';
import 'package:canteen_owner_app/modules/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'core/constants/app_colors.dart';

void main() {
  // ===========================================================================
  // Widget Binding
  // ===========================================================================
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(const CanteenOwnerApp());
    });
    Get.put(AuthController());
    Get.put(CategoryController());
    Get.put(ProductController());
    Get.put(OrderController());
    Get.put(CustomerController());
  });
  // ===========================================================================
  // To keep the app in Portrait up orientation
  // ===========================================================================
}

class CanteenOwnerApp extends StatelessWidget {
  const CanteenOwnerApp({super.key});
  @override
  Widget build(BuildContext context) {
    // =========================================================================
    // Gesture Detector is used to dismiss the keyboard on tap
    // =========================================================================
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Canteen Owner App',
        // =======================================================================
        // Theme Data
        // =======================================================================
        theme: ThemeData(
          primarySwatch: CustomMaterialColor.customColor,
          primaryColor: AppColors.kButtonColor,
          brightness: Brightness.light,
          primaryColorDark: AppColors.kBackgroundColor,
          iconTheme: const IconThemeData(color: AppColors.kButtonColor),
          // =====================================================================
          // App Bar Theme
          // =====================================================================
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            
            iconTheme: IconThemeData(color: Colors.black),
          ),
          scaffoldBackgroundColor: AppColors.kBackgroundColor,
        ),
        // =======================================================================
        // Main Route
        // =======================================================================
        home: FirebaseAuth.instance.currentUser ==null? const SignUpScreen() :const HomeScreen(),
      ),
    );
  }
}
