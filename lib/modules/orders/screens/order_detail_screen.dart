import 'package:canteen_owner_app/core/constants/app_colors.dart';
import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/model/order_model.dart';
import 'package:canteen_owner_app/modules/orders/widgets/dropdown_order_status.dart';
import 'package:canteen_owner_app/shared/app_button.dart';
import 'package:canteen_owner_app/shared/custom_dialogue.dart';
import 'package:canteen_owner_app/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderModel orderModel;
  const OrderDetailScreen({Key? key, required this.orderModel}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List<String> statusList = ["Accepted","Prepared","Delivered"];
  String? selectedStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kLightButtonColor,
        title:  const Text(
          "Order Detail",
          style: AppFonts.kFont16ptBold,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '#${widget.orderModel.orderCode.toString()}',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),
                          ),
                          Text(
                            widget.orderModel.orderStatus ??'',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: widget.orderModel.orderStatus == "pending" ? Colors.red :Colors.green
                          ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text(
                          DateFormat('dd MMMM, yyyy - h:mm a').format(widget.orderModel.orderOn ?? DateTime.now()),
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),
                      ),
                      widget.orderModel.roomNo == '' ?const SizedBox():Column(
                        children: [
                          const SizedBox(height: 20,),
                          Text(
                            "Delivered to",
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            widget.orderModel.roomNo ??'',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(
                       "Payment Method",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        widget.orderModel.paymentMethod ??'',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Status",
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          ),
                          Text(
                            widget.orderModel.paymentStatus ??'',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color:widget.orderModel.paymentStatus == "pending" ? Colors.red :Colors.green
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                       Divider(color: AppColors.kLightGreyColor.withOpacity(.5),thickness: .5,),
                      const SizedBox(height: 20,),
                      ...widget.orderModel.cart!.map((item) {
                        return RowWidget(title: "${item.product?.name} x ${item.quantity}",
                            subtitle: "Rs.${(item.product?.price )??'' * (item.quantity ??0) }"
                        );
                      }).toList(),
                      const SizedBox(height: 20,),
                      Divider(color: AppColors.kLightGreyColor.withOpacity(.5),thickness: .5,),
                      const SizedBox(height: 20,),
                      RowWidget(title: "Subtotal", subtitle: "Rs.${widget.orderModel.totalAmount}"),
                      const SizedBox(height: 20,),
                      Divider(color: AppColors.kLightGreyColor.withOpacity(.5),thickness: .5,),
                      const SizedBox(height: 30,),
                      DropDownStatus(
                          hintText: 'select order status',
                          options: statusList,
                          value: selectedStatus,
                          onChanged: (value){
                            setState(() {
                              selectedStatus = value;
                            });
                          }),
                      const Spacer(),
                      widget.orderModel.orderStatus == "Received"? const SizedBox() : Align(
                        alignment: Alignment.center,
                        child: AppMainButton(
                            title: "Complete",
                            onPressed: (){
                          if(selectedStatus == null){
                            customDialogue(
                                title: "Something went wrong",
                                bodyText: 'Please select order status from dropdown',
                                context: context
                            );
                          }
                          else{
                            loadingDialogue(context: context);
                            orderController.updateOrderStatus(
                                {
                                  OrderModel.orderSTATUS:selectedStatus,
                                  OrderModel.paymentSTATUS:selectedStatus == "Delivered" ? "Success":widget.orderModel.paymentStatus
                                },
                                widget.orderModel,
                                selectedStatus ??'',
                            ).then((value) {
                              Navigator.of(context).pop();
                              Get.back();
                            });
                          }
                            }),
                      ),
                      const SizedBox(height: 40,),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const RowWidget({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),
          ),
        ],
      ),
    );
  }
}
