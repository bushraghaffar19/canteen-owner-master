import 'package:canteen_owner_app/core/constants/app_colors.dart';
import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/modules/superadmin/new_request_screen.dart';
import 'package:canteen_owner_app/modules/superadmin/request_conf.dart';
import 'package:canteen_owner_app/modules/orders/widgets/order_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child:  Scaffold(

          appBar: AppBar(
            backgroundColor: AppColors.kLightButtonColor,
            title: const Text(
              'Registration Requests',
              style: AppFonts.kFont16ptBold,
            ),
            bottom: const TabBar(
              tabs: <Widget>[
                Text("New Requests"),
                Text("Requests Confirmed")
              ],

            ),
          ),

          body: TabBarView(
              children:[
                NewRequestScreen(),
                RequestConf()

              ] )),
    );
  }
}
