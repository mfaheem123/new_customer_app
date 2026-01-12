import 'package:customer/View/Widgets/all_text.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/elevat_button.dart';
import 'package:customer/View/Widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/change_password_number/change_password_controller.dart';
import '../textstyle/apptextstyle.dart';


class Changepassword extends StatefulWidget {
   Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final chnagePassController = Get.put(changePasswordController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: CustomColor.background,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height:MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
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
            child  : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //padding: const EdgeInsets.all(15.0),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back, color: CustomColor.Icon_Color,size: 30,),
                  ),

                ),
                SizedBox(height: 150,),
                Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Obx(
                        ()=> CustomTextField(

                        suffixIcon: GestureDetector(

                            onTap: (){
                              chnagePassController.isCurrentPasswordVisible.value =
                              !chnagePassController.isCurrentPasswordVisible.value;

                            },
                            child: Icon(chnagePassController.isCurrentPasswordVisible.value ?Icons.remove_red_eye:Icons.visibility_off)
                        ),
                        controller: chnagePassController.CurrentpasswordtlController,
                        obscureText: !chnagePassController.isCurrentPasswordVisible.value,
                        hintText: CustomText.Chng_Curr_pass,
                        FontSize: 14,

                        prefixIcon: const Icon(Icons.lock),
                        borderRadius: 15,
                      ),
                    ),


                    // CustomTextField(
                    //   suffixIcon: IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(Icons.remove_red_eye, color: CustomColor.textColor),
                    //   ),
                    //   hintText: CustomText.Chng_Curr_pass,
                    //   FontSize: 14,
                    //   prefixIcon: Icon(Icons.lock, color: CustomColor.textColor),
                    //   borderRadius: 15,
                    //   fillColor: CustomColor.textfield_fill,
                    // ),
                    SizedBox(height: 10),

                    Obx(
                          ()=> CustomTextField(

                        suffixIcon: GestureDetector(

                            onTap: (){
                              chnagePassController.isnewPasswordVisible.value =
                              !chnagePassController.isnewPasswordVisible.value;

                            },
                            child: Icon(chnagePassController.isnewPasswordVisible.value ?Icons.remove_red_eye:Icons.visibility_off)
                        ),
                        controller: chnagePassController.newpasswordController,
                        obscureText: !chnagePassController.isnewPasswordVisible.value,
                        hintText: CustomText.Chng_New_pass,


                        prefixIcon: const Icon(Icons.lock),
                        borderRadius: 15,
                        FontSize: 14,
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
                    //   hintText: CustomText.Chng_New_pass,
                    //   FontSize: 14,
                    //   prefixIcon: Icon(
                    //     Icons.password,
                    //     color: CustomColor.textField_Icon_Color,
                    //   ),
                    //   borderRadius: 15,
                    //   // fillColor: CustomColor.textfield_fill,
                    // ),
                    //

                    SizedBox(height: 10),


                    Obx(
                          ()=> CustomTextField(

                        suffixIcon: GestureDetector(

                            onTap: (){
                              chnagePassController.isConfirmPasswordVisible.value =
                              !chnagePassController.isConfirmPasswordVisible.value;

                            },
                            child: Icon(chnagePassController.isConfirmPasswordVisible.value ?Icons.remove_red_eye:Icons.visibility_off)
                        ),
                        controller: chnagePassController.ConfirmpasswordController,
                        obscureText: !chnagePassController.isConfirmPasswordVisible.value,
                        hintText: CustomText.Chng_Confirm_pass,
                        FontSize: 14,

                        prefixIcon: const Icon(Icons.lock),
                        borderRadius: 15,
                      ),
                    ),



                    SizedBox(height: 20),

                    Center(
                      child: SizedBox(
                        height: 55,
                        width: 250,
                        child: MyElevatedButton(
                          text: "",
                          onPressed: () {
                            chnagePassController.changePasswordApi();
                            //Get.toNamed('/RideInfoScreen');
                          },
                          textWidget: FittedBox(
                           // fit: BoxFit.scaleDown,
                            child: Text(
                              "Next",
                              style: AppTextStyles.medium(size: 25,weight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
