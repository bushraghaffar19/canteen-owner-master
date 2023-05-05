import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/model/customer_model.dart';
import 'package:canteen_owner_app/model/order_model.dart';
import 'package:canteen_owner_app/model/auth_model.dart';
import 'package:canteen_owner_app/modules/orders/screens/order_detail_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

enum SampleItem { itemOne, itemTwo, itemThree }
class NewRequestContainer extends StatefulWidget {
  const NewRequestContainer({super.key, required this.auth});

  final AuthModel auth;

  @override
  State<NewRequestContainer> createState() => _NewRequestContainerState();
}

class _NewRequestContainerState extends State<NewRequestContainer> {
  late AuthModel authModel;
  @override
  void initState() {
    super.initState();
    authModel = authController.userData(widget.auth);

  }
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.grey.shade50,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 3,
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Text(
                    'Canteen Owner',
                    style: AppFonts.kFont14pt,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    authModel.name ??'',
                    style: AppFonts.kFont16ptBoldPrimary,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
