import 'package:customer/View/Deshboard/map_widget/map_polyLine.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/Ride/RideController.dart';
import '../../Controller/reebooking/reebookingcontroller.dart';
import '../Widgets/all_text.dart';
import '../Widgets/elevat_button.dart';
import '../Widgets/text_button.dart';
import 'DriverDetailscreen.dart';

class RideSearchScreen extends StatelessWidget {
   RideSearchScreen({super.key});

  final rideController = Get.isRegistered<RideController>()
      ? Get.find<RideController>()
      : Get.put(RideController());
  final reebookingController = Get.isRegistered<BookingController>()
      ? Get.find<BookingController>()
      : Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600; // simple tablet detection

    // responsive sizes
    final topBarHeight = screenHeight * (isTablet ? 0.1 : 0.08);
    final mapHeight = screenHeight * (isTablet ? 0.5 : 0.4);
    final gifHeight = screenHeight * (isTablet ? 0.25 : 0.18);
    final buttonHeight = screenHeight * (isTablet ? 0.08 : 0.07);
    final buttonWidth = screenWidth * (isTablet ? 0.5 : 0.7);
    final fontSizeHeading = screenWidth * (isTablet ? 0.05 : 0.06);
    final fontSizeText = screenWidth * (isTablet ? 0.025 : 0.04);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height:double.infinity,
          //padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ================= Top Bar
                SizedBox(
                  height: topBarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Expanded(
                        child: Center(
                          child: Text(
                            CustomText.Searching,
                            style: AppTextStyles.heading(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ================= Map Container
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: mapHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey, width: 2),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/map_image.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                      child: MapScreen()
                  ),
                ),

                const SizedBox(height: 20),

                // ================= Location Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, size: 25, color: Colors.red),
                    const SizedBox(width: 6),
                    Text(
                      CustomText.Seaching_Text,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.medium(
                        weight: FontWeight.bold,
                        size: fontSizeText,
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 10),

                // ================= GIF / Animation
                SizedBox(
                  height: gifHeight,
                  child: Image.asset(
                    "assets/images/map_search.gif",
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 10),

                // ================= Waiting Text
                Text(
                  "Thanks For Your Patience Please Wait",
                  style: AppTextStyles.regular(
                      weight: FontWeight.bold, size: fontSizeText),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // ================= Cancel Button
                SizedBox(
                  height: buttonHeight,
                  width: buttonWidth,
                  child: MyElevatedButton(
                    text: '',
                    onPressed: () {
                      print(rideController.bookingId);
                      Get.dialog(
                        Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding:
                          const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Container(
                            height: 300,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: CustomColor
                                  .Container_Colors,
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                /// TITLE
                                Text(
                                  CustomText.Delete_address,
                                  textAlign: TextAlign.center,
                                  style:
                                  AppTextStyles.heading(),
                                ),

                                const SizedBox(height: 12),

                                /// ICON
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.red
                                        .withOpacity(0.08),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons
                                        .delete_forever_rounded,
                                    color: Colors.red,
                                    size: 34,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                /// DESCRIPTION
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    CustomText.Ride_book_ride_alert,
                                    textAlign:
                                    TextAlign.center,
                                    style:
                                    AppTextStyles.regular(),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                /// BUTTONS
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                                  children: [
                                    /// YES BUTTON
                                    CustomTextButton(
                                      width: 70,
                                      height: 42,
                                      text: 'Yes',

                                      textAlign:
                                      TextAlign.center,
                                      rowMainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      columnCrossAxisAlignment:
                                      CrossAxisAlignment
                                          .center,

                                  onPressed: () {

                                                        if (rideController.isFromHistory) {
                                                          // 👉 History wali cancel API
                                                          reebookingController.cancelHistoryRideApi();
                                                        } else {
                                                          // 👉 Normal cancel API
                                                          rideController.rideCancelApi();
                                                        }

                                                    //  rideController.rideCancelApi();
                                                      // Get.to(DeshBoard_Screen());
                                                    },
                                      backgroundColor: Colors.red,
                                      textColor: CustomColor.textColor,
                                      borderRadius: 10,
                                      elevation: 2,
                                      fontSize: 14,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),

                                    const SizedBox(width: 15),

                                    /// NO BUTTON
                                    CustomTextButton(
                                      width: 70,
                                      height: 42,
                                      text: ' No ',

                                      textAlign:
                                      TextAlign.center,
                                      rowMainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      columnCrossAxisAlignment:
                                      CrossAxisAlignment
                                          .center,

                                      onPressed: () {
                                        Get.back();
                                      },

                                      backgroundColor: CustomColor
                                          .Button_background_Color,
                                      textColor: CustomColor
                                          .textColor,
                                      borderRadius: 10,
                                      elevation: 2,
                                      fontSize: 14,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      // Get.dialog(
                      //   Dialog(
                      //     backgroundColor: CustomColor.Container_Colors,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //     child: SizedBox(
                      //       height: screenHeight * (isTablet ? 0.35 : 0.3),
                      //       width: screenWidth * (isTablet ? 0.6 : 0.8),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const Icon(
                      //             Icons.warning_amber,
                      //             color: Colors.amberAccent,
                      //             size: 60,
                      //           ),
                      //           const SizedBox(height: 15),
                      //           Padding(
                      //             padding: const EdgeInsets.symmetric(horizontal: 10),
                      //             child: Text(
                      //               CustomText.Ride_Cancel_alert,
                      //               textAlign: TextAlign.center,
                      //               style: AppTextStyles.small(),
                      //             ),
                      //           ),
                      //           const SizedBox(height: 20),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               CustomTextButton(
                      //                 text: 'Yes',
                      //                 onPressed: () {
                      //
                      //                     if (rideController.isFromHistory) {
                      //                       // 👉 History wali cancel API
                      //                       reebookingController.cancelHistoryRideApi();
                      //                     } else {
                      //                       // 👉 Normal cancel API
                      //                       rideController.rideCancelApi();
                      //                     }
                      //
                      //                 //  rideController.rideCancelApi();
                      //                   // Get.to(DeshBoard_Screen());
                      //                 },
                      //                 backgroundColor: Colors.red,
                      //                 textColor: CustomColor.Button_Text_Color,
                      //                 borderRadius: 8,
                      //                 elevation: 2,
                      //                 fontSize: fontSizeText,
                      //                 fontWeight: FontWeight.bold,
                      //                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      //               ),
                      //               const SizedBox(width: 20),
                      //               CustomTextButton(
                      //                 text: '  No  ',
                      //                 onPressed: () {
                      //                   Get.to(Driverdetailscreen());
                      //                 },
                      //                 backgroundColor: CustomColor.Button_background_Color,
                      //                 textColor: Colors.white,
                      //                 borderRadius: 8,
                      //                 elevation: 2,
                      //                 fontSize: fontSizeText,
                      //                 fontWeight: FontWeight.bold,
                      //                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // );
                    },
                    textWidget: FittedBox(
                      child: Text(
                        'Cancel Ride',
                        style: AppTextStyles.medium(
                          size: fontSizeHeading,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
