import 'package:canteen_owner_app/modules/home/utils/home_utils.dart';
import 'package:flutter/cupertino.dart';

class BottomNavItemModel{
  final String label;
  final IconData icon;
  final HomeScreens homeScreenItem;

  BottomNavItemModel({
    required this.label,
    required this.icon,
    required this.homeScreenItem,
  });
}