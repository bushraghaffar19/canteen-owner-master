import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/model/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../shared/custom_dialogue.dart';
import '../shared/loading_widget.dart';
class CategoryController extends GetxController{
  static CategoryController instance = Get.find();
  RxList<CategoryModel> category = RxList<CategoryModel>([]);
  CollectionReference categoryReference = FirebaseFirestore.instance.collection('category');

  bindingStream() {
    if (FirebaseAuth.instance.currentUser != null) {
      category.bindStream(getAllCategory(FirebaseAuth.instance.currentUser?.uid ??''));
    }
  }

  Stream<List<CategoryModel>> getAllCategory(String canteenId) =>
      categoryReference.orderBy('Publish Date', descending: true).where("user_id",isEqualTo: canteenId)
          .snapshots().map((query) =>
          query.docs.map((item) => CategoryModel.fromMap(item.data() as Map<String, dynamic>)).toList());

  Future<void> addCategory(String categoryName,context) async{
    loadingDialogue(context: context);
    String docId = categoryReference.doc().id;
    categoryReference.doc(docId).set({
      CategoryModel.cateId: docId,
      CategoryModel.cateName: categoryName,
      "user_id" : authController.userData.value.uid,
      "Publish Date":DateTime.now()
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

  Future<void> updateCategory(String categoryName,String id,context) async{
    loadingDialogue(context: context);
    await categoryReference.doc(id).update(
       {
         CategoryModel.cateName: categoryName,
       }
    ).then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
      Get.snackbar(
        "Successfully",
        "Details of category updated successfully",
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

  Future<void> deleteCategory(String uid,context) async{
    await categoryReference.doc(uid).delete().then((value) {
      Get.snackbar(
        "Successfully",
        "Details of category delete successfully",
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