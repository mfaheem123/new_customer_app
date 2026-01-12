import 'package:customer/Controller/change_password_number/change_password_controller.dart';
import 'package:customer/View/Widgets/all_text.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/elevat_button.dart';
import 'package:customer/View/Widgets/phone_number_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../textstyle/apptextstyle.dart';


class ChangPhoneNumber extends StatelessWidget {
   ChangPhoneNumber({super.key});
   final controller = Get.put(changePasswordController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       // backgroundColor: CustomColor.background,

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
          child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           Row(
                children: [

                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: MediaQuery.of(context).size.width * 0.06,
                      color: CustomColor.Icon_Color,
                    ),
                  ),

                  const SizedBox(width: 5),

                  Expanded(
                    child: Center(
                      child: Text(
                        CustomText.Chng_Phone_Num,
                        style: AppTextStyles.heading(
                          size: MediaQuery.of(context).size.width * 0.06,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),


                ],
              ),



              SizedBox(height: 15,),
              Padding(
                padding:  EdgeInsets.only(left: 10.0),
                child: Text(CustomText.Chng_Phone_Num,style: AppTextStyles.medium(),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 10.0),
                child: Text(CustomText.Mobile_Num,style: AppTextStyles.medium(),),
              ),
              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: PhoneNumber_TextField(
                  controller : controller.chnagePhoneNoController,
                  hintText: CustomText.Mobile_Num,
                ),
              ),
              SizedBox(height: 10,),

              Center(
                child: SizedBox(
                  height: 55,
                  width: 250  ,
                  child: MyElevatedButton(
                    text: 'Next',
                    onPressed: () {
                      controller.changeNumberApi();
                    },
                    fontSize: 20,
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
