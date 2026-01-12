
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/rides/ride_info_screen.dart';
import 'package:customer/View/rides/ridecomplete.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/all_text.dart';
import '../thanks/thanksscreen.dart';

class Driverdetailscreen extends StatelessWidget {
  const Driverdetailscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
     // backgroundColor: CustomColor.background,
      body:Container(
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
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.6,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        //color: CustomColor.Container_Colors,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
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


                          Expanded(
                            child: Center(
                              child: Text(
                                CustomText.Driver_Info,
                                style: AppTextStyles.heading(
                                  size: MediaQuery.of(context).size.width * 0.06,
                                ),
                              ),
                            ),
                          ),


                          SizedBox(width: MediaQuery.of(context).size.width * 0.06),
                        ],
                      ),
                    ),

                    Container(
                      height: 500,
                     // color: Colors.red,
                      decoration: BoxDecoration(
                        //color: Colors.yellow,
                          image:DecorationImage(image: AssetImage("assets/images/map_image.png",), fit: BoxFit.cover)
                      ),
                    ),

                    SizedBox(height: 15,),






                    //
                    // Padding(
                    //   padding:EdgeInsets.only(left: 8.0),
                    // child: Text(
                    //   CustomText.Vehicle_Image +  "  :  ",
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       color: CustomColor.Text_Color,
                    //       fontWeight: FontWeight.bold
                    //   ),
                    // ),
                    // ),




                    // Container(
                    //   margin : EdgeInsets.only(left: 150),
                    //   height: 80,
                    //   width: 120,
                    //   decoration: BoxDecoration(
                    //     //color: Colors.green,
                    //     borderRadius: BorderRadius.all(Radius.circular(20))
                    //   ),
                    //   child: Image(image: AssetImage("assets/images/carimage.jpg",)),
                    // ),
                    //
                    // SizedBox(height: 5,),
                    //










                  ],
                ),
              ),
            ),
            Spacer(),

            Container(
              height: MediaQuery.of(context).size.height/3,
              padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: CustomColor.Container_Colors,
                 // color: CustomColor.Button_background_Color.withOpacity(0.3),

                  borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))
              ),
              //===========================================================  Driver name
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 8),
                  Center(
                    child: Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color: CustomColor.Icon_Color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  Container(
                    padding:  EdgeInsets.all(8.0),
                    child: Row(

                      children: [
                        SizedBox(width: 10,),
                        CircleAvatar(backgroundColor: Colors.blue,radius: 25,),
                        SizedBox(width: 10,),
                        // Text(
                        //   CustomText.Name+  "  :  ",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //       fontSize: 15,
                        //       color: CustomColor.Text_Color,
                        //       fontWeight: FontWeight.bold
                        //   ),
                        // ),

                        Expanded(
                          child: Text(
                            "Muhammad Ibad Ullah Qureshi",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.medium(
                              //color: CustomColor.Text_Color,
                              //weight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 5,),

                  //=============================================================  Status
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [

                        Text(
                          CustomText.Status+  "  :  ",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.medium(
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left:5 ),
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(Radius.circular(25))
                          ),
                          child: Center(
                            child: Text(
                              "Ride Accepted",
                              textAlign: TextAlign.center,
                              style:  AppTextStyles.small(
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  SizedBox(height: 8,),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          //============================================================  Driver Color
                          Padding(
                            padding:  EdgeInsets.only(left:10.0),
                            child: Row(
                              children: [
                                Text(
                                  CustomText.Vehicle_Color+  "  :  ",
                                  textAlign: TextAlign.center,
                                  style:  AppTextStyles.medium(),
                                ),

                                Text(
                                  "White",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: CustomColor.Text_Color,
                                  ),
                                ),

                              ],
                            ),
                          ),

                          SizedBox(height: 8,),

                          //=============================================================   Driver  Number

                          Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  CustomText.Vehicle_number+  "  :  ",
                                  textAlign: TextAlign.center,
                                  style:  AppTextStyles.medium(),
                                ),

                                Text(
                                  "ABC-1234",
                                  textAlign: TextAlign.center,
                                  style:  AppTextStyles.medium(

                                  ),
                                ),

                              ],
                            ),
                          ),




                        ],
                      ),

                      SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                      Container(
                        //margin : EdgeInsets.only(right: 3,top: 4),
                        //padding: EdgeInsets.all(6),
                        height:60,
                        width: 120,
                        decoration: BoxDecoration(
                          //color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Image(image: AssetImage("assets/images/carimage.jpg",),fit: BoxFit.contain,),
                      ),

                    ],
                  ),

                  SizedBox(height: 10),

                  Center(
                    child: ElevatedButton(onPressed: (){

                      Get.to(RideCompleteScreen());
                    }, child: Text("move to feedback screen")),
                  )



                ],
              ),

            ),
          ],
        ),
      ),


    )
    );
  }
}
