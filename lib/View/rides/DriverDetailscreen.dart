




import 'package:customer/View/Deshboard/map_widget/map_polyLine.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/rides/ridecomplete.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/Home/home-controller.dart';
import '../../Controller/Ride/RideController.dart';
import '../Widgets/all_text.dart';
import 'model/get_booking_by id.dart';

class Driverdetailscreen extends StatefulWidget {
  const Driverdetailscreen({super.key});

  @override
  State<Driverdetailscreen> createState() => _DriverdetailscreenState();
}

class _DriverdetailscreenState extends State<Driverdetailscreen> {
  final controller = Get.isRegistered<RideController>()
      ? Get.find<RideController>()
      : Get.put(RideController());

  final swapController = Get.isRegistered<SwapController>()
      ? Get.find<SwapController>()
      : Get.put(SwapController());



  @override
  void initState() {
    super.initState();

    // 🔥 driverId arguments se lo
    final driverId = Get.arguments['id'];

    controller.startPolling(driverId.toString());
  }


  @override
  void dispose() {
    controller.stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
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
              // ================= Top section (Back + Title)
              Container(
                height: screenHeight * 0.08,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back,
                        size: screenWidth * 0.06,
                        color: CustomColor.Icon_Color,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          CustomText.Driver_Info,
                          style: AppTextStyles.heading(
                            size: screenWidth * 0.06,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.06),
                  ],
                ),
              ),

              // ================= Map Section
              // Expanded(
              //   flex: 6,
              //   child: Container(
              //     margin: const EdgeInsets.symmetric(horizontal: 10),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(18),
              //     ),
              //     child: const ClipRRect(
              //       borderRadius: BorderRadius.all(Radius.circular(18)),
              //       child: MapScreen(),
              //     ),
              //   ),
              // ),
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    image: DecorationImage(
                      image: AssetImage("assets/images/map_image.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: MapScreen(),
                  ),
                ),
              ),

             // ================= Bottom Driver Info Section
              ///
              Expanded(
                flex: 4,
                child: Obx(() {
                  // 🔥 FULL LOADING STATE
                  if (controller.isLoading.value) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: CustomColor.Container_Colors,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        ),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  // 🔥 DATA UI (same as your UI)
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    decoration: BoxDecoration(
                      color: CustomColor.Container_Colors,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        SizedBox(height: 15),

                        // 🔹 Driver Name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              CircleAvatar(backgroundColor: Colors.blue, radius: 25),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  controller.driverName.value,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.heading(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),

                        // 🔹 Status
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Text(
                                CustomText.Status + "  :  ",
                                style: AppTextStyles.medium(),
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: 30,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: controller.bookingStatus.value == "Available"
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(
                                    controller.bookingStatus.value,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.small(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),

                        // 🔹 Vehicle info + image
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(CustomText.Vehicle_Color + "  :  ",
                                          style: AppTextStyles.medium()),
                                      Text(
                                        controller.vehicleColor.value,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: CustomColor.Text_Color,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Text(CustomText.Vehicle_number + "  :  ",
                                          style: AppTextStyles.medium()),
                                      Text(
                                        controller.vehicleNumber.value,
                                        style: AppTextStyles.medium(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                height: 60,
                                width: 100,
                                child: Image.asset(
                                  "assets/images/carimage.jpg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),

                        // Center(
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       Get.to(RideCompleteScreen());
                        //     },
                        //     child: Text("Move to feedback screen"),
                        //   ),
                        // ),
                      ],
                    ),
                  );
                }),
              ),
              // Expanded(
              //   flex: 4,
              //   child: Container(
              //     width: double.infinity,
              //     padding: EdgeInsets.symmetric(vertical: 10),
              //     decoration: BoxDecoration(
              //       color: CustomColor.Container_Colors,
              //       borderRadius: BorderRadius.only(
              //         topRight: Radius.circular(40),
              //         topLeft: Radius.circular(40),
              //       ),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Center(
              //           child: Container(
              //             height: 5,
              //             width: 40,
              //             decoration: BoxDecoration(
              //               color: CustomColor.Icon_Color,
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //           ),
              //         ),
              //         SizedBox(height: 10),
              //
              //         // Driver Name
              //         Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 10),
              //           child: Row(
              //             children: [
              //               CircleAvatar(backgroundColor: Colors.blue, radius: 25),
              //               SizedBox(width: 10),
              //               Expanded(
              //                 child: Text(
              //                   "Muhammad Ibad Ullah Qureshi",
              //                   textAlign: TextAlign.center,
              //                   maxLines: 1,
              //                   overflow: TextOverflow.ellipsis,
              //                   style: AppTextStyles.medium(),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         SizedBox(height: 5),
              //
              //         // Status
              //         Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //           child: Row(
              //             children: [
              //               Text(
              //                 CustomText.Status + "  :  ",
              //                 style: AppTextStyles.medium(),
              //               ),
              //               SizedBox(width: 5),
              //               Container(
              //                 height: 30,
              //                 width: 120,
              //                 decoration: BoxDecoration(
              //                   color: Colors.red,
              //                   borderRadius: BorderRadius.circular(25),
              //                 ),
              //                 child: Center(
              //                   child: Text(
              //                     "Ride Accepted",
              //                     textAlign: TextAlign.center,
              //                     style: AppTextStyles.small(),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         SizedBox(height: 10),
              //
              //         // Vehicle info + image
              //         Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 10),
              //           child: Row(
              //             children: [
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Row(
              //                     children: [
              //                       Text(CustomText.Vehicle_Color + "  :  ",
              //                           style: AppTextStyles.medium()),
              //                       Text(
              //                         "White",
              //                         style: TextStyle(
              //                           fontSize: 18,
              //                           color: CustomColor.Text_Color,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   SizedBox(height: 8),
              //                   Row(
              //                     children: [
              //                       Text(CustomText.Vehicle_number + "  :  ",
              //                           style: AppTextStyles.medium()),
              //                       Text(
              //                         "ABC-1234",
              //                         style: AppTextStyles.medium(),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //               Spacer(),
              //               Container(
              //                 height: 60,
              //                 width: 100,
              //                 child: Image.asset(
              //                   "assets/images/carimage.jpg",
              //                   fit: BoxFit.contain,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         SizedBox(height: 15),
              //
              //         Center(
              //           child: ElevatedButton(
              //             onPressed: () {
              //               Get.to(RideCompleteScreen());
              //             },
              //             child: Text("Move to feedback screen"),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}





///////////////////////////////////////////////////////////////


///
//
//
// class Driverdetailscreen extends StatelessWidget {
//   const Driverdetailscreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: Scaffold(
//      // backgroundColor: CustomColor.background,
//       body:SingleChildScrollView(
//         child: Container(
//           height:MediaQuery.of(context).size.height,
//           width:MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             gradient: LinearGradient  (
//               colors: [
//                 Color.fromARGB(255, 30, 1, 44),
//                 Color.fromARGB(255, 227, 194, 242)
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height*0.6,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: MediaQuery.of(context).size.height * 0.1,
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           decoration: BoxDecoration(
//                             //color: CustomColor.Container_Colors,
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               bottomRight: Radius.circular(20),
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//
//                               IconButton(
//                                 onPressed: () {
//                                   Get.back();
//                                 },
//                                 icon: Icon(
//                                   Icons.arrow_back,
//                                   size: MediaQuery.of(context).size.width * 0.06,
//                                   color: CustomColor.Icon_Color,
//                                 ),
//                               ),
//
//
//                               Expanded(
//                                 child: Center(
//                                   child: Text(
//                                     CustomText.Driver_Info,
//                                     style: AppTextStyles.heading(
//                                       size: MediaQuery.of(context).size.width * 0.06,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//
//
//                               SizedBox(width: MediaQuery.of(context).size.width * 0.06),
//                             ],
//                           ),
//                         ),
//
//                         Container(
//                           height: 500,
//                          // color : Colors.red,
//                           decoration: BoxDecoration(
//                             //color: Colors.yellow,
//                               image:DecorationImage(image: AssetImage("assets/images/map_image.png",), fit: BoxFit.cover)
//                           ),
//                           //child: MapScreen(),
//                         ),
//
//                         //  SizedBox(height: 15,),
//
//                         //
//                         // Padding(
//                         //   padding:EdgeInsets.only(left: 8.0),
//                         // child: Text(
//                         //   CustomText.Vehicle_Image +  "  :  ",
//                         //   textAlign: TextAlign.center,
//                         //   style: TextStyle(
//                         //       fontSize: 18,
//                         //       color: CustomColor.Text_Color,
//                         //       fontWeight: FontWeight.bold
//                         //   ),
//                         // ),
//                         // ),
//
//
//
//
//                         // Container(
//                         //   margin : EdgeInsets.only(left: 150),
//                         //   height: 80,
//                         //   width: 120,
//                         //   decoration: BoxDecoration(
//                         //     //color: Colors.green,
//                         //     borderRadius: BorderRadius.all(Radius.circular(20))
//                         //   ),
//                         //   child: Image(image: AssetImage("assets/images/carimage.jpg",)),
//                         // ),
//                         //
//                         // SizedBox(height: 5,),
//                         //
//
//
//
//
//
//
//
//
//
//
//                       ]
//                     ),
//                   ),
//                 ),
//                  Spacer(),
//
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.3576,
//                   padding: EdgeInsets.only(bottom: 10),
//                   decoration: BoxDecoration(
//                       color: CustomColor.Container_Colors,
//                      // color: CustomColor.Button_background_Color.withOpacity(0.3),
//
//                       borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))
//                   ),
//                   //===========================================================  Driver name
//                   child:  SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//
//                         SizedBox(height: 8),
//                         Center(
//                           child: Container(
//                             height: 5,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               color: CustomColor.Icon_Color,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//
//                         Container(
//                           padding:  EdgeInsets.all(8.0),
//                           child: Row(
//
//                             children: [
//                               SizedBox(width: 10,),
//                               CircleAvatar(backgroundColor: Colors.blue,radius: 25,),
//                               SizedBox(width: 10,),
//                               // Text(
//                               //   CustomText.Name+  "  :  ",
//                               //   textAlign: TextAlign.center,
//                               //   style: TextStyle(
//                               //       fontSize: 15,
//                               //       color: CustomColor.Text_Color,
//                               //       fontWeight: FontWeight.bold
//                               //   ),
//                               // ),
//
//                               Expanded(
//                                 child: Text(
//                                   "Muhammad Ibad Ullah Qureshi",
//                                   textAlign: TextAlign.center,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: AppTextStyles.medium(
//                                     //color: CustomColor.Text_Color,
//                                     //weight: FontWeight.bold
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         SizedBox(height: 5,),
//
//                         //=============================================================  Status
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                           child: Row(
//                             children: [
//
//                               Text(
//                                 CustomText.Status+  "  :  ",
//                                 textAlign: TextAlign.center,
//                                 style: AppTextStyles.medium(
//                                 ),
//                               ),
//                               Container(
//                                 margin: const EdgeInsets.only(left:5 ),
//                                 height: 30,
//                                 width: 120,
//                                 decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     borderRadius: BorderRadius.all(Radius.circular(25))
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "Ride Accepted",
//                                     textAlign: TextAlign.center,
//                                     style:  AppTextStyles.small(
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//
//                         SizedBox(height: 8,),
//
//                         SingleChildScrollView(
//                           child: Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//
//                                   //============================================================  Driver Color
//                                   Padding(
//                                     padding:  EdgeInsets.only(left:10.0),
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           CustomText.Vehicle_Color+  "  :  ",
//                                           textAlign: TextAlign.center,
//                                           style:  AppTextStyles.medium(),
//                                         ),
//
//                                         Text(
//                                           "White",
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             color: CustomColor.Text_Color,
//                                           ),
//                                         ),
//
//                                       ],
//                                     ),
//                                   ),
//
//                                   SizedBox(height: 8,),
//
//                                   //=============================================================   Driver  Number
//
//                                   Padding(
//                                     padding:  EdgeInsets.only(left: 10.0),
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           CustomText.Vehicle_number+  "  :  ",
//                                           textAlign: TextAlign.center,
//                                           style:  AppTextStyles.medium(),
//                                         ),
//
//                                         Text(
//                                           "ABC-1234",
//                                           textAlign: TextAlign.center,
//                                           style:  AppTextStyles.medium(
//
//                                           ),
//                                         ),
//
//                                       ],
//                                     ),
//                                   ),
//
//
//
//
//                                 ],
//                               ),
//
//                               SizedBox(width: MediaQuery.of(context).size.width*0.05,),
//                               Container(
//                                 margin : EdgeInsets.only(right: 10),
//                                 // padding: EdgeInsets.only(right: 60),
//                                 height:60,
//                                 width: 100,
//                                 decoration: BoxDecoration(
//                                   //color: Colors.green,
//                                     borderRadius: BorderRadius.all(Radius.circular(30))
//                                 ),
//                                 child: Image(image: AssetImage("assets/images/carimage.jpg",),fit: BoxFit.contain,),
//                               ),
//
//                             ],
//                           ),
//                         ),
//
//                         SizedBox(height: 10),
//
//                         Center(
//                           child: ElevatedButton(onPressed: (){
//
//                             Get.to(RideCompleteScreen());
//                           }, child: Text("move to feedback screen")),
//                         )
//
//
//
//                       ],
//                     ),
//                   ),
//
//                 ),
//
//                   ]
//             ),
//           ),
//         ),
//       ),
//
//
//     )
//     );
//   }
// }
