import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/customer_model.dart';
class CustomerController extends GetxController{
  static CustomerController instance = Get.find();
  CollectionReference userReference =
  FirebaseFirestore.instance.collection('users');
  Rx<CustomerModel> customerData = CustomerModel().obs;
  RxList<CustomerModel> allCustomer = RxList<CustomerModel>([]);
  bindingStream() {
    if (FirebaseAuth.instance.currentUser != null) {
      allCustomer.bindStream(getAllCustomer());
    }
  }


  String paymentStatus ='';
  String paymentMethod ='';
  String roomNo = '';

  Stream<List<CustomerModel>> getAllCustomer() =>
      userReference.snapshots().map((query) =>
          query.docs.map((item) => CustomerModel.fromMap(item.data() as Map<String, dynamic>)).toList());

  CustomerModel getCustomer(String id) =>
      allCustomer.where((value) => value.uid == id).first;


}