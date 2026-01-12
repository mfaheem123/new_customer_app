import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:dio/dio.dart';

import '../../../api_servies/api_servies.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();




  // Email validation
  // bool isValidEmail(String email) {
  //   return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  // }


  Future<void> submitEmail() async {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter email",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // ✅ Latest Dio FormData
      FormData formData = FormData.fromMap({
        "email": emailController.text,
      });

      final response = await ApiService.post(
        formData,                  // 👈 FormData
        "auth/forgot-password",    // 👈 API endpoint
        multiPart: true,           // 👈 FormData ke liye true
        auth: false,
      );

      if (response!.statusCode == 200) {
        BotToast.showText(text: "OTP sent successfully ✅");

        Get.toNamed(
          "/ForgetPasswordOtp",
          arguments: {
            "email": emailController.text,
          },
        );

        //emailController.clear();
        return;
      }

      // ❌ Error handling
      String error = response.data is Map
          ? response.data['message'] ?? "User not found"
          : "User not found";

      Get.snackbar(
        "Error",
        error,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


///=======================================================================================   reset password


  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final String? email = Get.arguments;
  // bool isValidPassword(String password) {
  //   final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
  //   return regex.hasMatch(password);
  // }


  void submitResetPassword() async{

    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      BotToast.showText(text: "Please fill all fields");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      BotToast.showText(text: "Passwords do not match");
      return;
    }

    // ✅ Password match ho gaya
    print("============================= ========================== password sahi sahi  ======================= ======================= ========  ");
    BotToast.showText(text: "Password has been submitted successfully");

    // 👉 API CALL YAHAN LAGAO

    try {
      FormData formData = FormData.fromMap({
        "email": email,
        "password": passwordController.text,
        "confirm_password":confirmPasswordController.text,

      });

      final response = await ApiService.post(
        formData,
        "auth/reset-password",
        multiPart: false,
        auth: false,
      );

      BotToast.closeAllLoading();

      if (response!.statusCode == 200) {
        BotToast.showText(text: "Password reset successfully");
        Get.offAllNamed("/SigIn_Screen");
      } else {
        BotToast.showText(text: "Reset failed");
      }

    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: "Server error");
    }
    // Get.offAllNamed("/SigIn_Screen");
  }



  }
