
import 'package:bot_toast/bot_toast.dart';
import 'package:customer/View/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:dio/dio.dart';
import '../../api_servies/api_servies.dart';
import '../../api_servies/session.dart';

class changePasswordController extends GetxController{

  var isCurrentPasswordVisible = false.obs;
  var isnewPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  final TextEditingController  CurrentpasswordtlController= TextEditingController();
  final TextEditingController  newpasswordController= TextEditingController();
  final TextEditingController  ConfirmpasswordController= TextEditingController();
  final TextEditingController  chnagePhoneNoController= TextEditingController();

  clearField(){
    CurrentpasswordtlController.clear();
    CurrentpasswordtlController.clear();
    ConfirmpasswordController.clear();
  }

/// ====================================================================  change password
  Future<void> changePasswordApi() async {
    if (CurrentpasswordtlController.text.isEmpty ||
        newpasswordController.text.isEmpty || ConfirmpasswordController.text.isEmpty) {
      BotToast.showText(text: "Please fill all fields");
      return;
    }

    if (newpasswordController.text != ConfirmpasswordController.text) {
      BotToast.showText(text: "Passwords do not match");
      return;
    }


var data = FormData.fromMap({
  "current_password": CurrentpasswordtlController.text,
  "password": newpasswordController.text,
  "confirm_password": ConfirmpasswordController.text,
});


    var response = await ApiService.put(
      data,
      "auth/update-password/${TokenManager.userId}",
      auth: true,
    );

    if (response!.statusCode == 200) {
      BotToast.showText(text: "Password Updated Successfully");
      Get.back();   // profile screen pe wapas
      return;
    }

   }

///= ================================================================  change phone number

  Future<void> changeNumberApi() async {

    var data = FormData.fromMap({
      "phone_number": chnagePhoneNoController.text,

    });


    var response = await ApiService.put(
      data,
      "auth/update-phone/${TokenManager.userId}",
      auth: true,
    );

    if (response!.statusCode == 200) {
      BotToast.showText(text: "Phone Number Updated Successfully");
      Get.back(); // profile screen pe wapas
      Get.find<profileModelController>().getuserProfile();
      return;
    }

  }



}