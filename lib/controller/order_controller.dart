import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/order_model.dart';


class OrderController extends GetxController{
  static OrderController instance = Get.find();
  RxList<OrderModel> allUserOrders = RxList<OrderModel>([]);
  CollectionReference orderReference = FirebaseFirestore.instance.collection('user_order');
  CollectionReference userReference =
  FirebaseFirestore.instance.collection('users');

  bindingStream() {
    if (FirebaseAuth.instance.currentUser != null) {
      allUserOrders.bindStream(getAllOrders(FirebaseAuth.instance.currentUser?.uid ??''));
    }
  }
  
  String paymentStatus ='';
  String paymentMethod ='';
  String roomNo = '';
  
  Stream<List<OrderModel>> getAllOrders(String canteenId) =>
      orderReference.orderBy('order_on', descending: true).where("canteen_id",isEqualTo: canteenId).snapshots().map((query) =>
          query.docs.map((item) => OrderModel.fromMap(item.data() as Map<String, dynamic>)).toList());

  Future<void> updateOrderStatus(Map<String, dynamic> data,OrderModel orderModel,String status) async{
    String token = '';
    userReference.doc(orderModel.userId).get().then((value) {
      token = value['Token'];
    });
    await orderReference
        .doc(orderModel.orderId)
        .update(data).then((value) {
          authController.sendNotification(
              "Order status updated",
              "The status of your order# ${orderModel.orderCode} change to $status. please visit the app to see the detail of order.",
              token);
    });
  }

  getUserData(){

  }

}