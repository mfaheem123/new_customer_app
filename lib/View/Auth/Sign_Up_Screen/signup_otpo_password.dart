import 'package:customer/View/Widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/Auth_Controller/otp_controller.dart';
import '../../../Controller/Auth_Controller/sigup_controller.dart';
import '../../Widgets/elevat_button.dart';
import '../../textstyle/apptextstyle.dart';
import '../../Widgets/color.dart';


class SignupOtpoPassword extends StatelessWidget {


  SignupOtpoPassword({super.key});

  //final OtpController controller = Get.put(OtpController());
  final controller = Get.isRegistered<OtpController>()
      ? Get.find<OtpController>()
      :  Get.put(OtpController ());


  final signupController = Get.isRegistered<SignUp_Controller>()
      ? Get.find<SignUp_Controller>()
      :  Get.put(SignUp_Controller());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: AppColors.primary,
        leading: BackButton(color: Colors.white),
      ),
      body: Container(
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
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Email Verification",
                  style: AppTextStyles.heading()),
              const SizedBox(height: 15),

              Text(
                "OTP sent to ${controller.email}",
                style: AppTextStyles.medium(),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // OTP INPUT
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 60,
                    child: TextField(
                      controller: controller.otpControllers[index],
                      focusNode: controller.focusNodes[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(counterText: ""),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          FocusScope.of(context).requestFocus(
                              controller.focusNodes[index + 1]);
                        }
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              Obx(() => Text(
                "Resend OTP in ${controller.formatTime(controller.remainingSeconds.value)}",
                style: AppTextStyles.medium(color: Colors.black54),
              )),

              const SizedBox(height: 30),

              Obx(() => controller.isOtpExpired.value
                  ? TextButton(
                    child: Text("OTP Expired ❌",
                    style: AppTextStyles.medium(color: Colors.red)),
                onPressed: () {

                },
                  )
                  : SizedBox(
                width: 200,
                height: 50,
                child: MyElevatedButton(
                  text: "Verify",
                  onPressed: (){
                     controller.verifySignUpOtp();
                    },
                ),
              )),

            ],
          ),
        ),
      ),
    );
  }
}
