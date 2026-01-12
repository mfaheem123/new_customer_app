import 'package:customer/View/Widgets/all_text.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/yourtrip/yourtrip_Controller.dart';
import '../Reebook/Reebookingscreen.dart';
import '../Widgets/color.dart';

  class Yourtrip extends StatefulWidget {
  Yourtrip({super.key});

  @override
  State<Yourtrip> createState() => _YourtripState();
}

class _YourtripState extends State<Yourtrip> {
  final YourTripController tripControl = Get.put(YourTripController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: CustomColor.background,
        body: Container(
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

                height: MediaQuery.of(context).size.height * 0.1,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  //color: CustomColor.Container_Colors,
                  borderRadius: BorderRadius.only(
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

                    SizedBox(width: 5),

                    Expanded(
                      child: Center(
                        child: Text(
                          CustomText.Your_Trip,
                          style: AppTextStyles.heading(
                            size: MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                       //   Get.back();
                      },
                      icon: Icon(
                        Icons.edit_notifications_sharp,
                        size: MediaQuery.of(context).size.width * 0.06,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //
            //     // Back Button
            //     Padding(
            //       padding: const EdgeInsets.only(left: 15),
            //       child: IconButton(
            //         onPressed: () {
            //           Get.back();
            //         },
            //         icon: const Icon(Icons.arrow_back, color: CustomColor.Icon_Color),
            //         iconSize: MediaQuery.of(context).size.width * 0.06,
            //       ),
            //     ),
            //
            //     // Gap
            //     SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            //
            //     // Title (Perfectly Centered)
            //     Expanded(
            //       child: Center(
            //         child: Text(
            //           CustomText.Your_Trip,
            //           style: TextStyle(
            //             fontSize: MediaQuery.of(context).size.width * 0.065,
            //             fontWeight: FontWeight.bold,
            //             color: CustomColor.Text_Color,
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //
            //     SizedBox(
            //       width: MediaQuery.of(context).size.width * 0.11 + 15, // equal to back button width
            //     ),
            //   ],
            // ),
            //



              SizedBox(height: 10),

              Obx(
                () => Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: tripControl.selectedIndex.value == 0
                      ? CustomColor.Button_background_Color
                        : CustomColor.Container_Colors,

                      ),

                      child: TextButton(
                        onPressed: () {
                          tripControl.ChangeIndex(0);
                        },
                        child: Text(
                          "SCHEDULED",
                          style: AppTextStyles.medium(
                           // fontSize: 20,
                            color: tripControl.selectedIndex.value == 0?
                                CustomColor.Button_Text_Color
                                :CustomColor.Text_Color,

                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: tripControl.selectedIndex.value == 1
                            ?CustomColor.Button_background_Color
                            : CustomColor.Container_Colors,
                      ),
                      child: TextButton(
                        onPressed: () {
                          tripControl.ChangeIndex(1);
                        },
                        child: Text(
                          "HISTORY",
                          style: AppTextStyles.medium(
                            // fontSize: 20,
                            color: tripControl.selectedIndex.value == 1?
                            CustomColor.Button_Text_Color
                                :CustomColor.Text_Color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),


              Container(
                height: 250,
                width: 350,
                decoration: BoxDecoration(
                  //color: CustomColor.Container_Colors,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),

                  ),
                  border: Border.all(
                    color: CustomColor.Container_Colors,
                    width: 4,
                  ),
                  //color: Colors.black,
                ),
                child: Column(
                  children: [
                    //====================================     card header
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10, top: 3,bottom: 5),
                      color: CustomColor.Container_Colors,
                      height: 23,
                      child: Row(
                        children: [
                          Text(
                            "Ref: 123456",
                            style: AppTextStyles.small(),
                          ),
                         Spacer(),
                          Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 18,
                          ),
                          Text(
                            "00/00/2001",
                            style: AppTextStyles.small(),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "00:00",
                            style: AppTextStyles.small(),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    //==========================        Addresses to Address
                    Container(
                      height: 90,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.only(left: 10,right: 10,bottom: 0,top: 10),
                            height: 80,
                            width: 130,

                            child: Center(
                              child: Text(
                                "1A Worrior "
                                    "Garden St.LEO"
                                    " TN36eb",
                                softWrap: true,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.small(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),

                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 30,
                            color: CustomColor.Text_Color,
                          ),

                          SizedBox(width: 10),

                          Container(
                            margin: EdgeInsets.only(left: 10),

                            padding: EdgeInsets.all(10),
                            height: 80,
                            width: 130,
                            child: Center(
                              child: Text(
                                "Flat  1 "
                                    "Bland fold"
                                    "Nw6",
                                softWrap: true,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.small(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //SizedBox(height: 2),
                    //=======================================     Rate and status
                    Container  (
                      //color: CustomColor.background,
                      padding: EdgeInsets.only(left: 14 ,top: 0),
                      height: 70,
                      child: Row(
                        children: [
                          Icon(Icons.car_repair,
                            color: CustomColor.Icon_Color,),
                          Container(
                            height: 60,
                            padding: EdgeInsets.only(top: 2),
                            child: Column(
                              children: [
                                Text(
                                  " ESTATE CAR",
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.small(),
                                ),
                                Text(
                                  "&177.00",
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.medium(size: 20),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 70),
                          //====================================   Status text
                          Container(
                            height: 30,
                            width: 100,
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Cancelled",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: CustomColor.Text_Color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      //height: 49,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)
                         ),

                        //color: CustomColor.background,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: CustomColor.Container_Colors,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(ReebookingScreen());
                                },
                                child:  Text(
                                  "Rebook Now",
                                  style: AppTextStyles.medium(),
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(width: 2,color: Colors.white70,),
                          Expanded(
                            child: Container(
                              color: CustomColor.Container_Colors,
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed('/TripDetail');
                                },
                                child:  Text(
                                  "Show Detail",
                                  style: AppTextStyles.medium(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),





                    // Container(
                    //   height: 48,
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         width: MediaQuery.of(context).size.width * 0.4,
                    //         child: TextButton(
                    //           onPressed: () {
                    //             Get.to(ReebookingScreen());
                    //           },
                    //           child: Text(
                    //             "Rebook Now",
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 20,
                    //               color: CustomColor.Text_Color,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       Container(
                    //         width: MediaQuery.of(context).size.width * 0.407,
                    //         child: TextButton(
                    //           onPressed: () {
                    //             Get.toNamed('/TripDetail');
                    //           },
                    //           child: Text(
                    //             "Show Detail",
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 20,
                    //               color: CustomColor.Text_Color,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),

              // Container(
              //   height: 700,
              //   width: 400,
              //   padding: EdgeInsets.only(top: 20),
              //   child: Center(
              //     child:
              //   ),
              // ),


              // Container(
              //   child: Obx(
              //     () => tripControl.selectedIndex.value == 0
              //         ? Container(
              //             height: 700,
              //             width: 400,
              //
              //             child: Center(
              //               child: Text(
              //                 "NO BOOKING AVALIABLE",
              //                 style: TextStyle(
              //                   color: CustomColor.Text_Color,
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 20,
              //                 ),
              //               ),
              //             ),
              //           )
              //         : Container(
              //             height: 700,
              //             width: 400,
              //             padding: EdgeInsets.only(top: 20),
              //             child: Center(
              //               child: Container(
              //                 height: 250,
              //                 width: 350,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.all(
              //                     Radius.circular(10),
              //                   ),
              //                   border: Border.all(
              //                     color: Colors.white60,
              //                     width: 4,
              //                   ),
              //                   color: Colors.black,
              //                 ),
              //                 child: Column(
              //                   children: [
              //                     //====================================     card header
              //                     Container(
              //                       padding: EdgeInsets.only(left: 5),
              //                       color: Colors.white60,
              //                       height: 20,
              //                       child: Row(
              //                         children: [
              //                           Text(
              //                             "Ref: 123456",
              //                             style: TextStyle(color: CustomColor.Text_Color,),
              //                           ),
              //                           SizedBox(width: 85),
              //                           Icon(
              //                             Icons.access_time,
              //                             color: Colors.white,
              //                             size: 15,
              //                           ),
              //                           Text(
              //                             "00/00/2001",
              //                             style: TextStyle(color:  CustomColor.Text_Color,),
              //                           ),
              //                           SizedBox(width: 10),
              //                           Text(
              //                             "00:00",
              //                             style: TextStyle(color: CustomColor.Text_Color,),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //
              //                     SizedBox(height: 10),
              //
              //                     //==========================        Addresses to Address
              //                     Container(
              //                       height: 90,
              //
              //                       child: Row(
              //                         children: [
              //                           Container(
              //                             margin: EdgeInsets.only(left: 10),
              //                             color: Colors.black,
              //                             padding: EdgeInsets.all(10),
              //                             height: 80,
              //                             width: 130,
              //
              //                             child: Center(
              //                               child: Text(
              //                                 "1A Worrior "
              //                                 "Garden St.LEO"
              //                                 " TN36eb",
              //                                 softWrap: true,
              //                                 maxLines: 3,
              //                                 overflow: TextOverflow.ellipsis,
              //                                 style: TextStyle(
              //                                   fontSize: 13,
              //                                   color: CustomColor.Text_Color,
              //                                   fontWeight: FontWeight.bold,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                           SizedBox(width: 10),
              //
              //                           Icon(
              //                             Icons.arrow_forward_rounded,
              //                             size: 30,
              //                             color: Colors.white,
              //                           ),
              //
              //                           SizedBox(width: 10),
              //
              //                           Container(
              //                             margin: EdgeInsets.only(left: 10),
              //                             color: Colors.black,
              //                             padding: EdgeInsets.all(10),
              //                             height: 80,
              //                             width: 130,
              //                             child: Center(
              //                               child: Text(
              //                                 "Flat  1 "
              //                                 "Bland fold"
              //                                 " London Nw6",
              //                                 softWrap: true,
              //                                 maxLines: 3,
              //                                 overflow: TextOverflow.ellipsis,
              //                                 style: TextStyle(
              //                                   fontSize: 13,
              //                                   color: CustomColor.Text_Color,
              //                                   fontWeight: FontWeight.bold,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                     SizedBox(height: 2),
              //                     //=======================================     Rate and status
              //                     Container(
              //                       padding: EdgeInsets.only(left: 14),
              //                       height: 70,
              //                       child: Row(
              //                         children: [
              //                           Icon(Icons.car_repair,
              //                           color: Colors.white,),
              //                           Container(
              //                             height: 60,
              //                             padding: EdgeInsets.only(top: 2),
              //                             child: Column(
              //                               children: [
              //                                 Text(
              //                                   " ESTATE CAR",
              //                                   overflow: TextOverflow.ellipsis,
              //                                   style: TextStyle(
              //                                     fontSize: 10,
              //                                     color: CustomColor.Text_Color,
              //                                     fontWeight: FontWeight.bold,
              //                                   ),
              //                                 ),
              //                                 Text(
              //                                   "&177.00",
              //                                   overflow: TextOverflow.ellipsis,
              //                                   style: TextStyle(
              //                                     fontSize: 25,
              //                                     color: CustomColor.Text_Color,
              //                                     fontWeight: FontWeight.bold,
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                           SizedBox(width: 60),
              //                           //====================================   Status text
              //                           Container(
              //                             height: 30,
              //                             width: 100,
              //                             decoration: BoxDecoration(
              //                               color: Colors.red,
              //                               borderRadius: BorderRadius.circular(
              //                                 15,
              //                               ),
              //                             ),
              //                             child: Center(
              //                               child: Text(
              //                                 "Cancelled",
              //                                 style: TextStyle(
              //                                   fontWeight: FontWeight.bold,
              //                                   fontSize: 12,
              //                                   color: CustomColor.Text_Color,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //
              //                     Container(
              //                       height: 48,
              //                       child: Row(
              //                         children: [
              //                           Container(
              //                             width: MediaQuery.of(context).size.width * 0.4,
              //                             child: TextButton(
              //                               onPressed: () {
              //                                 Get.to(ReebookingScreen());
              //                               },
              //                               child: Text(
              //                                 "Rebook Now",
              //                                 style: TextStyle(
              //                                   fontWeight: FontWeight.bold,
              //                                   fontSize: 20,
              //                                   color: CustomColor.Text_Color,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //
              //                           Container(
              //                             width: MediaQuery.of(context).size.width * 0.407,
              //                             child: TextButton(
              //                               onPressed: () {
              //                                 Get.toNamed('/TripDetail');
              //                               },
              //                               child: Text(
              //                                 "Show Detail",
              //                                 style: TextStyle(
              //                                   fontWeight: FontWeight.bold,
              //                                   fontSize: 20,
              //                                   color: CustomColor.Text_Color,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
