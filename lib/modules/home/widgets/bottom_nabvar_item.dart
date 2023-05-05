import 'package:canteen_owner_app/modules/home/models/bottom_navbar_model.dart';
import 'package:canteen_owner_app/modules/home/utils/home_utils.dart';
import 'package:flutter/material.dart';

class CustomNavItem extends StatelessWidget {
  const CustomNavItem(
      {super.key, required this.navItem, required this.notifyParent});
  final BottomNavItemModel navItem;
  final Function notifyParent;

  @override
  Widget build(BuildContext context) {
    bool isSelected = HomeUtils.selectedScreen == navItem.homeScreenItem.index;
    return GestureDetector(
      onTap: () async {
        HomeUtils.selectedScreen = navItem.homeScreenItem.index;
        notifyParent();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Icon(
              navItem.icon,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Text(
              navItem.label,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w400,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
