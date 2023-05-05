import 'package:canteen_owner_app/model/category_model.dart';
import 'package:canteen_owner_app/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../core/utilities/app_imports.dart';
import '../shared/custom_dialogue.dart';
class ProductController extends GetxController{
  static ProductController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  CollectionReference productReference = FirebaseFirestore.instance.collection('product');

  bindingStream() {
    if (FirebaseAuth.instance.currentUser != null) {
      products.bindStream(getAllProduct(FirebaseAuth.instance.currentUser?.uid ??''));
    }
  }

  Stream<List<ProductModel>> getAllProduct(String canteenId) =>
      productReference.orderBy('Publish Date', descending: true).where("user_id",isEqualTo: canteenId).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data() as Map<String, dynamic>)).toList());

  Future<void> addProduct(ProductModel productModel,context) async{
    String docId = productReference.doc().id;
    productReference.doc(docId).set({
      ProductModel.prodId: docId,
      "user_id" : authController.userData.value.uid,
      ProductModel.prodName: productModel.name,
      ProductModel.prodImage: productModel.image,
      ProductModel.prodPrice: productModel.price,
      ProductModel.cateId: productModel.categoryId,
      ProductModel.prodDescription: productModel.description,
      ProductModel.prodIsStock: productModel.isProductAvailable,
      "Publish Date":DateTime.now(),
      "is_favourite":false,
    }).then((value) async {
      Navigator.pop(context);
      Navigator.pop(context);
    }).catchError((onError) {
      Navigator.pop(context);
      Get.snackbar(
        "Something went wrong",
        onError.message.toString(),
        colorText:Colors.black,
      );
    });
  }
  Future<void> updateProduct(ProductModel productModel,context) async{
    await productReference.doc(productModel.id).update(
        productModel.toJson()
    ).then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
      Get.snackbar(
        "Successfully",
        "Details of product updated successfully",
        colorText: Colors.black,
      );
    }
    ).catchError((e){
      Navigator.pop(context);
      customDialogue(
          title: "Something went wrong",
          bodyText: e.message.toString(),
          context: context
      );
    });
  }

  Future<void> deleteProduct(String uid,context) async{
    await productReference.doc(uid).delete().then((value) {
      Get.snackbar(
        "Successfully",
        "Details of product delete successfully",
        colorText:Colors.black,
      );
    }
    ).catchError((e){
      customDialogue(
          title: "Something went wrong",
          bodyText: e.message.toString(),
          context: context
      );
    });
  }
}