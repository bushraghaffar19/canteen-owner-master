import 'package:flutter/material.dart';

import '../utils/home_utils.dart';
import 'bottom_nabvar_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key, required this.notifyParent});
  final Function notifyParent;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 70),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26.0),
          topRight: Radius.circular(26.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5.0,
            blurRadius: 30.0,
            offset: const Offset(0.0, 0.75),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: HomeUtils.bottomNavItems
              .map((element) => CustomNavItem(
                    navItem: element,
                    notifyParent: notifyParent,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
