import 'package:customer/View/Widgets/textformfield.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../Controller/Auth_Controller/forget_password_controller/forget_password controller.dart';
import '../../Widgets/all_text.dart';
import '../../Widgets/elevat_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 30, 1, 44), Color.fromARGB(255, 227, 194, 242)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: 0),
                Text("Reset Password", style: AppTextStyles.heading()),
                SizedBox(height: 50),

                /// Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
                        ()=> CustomTextField(

                      suffixIcon: GestureDetector(

                          onTap: (){
                            controller.isPasswordVisible.value = !controller.isPasswordVisible.value;
                          },
                          child: Icon(controller.isPasswordVisible.value ?Icons.remove_red_eye:Icons.visibility_off)
                      ),
                      controller: controller.passwordController,
                      obscureText: !controller.isPasswordVisible.value,
                      hintText: CustomText.hint_password,
                      prefixIcon: const Icon(Icons.lock),
                      borderRadius: 15,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Obx(() => CustomTextField(
                //     controller: controller.passwordController,
                //     obscureText: !controller.isPasswordVisible.value,
                //     hintText: CustomText.hint_password,
                //     prefixIcon: const Icon(Icons.lock),
                //     suffixIcon: GestureDetector(
                //       onTap: () => controller.isPasswordVisible.toggle(),
                //       child: Icon(controller.isPasswordVisible.value
                //           ? Icons.remove_red_eye
                //           : Icons.visibility_off),
                //     ),
                //     FontSize: 14,
                //     borderRadius: 15,
                //   )),
                // ),

                SizedBox(height: screenHeight / 45),

                /// Confirm Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
                        ()=> CustomTextField(

                      suffixIcon: GestureDetector(

                          onTap: (){
                            controller.isConfirmPasswordVisible.value = !controller.isConfirmPasswordVisible.value;
                          },
                          child: Icon(controller.isConfirmPasswordVisible.value ?Icons.remove_red_eye:Icons.visibility_off)
                      ),
                      controller: controller.confirmPasswordController,
                      obscureText: !controller.isConfirmPasswordVisible.value,
                      hintText: CustomText.hint_password,


                      prefixIcon: const Icon(Icons.lock),
                      borderRadius: 15,
                    ),
                  ),
                ),
                ///

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Obx(() => CustomTextField(
                //     controller: controller.confirmPasswordController,
                //     obscureText: !controller.isConfirmPasswordVisible.value,
                //     hintText: "Confirm Password",
                //     prefixIcon: const Icon(Icons.lock),
                //     suffixIcon: GestureDetector(
                //       onTap: () => controller.isConfirmPasswordVisible.toggle(),
                //       child: Icon(controller.isConfirmPasswordVisible.value
                //           ? Icons.remove_red_eye
                //           : Icons.visibility_off),
                //     ),
                //     FontSize: 14,
                //     borderRadius: 15,
                //   )),
                // ),

                SizedBox(height: screenHeight / 35),

                SizedBox(
                  height: 55,
                  width: 250,
                  child: MyElevatedButton(
                    text: "",
                    textWidget: Text("Submit",
                        style: AppTextStyles.medium(size: 22, weight: FontWeight.bold)),
                    onPressed:(){
                      controller.submitResetPassword();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
