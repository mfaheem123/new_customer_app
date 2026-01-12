import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response, FormData;
import '../../api_servies/api_servies.dart' hide TokenManager;
import '../../api_servies/session.dart';

class LoginController extends GetxController {
    var isPasswordVisible = false.obs;
    final TextEditingController  emailController= TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;

    await Future.delayed(Duration(seconds: 2));

    isLoading.value = false;
    Get.toNamed('/DeshBoard_Screen');
  }
  void clearFields(){

    emailController.clear();
    passwordController.clear();

  }

    Future<void> userLoginApi() async {
      FormData formData = FormData.fromMap({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });

      var response = await ApiService.post(
        formData,
        "auth/login",
        multiPart: false,
        auth: false,
      );

      if (response!.statusCode == 200) {

        final data = response.data;

        /// 🔐 Save token & id in GetStorage
        TokenManager.saveSession(
          token: data['token'],
          userId: data['user']['id'],   // agar API me user object hai
        );

        BotToast.showText(text: "Login Successful");
        print("========================================================= ===================          ===============            ======== = ${data['user']['id']}");
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




///////////////////////////////////////////////////////////////// ===========================
//
// Future<void> userLoginApi() async {
//
//   // Step 1: Create FormData
//   // Step 1: Create FormData correctly
//   // final formData = FormData();
//   // formData.fields.addAll([
//   //   MapEntry("email", emailController.text),
//   //   MapEntry("password", passwordController.text),
//   // ]);
//
//   FormData formData = FormData.fromMap({
//     "email": emailController.text,
//     "password": passwordController.text,
//   });
//
//
//   var response = await ApiService.post(
//     formData,
//     "auth/login",      // LOGIN ENDPOINT
//     multiPart: false,
//     auth: false,
//   );
//
//
//
//   // SUCCESS
//   if (response!.statusCode == 200) {
//     BotToast.showText(text: "Login Successfully ");
//     clearFields();
//     Get.offAllNamed('/DeshBoard_Screen');
//     print("LOGIN SUCCESS => ${response.data}");
//
//
//     return;
//       }
//
//       // ERROR HANDLING
//       String errorMessage = "Login Failed ";
//
//       if (response.data is Map) {
//         errorMessage = response.data['message']?.toString() ?? errorMessage;
//       } else if (response.data is String) {
//         errorMessage = response.data.toString();
//       }
//
//       BotToast.showText(text: errorMessage);
//       print("LOGIN FAILED => ${response.data}");
//     }

}