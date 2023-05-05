import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/model/customer_model.dart';
import 'package:canteen_owner_app/model/order_model.dart';
import 'package:canteen_owner_app/modules/orders/screens/order_detail_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
enum SampleItem { itemOne, itemTwo, itemThree }
class OrderContainer extends StatefulWidget {
  const OrderContainer({super.key, required this.orders});

  final OrderModel orders;

  @override
  State<OrderContainer> createState() => _OrderContainerState();
}

class _OrderContainerState extends State<OrderContainer> {
  late CustomerModel customer;
SampleItem? selectedMenu;
  @override
  void initState() {
    super.initState();
    customer = customerController.getCustomer(widget.orders.userId ??'');
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             /* GestureDetector(
                onTap: ()
                {
                  Get.to(OrderDetailScreen(orderModel: widget.orders));
                },
              ),*/
              InkWell(
    onTap: () {
     Navigator.push(context,MaterialPageRoute(builder:(context)=>OrderDetailScreen(orderModel: widget.orders)));
    },

              child: RichText(


                text:  TextSpan(
                  text: 'Order# ',
                /* recognizer: TapGestureRecognizer()
                  ..onTap=(){
                    Get.to(OrderDetailScreen(orderModel: widget.orders));
                },*/
                  style: AppFonts.kFont14pt,
                  children: <InlineSpan>[
                    TextSpan(
                        text: widget.orders.orderCode.toString() ??'', style: AppFonts.kFont16ptBoldPrimary,
    /*recognizer: TapGestureRecognizer()
    ..onTap=(){
    Get.to(OrderDetailScreen(orderModel: widget.orders));}*/
                    )],
                ),
              ),),

              PopupMenuButton<SampleItem>(
                initialValue: selectedMenu,
                // Callback that sets the selected popup menu item.
                onSelected: (SampleItem item) {
                  setState(() {
                    selectedMenu = item;
                  });
                },
                itemBuilder:(BuildContext context) => <PopupMenuEntry<SampleItem>>[
    const PopupMenuItem<SampleItem>(
    value: SampleItem.itemOne,
    child: Text('Accepted'),
    ),
    const PopupMenuItem<SampleItem>(
    value: SampleItem.itemTwo,
    child: Text('Prepared'),
    ),
    const PopupMenuItem<SampleItem>(
    value: SampleItem.itemThree,
    child: Text('Delivered'),
    ),
    ],
              ),
           /*   IconButton(
                  onPressed: () {
                    Get.to(OrderDetailScreen(orderModel: widget.orders));
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ))*/
            ],
          ),
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
                    'Ordered By',
                    style: AppFonts.kFont14pt,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    customer.name ??'',
                    style: AppFonts.kFont16ptBoldPrimary,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              Visibility(
                visible: widget.orders.roomNo == '' ? false:true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Deliver to',
                      style: AppFonts.kFont14pt,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Room 150',
                      style: AppFonts.kFont16ptBoldPrimary,
                    ),
                    Divider(),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Text(
            'Total Amount',
            style: AppFonts.kFont14pt,
          ),
          const SizedBox(
            height: 8,
          ),
           Text(
            'Rs. ${widget.orders.totalAmount}',
            style: AppFonts.kFont16ptBoldPrimary,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
