import 'dart:io';
import 'package:canteen_owner_app/core/utilities/app_assets.dart';
import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/core/utilities/validators.dart';
import 'package:canteen_owner_app/shared/app_button.dart';
import 'package:canteen_owner_app/shared/app_text_field.dart';
import 'package:canteen_owner_app/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/image_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../model/auth_model.dart';
import '../../shared/custom_dialogue.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen_owner_app/analytics_page.dart';
import 'package:canteen_owner_app/model/customer_model.dart';
import 'package:canteen_owner_app/model/order_model.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}


class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<charts.Series<UserOrder,String>> _seriesBarData = <charts.Series<UserOrder,String>>[];
  List<UserOrder>? myData;

  final List<charts.Color> customColors = [
    charts.ColorUtil.fromDartColor(Colors.blue),
    charts.ColorUtil.fromDartColor(Colors.green),
    charts.ColorUtil.fromDartColor(Colors.orange),
    charts.ColorUtil.fromDartColor(Colors.red),
  ];

  _generateData(myData) {
    _seriesBarData.add(
      charts.Series(
        domainFn: (UserOrder sales,_)=> sales.product_name.toString(),
        measureFn: (UserOrder sales,_)=> sales.quantity,
        id:'UserOrder',
        data:myData,
        labelAccessorFn: (UserOrder row,_)=> "${row.product_name}",
        colorFn: (UserOrder sales, _) => customColors[sales.quantity % customColors.length],
      ),//charts.series
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kLightButtonColor,
        title: const Text(
          'Analytics Report',
          style: AppFonts.kFont16ptBold,
        ),
      ),
      body:_buildBody(context),
    );
  }

  Widget _buildBody(context){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('sales').snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return LinearProgressIndicator();
        }
        else{
          List<UserOrder> sales=snapshot.data!.docs.map((snapshot)=>UserOrder.fromMap(snapshot.data() as Map<String,dynamic>)).toList();
          return _buildChart(context,sales);
        }
      },
    );

  }
  Widget _buildChart(BuildContext context,List<UserOrder> sales){
    myData=sales;
    _generateData(myData);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 8.0,),
              Expanded(
                child: charts.BarChart(_seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds: 3),
                  behaviors: [
                    new charts.DatumLegend(
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'Georgia',
                          fontSize: 12),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

