import 'package:bot_toast/bot_toast.dart';
import 'package:customer/Controller/Auth_Controller/sigup_controller.dart';
import 'package:customer/View/Auth/Login_screens/login.dart';
import 'package:customer/View/Auth/trems.dart';
import 'package:customer/View/Widgets/all_text.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/elevat_button.dart';
import 'package:customer/View/Widgets/phone_number_textfield.dart';
import 'package:customer/View/Widgets/textformfield.dart';
import 'package:customer/View/Widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../Binding/auth_binding.dart';
import '../../textstyle/apptextstyle.dart';

class SigUp_Screen extends StatefulWidget {
  const SigUp_Screen({super.key});

  @override
  State<SigUp_Screen> createState() => _SigUp_ScreenState();
}

class _SigUp_ScreenState extends State<SigUp_Screen> {

  final signupController = Get.isRegistered<SignUp_Controller>()
      ? Get.find<SignUp_Controller>()
      : Get.put(SignUp_Controller());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUp_Controller>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: CustomColor.background,
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
                      left: 15.0,
                      right: 15.0,
                      top: 100.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Text(
                          CustomText.Sig_up,
                          style: AppTextStyles.heading(size: 40),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          CustomText.Sigup_Description_text,
                          style: AppTextStyles.medium(),
                        ),

                        const SizedBox(height: 40),

                        /// ================= FIRST NAME =================

                        CustomTextField(
                          controller: controller.firstNameController,
                          FontSize: 14,
                          maxlength: 20,
                          hintText: CustomText.hint_text_first_Name,
                          prefixIcon: Icon(
                            Icons.person,
                            color: CustomColor.textField_Icon_Color,
                          ),
                          borderRadius: 15,

                          suffixIcon:
                          controller.firstNameController.text.isNotEmpty
                              ? GestureDetector(
                            onTap: () {
                              controller.firstNameController.clear();
                              controller.update();
                            },
                            child: const Icon(Icons.close, size: 18),
                          )
                              : const SizedBox(),
                        ),

                        const SizedBox(height: 25),

                        /// ================= LAST NAME =================

                        CustomTextField(
                          controller: controller.lastNameController,
                          FontSize: 14,
                          maxlength: 20,
                          hintText: CustomText.hint_text_last_Name,
                          prefixIcon: Icon(
                            Icons.person,
                            color: CustomColor.textField_Icon_Color,
                          ),
                          borderRadius: 15,

                          suffixIcon:
                          controller.lastNameController.text.isNotEmpty
                              ? GestureDetector(
                            onTap: () {
                              controller.lastNameController.clear();
                              controller.update();
                            },
                            child: const Icon(Icons.close, size: 18),
                          )
                              : const SizedBox(),
                        ),

                        const SizedBox(height: 25),

                        /// ================= EMAIL =================

                        CustomTextField(
                          hintText: CustomText.hint_text_email,
                          controller: controller.emailController,
                          FontSize: 14,
                          maxlength: 30,

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
                            child: const Icon(Icons.close, size: 18),
                          )
                              : const SizedBox(),
                        ),

                        const SizedBox(height: 25),

                        /// ================= PHONE =================

                        SizedBox(
                          height: 70,
                          child: PhoneNumber_TextField(
                            hintText: CustomText.hint_text_phone_number,
                            controller: controller.phoneNoController,
                          ),
                        ),

                        const SizedBox(height: 25),

                        /// ================= PASSWORD =================

                        CustomTextField(
                          maxlength: 15,

                          controller: controller.passwordController,

                          obscureText:
                          !controller.isPasswordVisible.value,

                          hintText: CustomText.hint_password,

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
                                  controller.togglePasswordVisibility();
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

                        const SizedBox(height: 8),

                        /// ================= TERMS =================

                        Row(
                          children: [

                            Checkbox(
                              value: controller.isCheckedBox.value,

                              onChanged: (value) {
                                controller.checked_box(value);
                                controller.update();
                              },

                              activeColor:
                              CustomColor.textField_Icon_Color,
                            ),

                            Text(
                              "${CustomText.SigUp_Trems_Text} ",
                              style: AppTextStyles.small(),
                            ),

                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                      TermsAndConditionsScreen());
                                },

                                child: Text(
                                  CustomText
                                      .SigUp_TremsAndCondition,

                                  maxLines: 2,

                                  overflow:
                                  TextOverflow.ellipsis,

                                  style: AppTextStyles.small(
                                    color: CustomColor.trems,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// ================= BUTTON =================

                  const SizedBox(height: 10),

                  Center(
                    child: SizedBox(
                      height: 55,
                      width: 250,

                      child: MyElevatedButton(

                        text: "Sign Up",

                        textWidget: FittedBox(
                          child: Text(
                            "Sign Up",

                            style: AppTextStyles.medium(
                              size: 25,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),

                        onPressed:
                        controller.isCheckedBox.value
                            ? () {
                          controller.registerUser();
                        }
                            : () {
                          BotToast.showText(
                            text:
                            "Please accept Terms & Conditions",
                          );
                        },
                      ),
                    ),
                  ),

                  /// ================= LOGIN =================

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const SizedBox(width: 5),

                      Text(
                        CustomText.Already_Account_Text,
                        style: AppTextStyles.small(),
                      ),

                      TextButton(
                        onPressed: () {
                          Get.toNamed('/SigIn_Screen');
                        },

                        child: Text(
                          "Log In",

                          style: AppTextStyles.regular(
                            weight: FontWeight.bold,
                            color:
                            CustomColor.Button_background_Color,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 150 ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}






