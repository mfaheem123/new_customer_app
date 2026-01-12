// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/Auth_Controller/forget_password_controller/forget_password controller.dart';
import '../../Widgets/color.dart';
import '../../Widgets/elevat_button.dart';
import '../../Widgets/textformfield.dart';
import '../../textstyle/apptextstyle.dart';

class forgotPassword extends StatelessWidget {
  forgotPassword({super.key});

  final ForgotPasswordController controller =
  Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60.0),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 10),
                Center(
                  child: Text(
                    "Forgot Password",
                    style: AppTextStyles.heading(),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: CustomTextField(
                    controller: controller.emailController,
                    hintText: "Enter your email",
                    borderRadius: 15,
                  ),
                ),
                SizedBox(height: screenHeight / 35),
                SizedBox(
                  height: 55,
                  width: 250,
                  child: MyElevatedButton(
                    text: '',
                    textWidget: FittedBox(
                      child: Text(
                        "Submit",
                        style: AppTextStyles.medium(
                            size: 25, weight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                      controller.submitEmail();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    Text(
                      "Have an account? ",
                      style: AppTextStyles.small(),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed("/SigUp_Screen");
                      },
                      child: Text(
                        "Sign Up",
                        style: AppTextStyles.medium(
                          weight: FontWeight.bold,
                          color: CustomColor.Button_background_Color,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}






















////ignore_for_file: camel_case_types
//
// import 'package:customer/View/Widgets/color.dart';
// import 'package:customer/View/Widgets/elevat_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Widgets/textformfield.dart';
// import '../../textstyle/apptextstyle.dart';
//
//
//
// class forgotPassword extends StatefulWidget {
//   const forgotPassword({super.key});
//
//   @override
//   State<forgotPassword> createState() => _forgotPasswordState();
// }
// final TextEditingController email = TextEditingController();
//
// class _forgotPasswordState extends State<forgotPassword> {
//  // bool isLoading = false;
//   // SubmitEmail() async {
//   //   String emailText = email.text.trim();
//   //
//   //   // Simple email regex
//   //   bool isValidEmail(String email) {
//   //     return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
//   //   }
//   //
//   //   if (emailText.isEmpty) {
//   //     Fluttertoast.showToast(
//   //         msg: "Please enter email",
//   //         backgroundColor: Colors.red,
//   //         textColor: Colors.white);
//   //
//   //     return;
//   //   }
//   //
//   //   if (!isValidEmail(emailText)) {
//   //     Fluttertoast.showToast(
//   //         msg: "Enter a valid email address.",
//   //         backgroundColor: Colors.red,
//   //         textColor: Colors.white);
//   //     return;
//   //   }
//   //
//   //   if (mounted) {
//   //     setState(() {
//   //       isLoading = true;
//   //     });
//   //   }
//   //   var url =
//   //       'https://nexustechnologys.com:4000/api/customerRegisteration/forgotPassword';
//   //
//   //   Map<String, dynamic> data = {
//   //     "emailaddress": emailText,
//   //   };
//   //
//   //   try {
//   //     var response = await http.post(Uri.parse(url),
//   //         headers: {'Content-Type': 'application/json'},
//   //         body: jsonEncode(data));
//   //     var jsonData = json.decode(response.body);
//   //     print("JSON Data::::::::::::: $jsonData");
//   //     if (response.statusCode == 200) {
//   //       email.clear(); // clear the field
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => ForgotOTPScreen(email: emailText),
//   //         ),
//   //       );
//   //     } else {
//   //       Fluttertoast.showToast(
//   //           msg: "User Not Found",
//   //           backgroundColor: Colors.red,
//   //           textColor: Colors.white);
//   //       // ScaffoldMessenger.of(context).showSnackBar(
//   //       //   SnackBar(content: Text("Error: ${jsonData['message'] ?? 'Failed to send OTP'}")),
//   //       // );
//   //     }
//   //   } catch (e) {
//   //     Fluttertoast.showToast(
//   //         msg: "User Not Found",
//   //         backgroundColor: Colors.red,
//   //         textColor: Colors.white);
//   //     // ScaffoldMessenger.of(context).showSnackBar(
//   //     //   const SnackBar(content: Text("Something went wrong")),
//   //     // );
//   //   } finally {
//   //     if (mounted) {
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     }
//   //   }
//   // }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery
//         .of(context)
//         .size
//         .width;
//     final screenHeight = MediaQuery
//         .of(context)
//         .size
//         .height;
//     return Scaffold(
//         body: Container(
//             height: screenHeight,
//             width: screenWidth,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 30, 1, 44),
//                   Color.fromARGB(255, 227, 194, 242),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(height: 60.0),
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: (){
//                               Get.back();
//
//                             },
//                             child: Icon(Icons.arrow_back,
//                               color: Colors.white,
//                             ),
//                           ),
//
//                         ],
//                       ),
//                       SizedBox(height: screenHeight/10,),
//                       Center(
//                         child:  Text(
//                           "Forgot Password",
//                           style: AppTextStyles.heading(),
//                         ),
//                       ),
//                       SizedBox(height: 20,),
//                       Container(
//                         margin: const EdgeInsets.all(12),
//                         child: CustomTextField(
//                           hintText: "Enter your email",
//                           borderRadius: 15,
//                         ),
//                       ),
//
//                       // Padding(
//                       //   padding: const EdgeInsets.symmetric(horizontal: 20),
//                       //   child: TextField(
//                       //     controller: email,
//                       //     decoration: InputDecoration(
//                       //         hintText: "Enter Email",
//                       //         border: OutlineInputBorder(
//                       //             borderRadius: BorderRadius.circular(18),
//                       //             borderSide: BorderSide.none
//                       //         ),
//                       //         fillColor: Colors.white.withOpacity(0.3),
//                       //         filled: true,
//                       //         prefixIcon: const Icon(Icons.email)),
//                       //   ),
//                       // ),
//                       SizedBox(height: screenHeight/35,),
//
//                       SizedBox(
//                         height: 55,
//                         width: 250,
//                         child: MyElevatedButton(
//                           text: '',
//                           textWidget: FittedBox(
//                             child: Text("Submit",
//                               style: AppTextStyles.medium(size: 25,weight: FontWeight.bold),),
//                           ),
//                           fontSize: 18,
//                           onPressed: () {
//
//                            // Get.toNamed("/forgotOTPScreen");
//                            //  Get.to(forgotOTPScreen("abc@gmail.com"))
//
//                           },
//                         ),
//                       ),
//
//
//
//
//                       // GestureDetector(
//                       //   onTap: (){
//                       //     // SubmitEmail();
//                       //   },
//                       //   child: Container(
//                       //     height: screenHeight/14,
//                       //     width: screenWidth/1.5,
//                       //     decoration: BoxDecoration(
//                       //         borderRadius: BorderRadius.circular(10),
//                       //         color: Color.fromARGB(255, 106, 24, 130)
//                       //     ),
//                       //     child: Center(
//                       //       child: Text("Submit",
//                       //         style: TextStyle(
//                       //             color: Colors.white,
//                       //             fontWeight: FontWeight.bold,
//                       //             fontSize: 19
//                       //         ),
//                       //
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(width: 8,),
//                            Text("Have an account? ",
//                             style: AppTextStyles.small(
//                             ),),
//                           TextButton(
//
//                               onPressed: () {
//                                 Get.toNamed("/SigUp_Screen");
//                                 // Navigator.pushReplacement(
//                                 //     context,
//                                 //     MaterialPageRoute(
//                                 //         builder: (context) =>
//                                 //         const RegisterScreen()));
//                                 // setState(() {
//                                 //   _registerTextColor = Colors.lime;
//                                 // });
//                               },
//                               child:  Text("Sign Up", style: AppTextStyles.medium(
//                                 weight: FontWeight.bold,color: CustomColor.Button_background_Color
//                               ),)
//                           )
//                         ],
//                       )
//
//                     ],
//
//                   )
//               ),
//             )
//         )
//     );
//   }
//
//
// }
