import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/modules/home/utils/home_utils.dart';
import 'package:canteen_owner_app/modules/home/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  onRefresh(BuildContext context) {
    (context as Element).markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeUtils.listScreens[HomeUtils.selectedScreen],
      bottomNavigationBar: CustomBottomNavBar(
        notifyParent: () => onRefresh(context),
      ),
    );
  }
}
