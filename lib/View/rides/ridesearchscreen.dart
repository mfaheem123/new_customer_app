import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/rides/ride_info_screen.dart';
import 'package:customer/View/rides/ridecomplete.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Deshboard/dashboard.dart';
import '../Widgets/all_text.dart';
import '../Widgets/elevat_button.dart';
import '../Widgets/text_button.dart';
import 'DriverDetailscreen.dart';

class RideSearchScreen extends StatelessWidget {
  const RideSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              //padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
               // color: CustomColor.Container_Colors,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  // Back button
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: MediaQuery.of(context).size.width * 0.06, // responsive icon size
                      color: CustomColor.Icon_Color,
                    ),
                  ),

                  // Title centered
                  Expanded(
                    child: Center(
                      child: Text(
                        CustomText.Searching,
                        style: AppTextStyles.heading(
                          size: MediaQuery.of(context).size.width * 0.06, // responsive font
                          //weight: FontWeight.bold,

                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),

            // Container(
            //   height: MediaQuery.of(context).size.height*0.1,
            //   padding: EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //       color: CustomColor.textColor,
            //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
            //   ),
            //   child: Row(
            //     children: [
            //       IconButton(onPressed: (){
            //         Get.back();
            //       }, icon: Icon(Icons.arrow_back,size: 25,color: CustomColor.Icon_Color,)
            //       ),
            //       SizedBox(width: 100,),
            //         Text(
            //           CustomText.Seaching,
            //           style: TextStyle(fontSize: 25,
            //               fontWeight: FontWeight.bold,
            //               color: CustomColor.Text_Color),
            //         ),
            //     ],
            //   ),
            // ),

            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: Colors.grey, // border color
                  width: 2,           // optional: thickness
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/map_image.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),


            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 25,),
                Icon(Icons.location_on,size: 25,color: Colors.red),
                //CustomColor.Icon_Color,),
                SizedBox(width: 10,),
                Text(
                  CustomText.Seaching_Text,
                  style: AppTextStyles.medium(
                            weight: FontWeight.bold,
                        ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height*0.2,

              decoration: BoxDecoration(
                  //color: Colors.yellow,
                image:DecorationImage(image: AssetImage("assets/images/map_search.gif",), fit: BoxFit.contain)
              ),
            ),
            SizedBox(height: 10,),

            Text(
              "Thanks For Your Patience Please Wait",
              style: AppTextStyles.medium(
                  weight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 20,),

            SizedBox(
              height: 55,
              width: 250  ,
              child: MyElevatedButton(
                text: '',
                onPressed: () {
                  Get.dialog(
                      Dialog(
                        backgroundColor: CustomColor.Container_Colors,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: SizedBox(
                          height: 250,
                          width: 200,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              const Icon(
                                Icons.warning_amber,
                                color: Colors.amberAccent,
                                size: 60,
                              ),
                              SizedBox(height: 15,),
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  height: 80,
                                  width: 200,
                                  child: Text(
                                    CustomText.Ride_Cancel_alert,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.small(),
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextButton(
                                    text: 'Yes',
                                    onPressed: () {
                                      Get.to(DeshBoard_Screen());
                                    },
                                    backgroundColor: Colors.red,
                                    textColor: CustomColor.Button_Text_Color,
                                    borderRadius: 8,
                                    elevation: 2,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                  ),
                                  const SizedBox(width: 20),

                                  CustomTextButton(
                                    text: "  No   ",
                                    onPressed: () {
                                      Get.to(  Driverdetailscreen() );
                                    },
                                    backgroundColor: CustomColor.Button_background_Color,
                                    textColor: Colors.white,
                                    borderRadius: 8,
                                    elevation: 2,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                  );
                },
                textWidget:
                FittedBox(
                    //fit: BoxFit.scaleDown,
                    child: Text('Cancel Ride',style: AppTextStyles.medium(size: 25,weight: FontWeight.bold),
                    )
                ),
              ),
            ),

            // SizedBox(
            //   height: 50,
            //   width: 250  ,
            //   child: MyElevatedButton(
            //     text: 'Cancel Ride',
            //     onPressed: () {
            //       Get.dialog(
            //         Dialog(
            //           backgroundColor: CustomColor.Container_Colors,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(30)),
            //           ),
            //           child: SizedBox(
            //             height: 210,
            //             width: 100,
            //             child: Column(
            //               children: [
            //                 const SizedBox(height: 15),
            //                 const Icon(
            //                   Icons.warning_amber,
            //                   color: Colors.amberAccent,
            //                   size: 60,
            //                 ),
            //                 SizedBox(height: 10,),
            //                 Center(
            //                   child: Container(
            //                     padding: const EdgeInsets.only(left: 10),
            //                     height: 80,
            //                     width: 200,
            //                     child: Text(
            //                       CustomText.Ride_Cancel_alert,
            //                       textAlign: TextAlign.center,
            //                       style: AppTextStyles.small(),
            //                     ),
            //                   ),
            //                 ),
            //                 Row(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     CustomTextButton(
            //                       text: 'Yes',
            //                       onPressed: () {
            //                         Get.to(DeshBoard_Screen());
            //                       },
            //                       backgroundColor: Colors.red,
            //                       textColor: CustomColor.Button_Text_Color,
            //                       borderRadius: 8,
            //                       elevation: 2,
            //                       fontSize: 10,
            //                       fontWeight: FontWeight.bold,
            //                       padding: const EdgeInsets.symmetric(
            //                         horizontal: 16,
            //                         vertical: 10,
            //                       ),
            //                     ),
            //                     const SizedBox(width: 20),
            //
            //                     CustomTextButton(
            //                       text: " No ",
            //                       onPressed: () {
            //                         Get.to(  Driverdetailscreen() );
            //                       },
            //                       backgroundColor: CustomColor.Button_background_Color,
            //                       textColor: Colors.white,
            //                       borderRadius: 8,
            //                       elevation: 2,
            //                       fontSize: 10,
            //                       fontWeight: FontWeight.bold,
            //                       padding: const EdgeInsets.symmetric(
            //                         horizontal: 16,
            //                         vertical: 10,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         )
            //       );
            //     },
            //
            //     fontSize: 20,
            //   ),
            // )



          ],
        ),
      ),
    )
    );
  }
}
