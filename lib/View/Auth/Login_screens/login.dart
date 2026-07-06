import 'package:customer/View/Auth/Sign_Up_Screen/sign_up.dart';
import 'package:customer/View/Widgets/all_text.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/elevat_button.dart';
import 'package:customer/View/Widgets/textformfield.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Controller/Auth_Controller/login_controller.dart';

class SigIn_Screen extends StatefulWidget {
  const SigIn_Screen({super.key});

  @override
  State<SigIn_Screen> createState() => _SigIn_ScreenState();
}

class _SigIn_ScreenState extends State<SigIn_Screen> {

  final loginController = Get.isRegistered<LoginController>()
      ? Get.find<LoginController>()
      : Get.put(LoginController());
  @override
  void initState() {
    super.initState();
    print(GetStorage().read("email") ?? "");
    loginController.emailController.text =
        GetStorage().read("email") ?? "";
  }




  @override
  Widget build(BuildContext context) {


    return GetBuilder<LoginController>(
      builder: (controller) {

        return Scaffold(

          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            padding: const EdgeInsets.symmetric(horizontal: 15),

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 30, 1, 44),
                  Color.fromARGB(255, 227, 194, 242),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),

            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      top: 170.0,
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [

                        Text(
                          CustomText.Login_text,
                          style: AppTextStyles.heading(size: 40),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          CustomText.Login_text_description,
                          style: AppTextStyles.regular(),
                        ),

                        const SizedBox(height: 40),

                        /// ================= EMAIL =================

                        CustomTextField(

                          hintText: CustomText.hint_text_email,

                          FontSize: 14,

                          maxlength: 30,

                          controller: controller.emailController,

                          prefixIcon: Icon(
                            Icons.email,
                            color: CustomColor.textField_Icon_Color,
                          ),

                          borderRadius: 15,

                          suffixIcon:
                          controller.emailController.text.isNotEmpty

                              ? GestureDetector(
                            onTap: () {
                              controller.emailController.clear();
                              controller.update();
                            },

                            child: const Icon(
                              Icons.close,
                              size: 18,
                            ),
                          )

                              : const SizedBox(),
                        ),

                        const SizedBox(height: 25),

                        /// ================= PASSWORD =================

                        CustomTextField(

                          controller: controller.passwordController,

                          obscureText:
                          !controller.isPasswordVisible.value,

                          hintText: CustomText.hint_password,

                          maxlength: 15,

                          FontSize: 14,

                          prefixIcon: const Icon(Icons.lock),

                          borderRadius: 15,

                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,

                            children: [

                              if (controller
                                  .passwordController.text.isNotEmpty)

                                GestureDetector(
                                  onTap: () {
                                    controller.passwordController.clear();
                                    controller.update();
                                  },

                                  child: const Icon(
                                    Icons.close,
                                    size: 18,
                                  ),
                                ),

                              const SizedBox(width: 10),

                              GestureDetector(
                                onTap: () {

                                  controller.isPasswordVisible.value =
                                  !controller.isPasswordVisible.value;

                                  controller.update();
                                },

                                child: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 5),

                        /// ================= FORGOT PASSWORD =================

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [

                            TextButton(
                              onPressed: () {
                                Get.toNamed("/forgotPassword");
                              },

                              child: Text(
                                "Forgot Password",

                                style: AppTextStyles.regular(
                                  color: CustomColor.black,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// ================= LOGIN BUTTON =================

                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(
                              Radius.circular(15),
                            ),

                            color:
                            CustomColor.Button_background_Color,
                          ),

                          height: 55,
                          width: 250,

                          child: controller.isLoading.value

                              ? Center(
                            child: CircularProgressIndicator(
                              color: CustomColor.Icon_Color,
                              strokeWidth: 3,
                            ),
                          )

                              : MyElevatedButton(

                            text: "",

                            textWidget: FittedBox(
                              child: Text(
                                "Log In",

                                style: AppTextStyles.medium(
                                  size: 25,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            ),

                            onPressed: () {
                              controller.userLoginApi();
                            },
                          ),
                        ),

                        const SizedBox(height: 5),

                        /// ================= SIGNUP =================

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [

                            const SizedBox(width: 17),

                            Text(
                              CustomText.Already_Account_Text,
                              style: AppTextStyles.small(),
                            ),

                            TextButton(
                              onPressed: () {
                                Get.off(SigUp_Screen());
                              },

                              child: Text(
                                "Sign Up",

                                style: AppTextStyles.regular(
                                  weight: FontWeight.bold,

                                  color: CustomColor
                                      .Button_background_Color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
