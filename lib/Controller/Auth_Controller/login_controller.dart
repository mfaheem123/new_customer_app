import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:get_storage/get_storage.dart';
import '../../View/Widgets/color.dart';
import '../../View/textstyle/apptextstyle.dart';
import '../../api_servies/api_servies.dart' hide TokenManager;
import '../../api_servies/session.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  final TextEditingController emailController = TextEditingController();
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

  void clearFields() {
    //emailController.clear();
    passwordController.clear();
  }

  // Future<bool> checkLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // GPS ON hai?
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //
  //   if (!serviceEnabled) {
  //     BotToast.showText(
  //       text: "Please enable Location Service",
  //     );
  //
  //     await Geolocator.openLocationSettings();
  //     return false;
  //   }
  //
  //   // Permission check
  //   permission = await Geolocator.checkPermission();
  //
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //
  //     if (permission == LocationPermission.denied) {
  //       BotToast.showText(
  //         text: "Location permission is required",
  //       );
  //       return false;
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     BotToast.showText(
  //       text: "Location permission permanently denied",
  //     );
  //
  //     await Geolocator.openAppSettings();
  //     return false;
  //   }
  //
  //   return true;
  // }

  Future<bool> checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Get.dialog(
        Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: CustomColor.Container_Colors,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Location Icon
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 35,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  "Enable Location",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading(),
                ),
                SizedBox(height: 15),

                Text(
                  "Location access is required to continue using the app. Please enable your location services and grant permission to proceed.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular(),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.Button_background_Color,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      if (Get.context != null) Navigator.of(Get.context!).pop();
                      await Geolocator.openLocationSettings();
                    },
                    child: const Text(
                      "Grant Permission",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();



    if (permission == LocationPermission.deniedForever|| permission == LocationPermission.denied) {
      await Get.dialog(
        Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: CustomColor.Container_Colors,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Location Icon
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_off,
                    color: Colors.white,
                    size: 35,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  "Permission Required",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading(),
                ),

                const SizedBox(height: 15),

                Text(
                  "Location permission has been permanently denied. Please open App Settings and allow location permission to continue using the app.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular(),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.Button_background_Color,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      if (Get.context != null) Navigator.of(Get.context!).pop();
                      await Geolocator.openAppSettings();
                    },
                    child: const Text(
                      "Open Settings",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      return false;
    }

    return true;
  }

  Future<void> userLoginApi() async {
    // Email Validation
    if (emailController.text.trim().isEmpty && passwordController.text.trim().isEmpty) {
      BotToast.showText(text: "Email Password are  required");
      return;
    }

    // Email Format Validation
    if (!GetUtils.isEmail(emailController.text.trim())) {
      BotToast.showText(text: "Please enter a valid email");
      return;
    }

    // Password Validation
    if (passwordController.text.trim().isEmpty) {
      BotToast.showText(text: "Password is required");
      return;
    }

    bool hasPermission = await checkLocationPermission();

    if (!hasPermission) {
      return;
    }

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

      final _box = GetStorage();
      _box.write("email", emailController.text );
      print("Stored Email: ${_box.read("email")}");

      /// 🔐 Save token & id in GetStorage
      TokenManager.saveSession(
        token: data['token'],
        userId: data['customer']['id'], // agar API me user object hai
      );

      BotToast.showText(text: "Login Successful");
      print(
        "========================================================= ===================          ===============            ======== = ${data['customer']['id']}",
      );
      print(
        "========================================================= ===================          ===============            ======== = ${data['token']}",
      );
      clearFields();
      Get.offAllNamed('/DeshBoard_Screen');
      return;
    }

    // ❌ Error Handling
    String errorMessage = "login failed";

    if (response.data is Map) {
      errorMessage = response.data['message']?.toString() ?? errorMessage;
    } else if (response.data is String) {
      errorMessage = response.data.toString();
    }

    BotToast.showText(text: errorMessage);
  }
}
