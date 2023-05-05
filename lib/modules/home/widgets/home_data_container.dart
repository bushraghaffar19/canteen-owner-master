import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/modules/categories/add_category_popup.dart';
import 'package:canteen_owner_app/modules/home/models/home_data_model.dart';
import 'package:flutter/material.dart';

class HomeDataContainer extends StatelessWidget {
  final String text;
  final String? boldedText;
  final Widget? route;
  final String? trailingText;
  final bool isPopup;
  const HomeDataContainer({super.key, required this.text, this.boldedText, this.route, this.trailingText, required this.isPopup});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          if (isPopup) {
            showDialog(
              context: context,
              builder: (context) => const AddCategoryPopup(),
            );
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => route!));
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade50,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 3,
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: "$text ",
                style: AppFonts.kFont14pt,
                children: [
                  TextSpan(
                    text: boldedText ?? '',
                    style: AppFonts.kFont16ptBoldPrimary,
                  ),
                  TextSpan(
                    text: ' ${trailingText ?? ''}',
                    style: AppFonts.kFont14pt,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
