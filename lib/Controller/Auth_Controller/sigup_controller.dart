import 'package:bot_toast/bot_toast.dart';
import 'package:customer/api_servies/api_servies.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, Response;

class SignUp_Controller extends GetxController {
  var isPasswordVisible = false.obs;



  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    firstNameController.addListener(() => update());
    lastNameController.addListener(() => update());
    emailController.addListener(() => update());
    phoneNoController.addListener(() => update());
    passwordController.addListener(() => update());
  }


  RxBool isCheckedBox = false.obs;

  void checked_box(bool? value) {
    isCheckedBox.value = value ?? false;
  }


  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void clearFields(){

    lastNameController.clear();
    firstNameController.clear();
    emailController.clear();
    phoneNoController.clear();
    passwordController.clear();

  }



  /// ===================================================================================== >>> Validation


  bool isValidEmail(String email) {
    return GetUtils.isEmail(email);
  }

  // Password Validation
  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  // Name Validation
  bool isValidName(String name) {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(name.trim());
  }

  // Number Validation (Pakistani number example)
  bool isValidNumber(String number) {
    return GetUtils.isPhoneNumber(number);
  }
  bool validateRegisterForm() {
    if (!isValidName(firstNameController.text)) {
      BotToast.showText(text: "First name is required");
      return false;
    }

    if (!isValidName(lastNameController.text)) {
      BotToast.showText(text: "Last name is required");
      return false;
    }

    if (!isValidEmail(emailController.text)) {
      BotToast.showText(text: "Please enter a valid email");
      return false;
    }

    if (!isValidNumber(phoneNoController.text)) {
      BotToast.showText(text: "Please enter a valid phone number");
      return false;
    }

    if (!isValidPassword(passwordController.text)) {
      BotToast.showText(text: "Password must be at least 6 characters");
      return false;
    }

    return true; // ✅ all good
  }



  Future<void> registerUser() async {
    // Validation
    if (!validateRegisterForm()) {
      return;
    }

    FormData formData = FormData.fromMap({
      "sms_flag": true,
      "name": "${firstNameController.text} ${lastNameController.text}",
      "mobile": phoneNoController.text,
      "telephone": phoneNoController.text,
      "email": emailController.text,
      "blacklist": false,
      "password": passwordController.text,
    });

    try {
      Response? response = await ApiService.post(
        formData,
        "customers/add",
        multiPart: true,
        auth: false,
      );

      if (response == null) {
        BotToast.showText(text: "Server not responding");
        return;
      }

      // Success
      if (response.statusCode == 200) {
        BotToast.showText(
          text: response.data["message"] ?? "Registered Successfully ✅",
        );

        Get.toNamed(
          "/SignupOtpoPassword",
          arguments: {
            "email": emailController.text,
          },
        );

        print("Success Response: ${response.data}");
        return;
      }

      // Error Response
      String errorMessage = "Something went wrong";

      if (response.data != null) {
        if (response.data is Map<String, dynamic>) {
          if (response.data["message"] != null) {
            errorMessage = response.data["message"].toString();
          } else if (response.data["error"] != null) {
            errorMessage = response.data["error"].toString();
          } else if (response.data["errors"] != null) {
            final errors = response.data["errors"];

            if (errors is Map && errors.isNotEmpty) {
              final firstError = errors.values.first;

              if (firstError is List && firstError.isNotEmpty) {
                errorMessage = firstError.first.toString();
              } else {
                errorMessage = firstError.toString();
              }
            }
          }
        } else {
          errorMessage = response.data.toString();
        }
      }

      BotToast.showText(text: errorMessage);

      print("Status Code: ${response.statusCode}");
      print("Error Response: ${response.data}");
    } catch (e) {
      BotToast.showText(text: e.toString());
      print("Register Exception: $e");
    }
  }

  // Future<void> registerUser() async {
  //
  //   // VALIDATION FIRST
  //   if (!validateRegisterForm()) {
  //      return; // agar validation fail ho jaye
  //   }
  //
  //   FormData formData = FormData.fromMap({
  //     "sms_flag": true,
  //     "name":"${firstNameController.text} ${lastNameController.text}",
  //     "mobile": phoneNoController.text,
  //     "email": emailController.text,
  //   "telephone":phoneNoController.text,
  //     //door_number:123
  //     //address1:test
  //     //address2:test
  //     //notes:test
  //   "blacklist":false,
  //   "password":passwordController.text,
  //
  //
  //     // "first_name": firstNameController.text,
  //     // "last_name": lastNameController.text,
  //     // "email": emailController.text,
  //     // "phone_number": phoneNoController.text,
  //     // "password": passwordController.text,
  //   });
  //
  //   Response? response = await ApiService.post(
  //     formData,
  //     "customers/add",
  //     multiPart: true,
  //     auth: false,
  //   );
  //
  //
  //   // if (response == null) {
  //   //   BotToast.showText(text: "Server not responding ❌");
  //   //   return;
  //   // }
  //   // SUCCESS
  //   if (response!.statusCode == 200 ) {
  //     BotToast.showText(text: "Registered Successfully ✅");
  //     Get.toNamed("/SignupOtpoPassword",
  //       arguments: {
  //         "email": emailController.text,
  //       },
  //     );
  //     //clearFields();
  //     print("====================================================== ............. >>>>>>>>>>>>>>>>>>>>>>    ${response.data}");
  //     return;
  //   }
  //
  //
  // }









}

