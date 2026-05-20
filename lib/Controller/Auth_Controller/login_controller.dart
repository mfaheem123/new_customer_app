import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response, FormData;
import '../../api_servies/api_servies.dart' hide TokenManager;
import '../../api_servies/session.dart';

class LoginController extends GetxController {
    var isPasswordVisible = false.obs;
    final TextEditingController  emailController= TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;


    @override
    void onInit() {
      super.onInit();

      emailController.addListener(() {
        update();
      });

      passwordController.addListener(() {
        update();
      });
    }

  // Future<void> login() async {
  //   isLoading.value = true;
  //
  //   await Future.delayed(Duration(seconds: 2));
  //
  //   isLoading.value = false;
  //   Get.toNamed('/DeshBoard_Screen');
  // }


  void clearFields(){

    emailController.clear();
    passwordController.clear();

  }

    Future<void> userLoginApi() async {

      // 1. FCM Token nikalen
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      debugPrint("Sending FCM Token: $fcmToken");
      
      FormData formData = FormData.fromMap({
        "email": emailController.text,
        "password": passwordController.text,
        "fcm_token": fcmToken,
      });

      var response = await ApiService.post(
        formData,
        "customers/login",
        multiPart: false,
        auth: false,
      );
      if (response!.statusCode == 200) {
        final data = response.data;
   debugPrint("print response with FCM ------: $response");

        /// 🔐 Save token & id in GetStorage
        TokenManager.saveSession(
          token: data['token'],
          userId: data['customer']['id'],   // agar API me user object hai
        );

        BotToast.showText(text: "Login Successful");
        print("========================================================= ===================          ===============            ======== = ${data['customer']['id']}");
        print("========================================================= ===================          ===============            ======== = ${ data['token']}");
        clearFields();
        Get.offAllNamed('/DeshBoard_Screen');
        return;
      }

      // ❌ Error Handling
      String errorMessage = "Login Failed";

      if (response.data is Map) {
        errorMessage = response.data['message']?.toString() ?? errorMessage;
      } else if (response.data is String) {
        errorMessage = response.data.toString();
      }

      BotToast.showText(text: errorMessage);
    }






}