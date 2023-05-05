import 'package:email_auth/email_auth.dart';
import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EmailAuthController extends GetxController{
  EmailAuth emailAuth = EmailAuth(sessionName: "Foodie session");

  var status = "".obs;

  Future<void> sendOTP(String email) async{
    var res = await emailAuth.sendOtp(recipientMail: email, otpLength: 4);
    if(res){
      status.value = "OTP Sent";
    }
    else{
      status.value = "OTP Sending Failed";
    }
  }

  void validateOTP(String email, String otp){
    var res = emailAuth.validateOtp(recipientMail: email, userOtp: otp);
    if(res){
      status.value = "OTP Verified Successfully";
    }
    else{
      status.value = "Wrong OTP";
    }
  }
}