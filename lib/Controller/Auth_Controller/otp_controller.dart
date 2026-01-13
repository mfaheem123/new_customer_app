import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../api_servies/api_servies.dart';

class OtpController extends GetxController {
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
    _timer?.cancel(); // prevent multi timers
    remainingSeconds.value = 30;
    isOtpExpired.value = false;

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
  void handleOtpChange(String value, int index, BuildContext context) {

    // PASTE SUPPORT
    if (value.length > 1) {
      for (int i = 0; i < value.length && i < otpControllers.length; i++) {
        otpControllers[i].text = value[i];
      }
      FocusScope.of(context).unfocus();
      return;
    }

    // NORMAL TYPE → MOVE NEXT
    if (value.isNotEmpty && index < otpControllers.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      return;
    }

    // BACKSPACE → MOVE PREVIOUS (DON'T CLEAR IT)
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }



  String formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }
///=============================================================================  verify otp
  Future<void> verifySignUpOtp() async {
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
        Get.offAllNamed("/SigIn_Screen");
        return;
      }

      String error = response.data is Map
          ? response.data['message'] ?? "Invalid OTP "
          : "Invalid OTP ";

      BotToast.showText(text: error);
    }


    ///-====================================================================  resend otp

  Future<void> resendOtp() async {

    remainingSeconds.value = 60;
    isOtpExpired.value = false ;

    final data = {
      "email": email,
    };

    final response = await ApiService.post(
      data,
      "auth/resend-otp",   // <-- Backend ka resend OTP route
      multiPart: false,
      auth: false,
    );

    if (response!.statusCode == 200) {

      for (var c in otpControllers) {
        c.clear();
      }

      BotToast.showText(text: "New OTP Sent 📩");
      startTimer();
      return;
    }

    String error = response.data is Map
        ? response.data['message'] ?? "OTP resend failed"
        : "OTP resend failed";

    BotToast.showText(text: error);
  }



}

