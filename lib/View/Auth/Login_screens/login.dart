import 'package:customer/View/Auth/Sign_Up_Screen/sign_up.dart';
import 'package:customer/View/Deshboard/dashboard.dart';
import 'package:customer/View/Widgets/all_text.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/elevat_button.dart';
import 'package:customer/View/Widgets/textformfield.dart';
import 'package:customer/View/Widgets/textstyle.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Controller/Auth_Controller/login_controller.dart';

class SigIn_Screen extends StatefulWidget {
  const SigIn_Screen({super.key});

  @override
  State<SigIn_Screen> createState() => _SigIn_ScreenState();
}

class _SigIn_ScreenState extends State<SigIn_Screen> {
  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final loginController = Get.put(LoginController());

    return Scaffold(
      //backgroundColor: CustomColor.background,
      body: Container(
        height:MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 30, 1, 44),
              Color.fromARGB(255, 227, 194, 242)
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

                    Text( CustomText.Login_text,style: AppTextStyles.heading(size:40),),
                    //fontSize: 40
                    SizedBox(height: 5),
                    Text(
                    CustomText.Login_text_description,
                      style: AppTextStyles.regular(),
                    ),
                    SizedBox(height: 40),

                    CustomTextField(
                      hintText: CustomText.hint_text_email,
                      FontSize: 14,
                      maxlength: 30,
                      controller: loginController.emailController,

                      prefixIcon: Icon(
                          Icons.email,
                          color: CustomColor.textField_Icon_Color
                      ),
                     borderRadius: 15,
                    ),

                    SizedBox(height: 25),

                    // ==================================================== password text field

                    Obx(
                        ()=> CustomTextField(

                        suffixIcon: GestureDetector(

                            onTap: (){
                              loginController.isPasswordVisible.value = !loginController.isPasswordVisible.value;
                            },
                            child: Icon(loginController.isPasswordVisible.value ?Icons.remove_red_eye:Icons.visibility_off)
                        ),
                        controller: loginController.passwordController,
                        obscureText: !loginController.isPasswordVisible.value,
                        hintText: CustomText.hint_password,
                        FontSize: 14,

                        prefixIcon: const Icon(Icons.lock),
                        borderRadius: 15,
                      ),
                    ),


                    // CustomTextField(
                    //   suffixIcon: IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.remove_red_eye,
                    //       color: CustomColor.textField_Icon_Color,
                    //     ),
                    //   ),
                    //   hintText: CustomText.hint_password,
                    //   FontSize: 14,
                    //   prefixIcon: Icon(
                    //     Icons.password,
                    //    color: CustomColor.textField_Icon_Color,
                    //   ),
                    //   borderRadius: 15,
                    //   /////////////////////////////////////////////////////////////////////////////////////
                    //  // fillColor: CustomColor.textfield_fill,
                    // ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.toNamed("/forgotPassword");
                          },
                          child: Text("Forget Password"
                            ,style: AppTextStyles.regular(
                            color: CustomColor.black,
                            //color:CustomColor.Button_background_Color,
                          ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                   Obx((){
                     return Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(15)
                         ),
                         color: CustomColor.Button_background_Color
                       ),
                       height: 55,
                       width: 250,
                       child: loginController.isLoading.value
                           ?Center(
                         child: CircularProgressIndicator(
                           color:CustomColor.Icon_Color ,
                           strokeWidth: 3,
                         ),
                       )
                           : MyElevatedButton(
                         text: "",
                         textWidget: FittedBox(
                           child: Text("Log In",style: AppTextStyles.medium(size: 25,weight: FontWeight.bold),),
                         ),

                         onPressed: () {

                          loginController.userLoginApi();

                           // loginController.login();
                           // loginController.clearFields();

                          // Get.toNamed('/DeshBoard_Screen');
                         },

                       ),
                     );
                   }),

                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       SizedBox(width:17,),
                        Text(
                           CustomText.Already_Account_Text,style: AppTextStyles.small(),

                        ),
                        TextButton(
                          onPressed: () {
                            Get.off(SigUp_Screen());
                          },
                          child: Text(
                            "Sign Up",
                            style: AppTextStyles.regular(
                              weight: FontWeight.bold,
                              color:CustomColor.Button_background_Color,
                              //color: CustomColor.Text_Color
                             // Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // SizedBox(height:MediaQuery.of(context).size.height*0.12 ,),
              // Container(
              //   margin: EdgeInsets.only(right: 100),
              //   height: 350,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(image: AssetImage( "assets/images/car_login.png"),fit: BoxFit.contain)
              //   ),
              //
              // )
              //


            ],
          ),
        ),
      ),
    );
  }
}
