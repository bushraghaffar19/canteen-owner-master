import 'dart:convert';
import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/modules/authentication/screens/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../model/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../modules/authentication/screens/login_screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/home/utils/home_utils.dart';
import '../shared/custom_dialogue.dart';
import '../shared/loading_widget.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  Rx<AuthModel> userData = AuthModel().obs;
  User? currentUser = FirebaseAuth.instance.currentUser;


  CollectionReference userReference =
  FirebaseFirestore.instance.collection('canteen_user');
  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    //binding all Streams
    currentUser = user;
    if (currentUser != null) {
      userData.bindStream(listenToUser());
      categoryController.bindingStream();
      productController.bindingStream();
      orderController.bindingStream();
      customerController.bindingStream();
    }

  }

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  Future<void> updateFCMDeviceToken() async{
    var token = await firebaseMessaging.getToken();
    await userReference.doc(currentUser?.uid).update({
      'Token':token,
    });
    firebaseMessaging.subscribeToTopic('allUsers');
  }

  Stream<AuthModel> listenToUser() =>
      userReference.doc(firebaseUser.value?.uid)
          .snapshots()
          .map((snapshot) => AuthModel.fromMap(snapshot.data()as Map<String, dynamic>));



  Future<void> signUp(AuthModel authModel, context) async {
    // await sharedPreferences!.clear();
    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: authModel.email ??'',
      password: authModel.password ??'',
    )
        .then((auth) {
      currentUser = auth.user;
      userReference.doc(currentUser!.uid).set({
        AuthModel.userId: currentUser!.uid,
        AuthModel.userEmail: currentUser!.email,
        AuthModel.userName: authModel.name,
        AuthModel.userPassword: authModel.password,
        AuthModel.userMobile:authModel.mobile,
        AuthModel.canteenImage:authModel.image
      }).then((value) async {
        await firebaseAuth.signOut();
        Navigator.pop(context);
        Get.offAll(() => const LoginScreen());
      }).catchError((onError) {
        Navigator.pop(context);
        Get.snackbar(
          "Something went wrong",
          onError.message.toString(),
          colorText:Colors.black,
        );
      });
    }).catchError((onError) {
      Navigator.pop(context);
      Get.snackbar(
        "Something went wrong",
        onError.message.toString(),
        colorText:Colors.black,
      );
    });
  }

  List token =[];
  Future<void> logIn(
      String email, password, context) async {
    loadingDialogue(context: context);
    // await sharedPreferences!.clear();
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((auth) async{
       currentUser = auth.user;
      final dataSnapshot = await userReference
          .doc(currentUser!.uid)
          .get();
      if(dataSnapshot.exists){
        if(currentUser != null){
          updateFCMDeviceToken();
          Navigator.pop(context);
          HomeUtils.selectedScreen = 2;
          Get.offAll(() => const HomeScreen());
        }
      }
      else{
        Navigator.pop(context);
        firebaseAuth.signOut();
        Get.snackbar(
          "Something went wrong",
          "There is no user record corresponding to this identifier. The user may have been deleted.",
          colorText:Colors.black
        );
      }
      }).catchError((onError) {
        Navigator.pop(context);
        Get.snackbar(
          "Something went wrong",
          onError.message.toString(),
          colorText:Colors.black,
        );
      });
  }

  Future<void> resetPassword(String email, context) async {
    loadingDialogue(context: context);
    await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
      Navigator.pop(context);
      customDialogue(context:context,title: "Check your email",bodyText: "We have sent a password recover instructions to your email",isBack:true);
    }).catchError((error) {
      Navigator.pop(context);
      Get.snackbar(
        "Something went wrong",
        error.message.toString(),
        colorText:Colors.black,
      );
    });
  }

  Future<void> updateUserData(Map<String, dynamic> data,context) async{
    await userReference.doc(firebaseUser.value?.uid).update(
        data
    ).then((value) {
      Get.snackbar(
        "Successfully",
        "Details of canteen updated successfully",
        colorText: Colors.black
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

  Future<void> changeEmail(String newEmail , context) async{
    loadingDialogue(context: context,);
    User? user =  FirebaseAuth.instance.currentUser;
    user?.updateEmail(newEmail).then((value) {
      updateUserData({AuthModel.userEmail:newEmail},context);
      Get.back();
      Get.back();
    }).catchError((e){
      Get.back();
      customDialogue(
          title: "Something went wrong",
          bodyText: e.message.toString(),
          context: context
      );
    });
  }

  Future<void> changePassword(String oldPassword, newPassword, context) async {
    String email = currentUser!.email!;
    loadingDialogue(context: context);
    firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: oldPassword,
    ).then((value) {
      currentUser?.updatePassword(newPassword).then((value) {
        updateUserData({AuthModel.userPassword:newPassword},context);
        Get.back();
        Get.back();
      }).catchError((error) {
        Navigator.pop(context);
        customDialogue(
            title: "Something went wrong",
            bodyText: error.message.toString(),
            context: context
        );
      });
    }).catchError((onError) {
      Navigator.pop(context);
      customDialogue(
          title: "Something went wrong",
          bodyText: onError.message.toString(),
          context: context
      );
    });
  }

  void  signOut ()async{
    await firebaseAuth.signOut();
    Get.offAll(const SignUpScreen());
  }


  Future<void> sendNotification(String notificationTitle, String notificationBody, String targetFCMToken) async {
    const String url = 'https://fcm.googleapis.com/fcm/send';
    Map<String, String> headers = <String, String>{};
    headers['Content-Type'] = 'application/json';
    headers['Authorization'] = 'key=AAAAjvP13VY:APA91bEE4WT_HMJj0jMF9djhDRHemD4Qho4LZyIt8q3pFEXufOndyaFvOmiAEvFiMoU1e4RUzYCV4XTv0RGirhdSWKKe2X08a05N-Pke57FquApiWVLN0MCYtVyCQ9V6NJgKFXykiTnj';

    Map<String, dynamic> body = {};
    body['notification'] = {
      'title': notificationTitle,
      'body': notificationBody,
      'sound': 'default'
    };
    body['priority'] = 'high';
    body['data'] = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done'
    };
    body['to'] = targetFCMToken;
    await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body),);

  }


}