import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../../api_servies/api_servies.dart';


class forgetOtpController extends GetxController {
  final String email = Get.arguments['email'];

  final List<TextEditingController> otpControllers =
  List.generate(4, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
  List.generate(4, (_) => FocusNode());

  Timer? _timer;
  RxInt remainingSeconds = 60.obs;
  RxBool isOtpExpired = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var c in otpControllers) {
      c.dispose();
    }
    super.onClose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        isOtpExpired.value = true;
      }
    });
  }

  String getOtp() {
    return otpControllers.map((e) => e.text).join();
  }

  String formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  Future<void> verifyforgetOtp() async {
    final otp = getOtp();

    if (otp.length != 4) {
      BotToast.showText(text: "Please enter complete OTP");
      return;
    }

    final data = {
      "email": email,
      "otp": otp,
    };

    final response = await ApiService.post(
      data,
      "auth/verify-otp",
      multiPart: false,
      auth: false,
    );



      if (response!.statusCode == 200) {
        BotToast.showText(text: "OTP Verified ✅");
        Get.offAllNamed("/resetPasswordScreen", arguments: email);
        return;
      }

      String error = response.data is Map
          ? response.data['message'] ?? "Invalid OTP "
          : "Invalid OTP ";

      BotToast.showText(text: error);
    }
  }

