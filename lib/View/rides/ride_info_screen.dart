import 'package:customer/Controller/Ride/RideController.dart';
import 'package:customer/Routing/routes_name.dart';
import 'package:customer/View/Widgets/all_text.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Controller/Home/home-controller.dart';
import '../Widgets/elevat_button.dart';
import '../Widgets/text_button.dart';
import '../profile/controller/profile_controller.dart';
import 'ridesearchscreen.dart';

class RideInfoScreen extends StatefulWidget {
  const RideInfoScreen({super.key});

  @override
  State<RideInfoScreen> createState() => _RideInfoScreenState();
}

class _RideInfoScreenState extends State<RideInfoScreen> {
  //final rideController = Get.put(RideController());

  final rideController = Get.isRegistered<RideController>()
      ? Get.find<RideController>()
      : Get.put(RideController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RideController>().getVehicleTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: CustomColor.background,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 30, 1, 44),
                Color.fromARGB(255, 227, 194, 242),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                  FocusManager.instance.primaryFocus
                                      ?.unfocus(); // keyboard close
                                  Future.delayed(
                                    const Duration(milliseconds: 50),
                                    () {
                                      Get.back();
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  size:
                                      MediaQuery.of(context).size.width * 0.07,
                                  color: CustomColor.Icon_Color,
                                ),
                              ),

                              const SizedBox(width: 5),

                              Expanded(
                                child: Center(
                                  child: Text(
                                    CustomText.Ride_Info,
                                    style: AppTextStyles.heading(
                                      size:
                                          MediaQuery.of(context).size.width *
                                          0.06,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit_notifications_sharp,
                                  size:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //SizedBox(height: 10,),
                        Text(
                          CustomText.Select_Suitable_Ride,
                          style: AppTextStyles.heading(weight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),

                        /// LOADING INDICATOR (ADDED)
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.67,
                          child: GetBuilder<RideController>(
                            builder: (rideController) {
                              /// 🔄 LOADING
                              if (rideController.loading) {
                                return Align(
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 3,
                                    child: LinearProgressIndicator(
                                      minHeight: 3,
                                      color: CustomColor.Icon_Color,
                                      backgroundColor: Colors.white24,
                                    ),
                                  ),
                                );
                              }

                              /// ❌ NO DATA
                              if (rideController.vehicleData == null ||
                                  rideController
                                      .vehicleData!
                                      .vehicleTypes!
                                      .isEmpty) {
                                return Center(
                                  child: Text(
                                    "No vehicles available",
                                    style: AppTextStyles.medium(),
                                  ),
                                );
                              }

                              /// ✅ DATA LOADED
                              return ListView.builder(
                                itemCount: rideController
                                    .vehicleData!
                                    .vehicleTypes!
                                    .length,
                                itemBuilder: (context, index) {
                                  bool isSelected =
                                      rideController.selectedIndex == index;

                                  final vehicle = rideController
                                      .vehicleData!
                                      .vehicleTypes![index];

                                  return GestureDetector(
                                    onTap: () {
                                      rideController.selectItem(index);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? CustomColor
                                                  .Container_Colors.withOpacity(
                                                0.4,
                                              )
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: isSelected
                                              ? CustomColor
                                                    .Button_background_Color
                                              : Colors.grey.shade400,
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          /// 🔹 Vehicle Info
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${vehicle.name ?? ""}",
                                                style: AppTextStyles.regular(),
                                              ),

                                              SizedBox(height: 5),

                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.person,
                                                    color:
                                                        CustomColor.Icon_Color,
                                                    size: 18,
                                                  ),
                                                  Text(
                                                    " x${vehicle.passengers ?? 0}",
                                                    style:
                                                        AppTextStyles.medium(),
                                                  ),

                                                  SizedBox(width: 10),

                                                  Icon(
                                                    Icons.work,
                                                    color:
                                                        CustomColor.Icon_Color,
                                                    size: 18,
                                                  ),
                                                  Text(
                                                    " x${vehicle.luggages ?? 0}",
                                                    style:
                                                        AppTextStyles.regular(
                                                          color: CustomColor
                                                              .Text_Color,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                          /// 🔹 Icon + Price
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.directions_car,
                                                color: CustomColor.Icon_Color,
                                                size: 32,
                                              ),

                                              SizedBox(width: 10),
                                              //
                                              // Text(
                                              //   "${vehicle.minimumFares ?? 0}£",
                                              //   style: AppTextStyles.regular(),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // child: Container(
                                    //   height: 120,
                                    //   margin: const EdgeInsets.all(8),
                                    //   padding: const EdgeInsets.all(10),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(20),
                                    //     color: isSelected
                                    //         ? CustomColor.Container_Colors.withOpacity(0.4)
                                    //         : Colors.transparent,
                                    //     border: Border.all(
                                    //       color: isSelected
                                    //           ? CustomColor.Button_background_Color
                                    //           : Colors.grey.shade400,
                                    //       width: 2,
                                    //     ),
                                    //   ),
                                    //   child: Column(
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                    //     children: [
                                    //       Text(
                                    //         vehicle.name ?? "",
                                    //         style: AppTextStyles.medium(
                                    //           weight: FontWeight.bold,
                                    //           color: CustomColor.Text_Color,
                                    //         ),
                                    //       ),
                                    //       const SizedBox(height: 15),
                                    //       Row(
                                    //         children: [
                                    //           const SizedBox(width: 20),
                                    //           Icon(Icons.directions_car,
                                    //               size: 30,
                                    //               color: CustomColor.Icon_Color),
                                    //           const SizedBox(width: 5),
                                    //           Icon(Icons.person,
                                    //               size: 18,
                                    //               color: CustomColor.Icon_Color),
                                    //           const SizedBox(width: 5),
                                    //           Text(
                                    //             "${vehicle.passengers ?? 0}",
                                    //             style: AppTextStyles.medium(
                                    //               weight: FontWeight.bold,
                                    //               color: CustomColor.Text_Color,
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(
                    top: 2.0,
                    bottom: 5.0,
                    left: 10,
                    right: 10,
                  ),
                  child: SizedBox(
                    height: 55,
                    width: 250,
                    child: MyElevatedButton(
                      text: "", // ignored because we use textWidget
                      onPressed: () {
                        print(
                          "======================================================================${rideController.selectedVehicleId}",
                        );

                        ///     ==============================================================================   bottom sheet
                        Get.bottomSheet(
                          //ScheduleRideBottomSheet(),
                          Container(
                            decoration: const BoxDecoration(
                              color: CustomColor.Container_Colors,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            height: 350,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 8),
                                  Container(
                                    height: 5,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: CustomColor.Icon_Color,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  // ---------- Heading ----------
                                  Text(
                                    "Schedule Ride",
                                    style: AppTextStyles.medium(
                                      size: 25,
                                      weight: FontWeight.bold,
                                      color: CustomColor.Text_Color,
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // ---------- Time Buttons ----------
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // ----- ASAP -----
                                        SizedBox(
                                          width: 100,
                                          height: 45,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              rideController.setASAP();
                                            },

                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  rideController
                                                          .selectedTimeOption
                                                          .value ==
                                                      "ASAP"
                                                  ? CustomColor
                                                        .Button_background_Color
                                                  : Colors.black54,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text(
                                              "Asap",
                                              style: AppTextStyles.small(
                                                weight:
                                                    rideController
                                                            .selectedTimeOption
                                                            .value ==
                                                        "Asap"
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),

                                        // ----- 15 min -----
                                        SizedBox(
                                          width: 100,
                                          height: 45,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              rideController.addMinutes(15);
                                              // print("yaha hm ma time dekh :${rideController.selectedTime}");
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  rideController
                                                          .selectedTimeOption
                                                          .value ==
                                                      "15 min"
                                                  ? CustomColor
                                                        .Button_background_Color
                                                  : Colors.black54,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text(
                                              "15 min",
                                              style: AppTextStyles.small(
                                                weight:
                                                    rideController
                                                            .selectedTimeOption
                                                            .value ==
                                                        "15 min"
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),

                                        // ----- 30 min -----
                                        SizedBox(
                                          width: 100,
                                          height: 45,
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                rideController.addMinutes(30),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  rideController
                                                          .selectedTimeOption
                                                          .value ==
                                                      "30 min"
                                                  ? CustomColor
                                                        .Button_background_Color
                                                  : Colors.black54,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text(
                                              "30 min",
                                              style: AppTextStyles.small(
                                                weight:
                                                    rideController
                                                            .selectedTimeOption
                                                            .value ==
                                                        "30 min"
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 25),

                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // ----- Date Picker -----
                                        Obx(
                                          () => GestureDetector(
                                            onTap: () => rideController
                                                .pickDate(context),
                                            child: Container(
                                              width: 150,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 12,
                                                  ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.black,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Flexible(
                                                    child: Text(
                                                      DateFormat(
                                                        'yyyy-MM-dd',
                                                      ).format(
                                                        rideController
                                                            .selectedDate
                                                            .value,
                                                      ),
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15),

                                        // ----- Time Picker (24-hour format) -----
                                        Obx(
                                          () => GestureDetector(
                                            onTap: () => rideController
                                                .pickTime(context),
                                            child: Container(
                                              width: 150,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 12,
                                                  ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.black,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.access_time_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Flexible(
                                                    child: Text(
                                                      rideController
                                                          .formattedTime24(), // FIXED: now 24-hour time
                                                      style:
                                                          AppTextStyles.regular(
                                                            weight:
                                                                FontWeight.bold,
                                                          ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 35),

                                  // ========================================================== Book Ride Button
                                  SizedBox(
                                    height: 55,
                                    width: 180,
                                    child: MyElevatedButton(
                                      text: '',
                                      onPressed: () {


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
                                                    "Book Ride",
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
                                                      color: Colors.yellow
                                                          .withOpacity(0.08),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .check_circle_rounded,
                                                      color: Colors.yellow,
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
                                                          rideController.getBookingApi();
                                                          if (rideController
                                                                  .selectedTimeOption
                                                                  .value ==
                                                              "ASAP") {
                                                            Get.offAllNamed(
                                                              routesName
                                                                  .RideSearchScreen,
                                                            );
                                                          } else {
                                                            Get.offAllNamed(
                                                              routesName
                                                                  .DeshBoard_Screen,
                                                            );
                                                          }
                                                          final profileController = Get.isRegistered<profileModelController>()
                                                              ? Get.find<profileModelController>()
                                                              : Get.put(profileModelController());
                                                          profileController.getuserProfile();

                                                          final homeC = Get.isRegistered<SwapController>()
                                                              ? Get.find<SwapController>()
                                                              : Get.put(SwapController());
                                                          homeC.resetRouteState();homeC.resetRouteState();
                                                          homeC.dropOff.clear();
                                                          homeC.pickUp.clear();
                                                          homeC.viaController1.clear();
                                                          homeC.viaController2.clear();
                                                          homeC.activeField.value = "";
                                                          homeC.update();

                                                        },
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: CustomColor
                                                            .textColor,
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

                                        /// /////////////////////////////////////////////////////////////////////
                                        // Get.dialog(
                                        //   Dialog(
                                        //     backgroundColor:
                                        //         CustomColor.Container_Colors,
                                        //     shape: RoundedRectangleBorder(
                                        //       borderRadius:
                                        //           BorderRadius.circular(30),
                                        //     ),
                                        //     child: Container(
                                        //       padding: const EdgeInsets.all(20),
                                        //       width:
                                        //           MediaQuery.of(
                                        //             context,
                                        //           ).size.width *
                                        //           0.8,
                                        //       constraints: BoxConstraints(
                                        //         maxHeight:
                                        //             MediaQuery.of(
                                        //               context,
                                        //             ).size.height *
                                        //             0.4,
                                        //       ),
                                        //       child: Column(
                                        //         mainAxisSize: MainAxisSize.min,
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.center,
                                        //         children: [
                                        //           const Icon(
                                        //             Icons.warning_amber,
                                        //             color: Colors.amberAccent,
                                        //             size: 60,
                                        //           ),
                                        //           const SizedBox(height: 15),
                                        //
                                        //           Padding(
                                        //             padding:
                                        //                 const EdgeInsets.symmetric(
                                        //                   horizontal: 10,
                                        //                 ),
                                        //             child: Text(
                                        //               CustomText
                                        //                   .Ride_book_ride_alert,
                                        //               textAlign:
                                        //                   TextAlign.center,
                                        //               style:
                                        //                   AppTextStyles.small(),
                                        //             ),
                                        //           ),
                                        //
                                        //           const SizedBox(height: 20),
                                        //
                                        //           Row(
                                        //             mainAxisAlignment:
                                        //                 MainAxisAlignment
                                        //                     .center,
                                        //             children: [
                                        //               CustomTextButton(
                                        //                 text: 'Yes',
                                        //                 onPressed: () {
                                        //                   rideController
                                        //                       .getBookingApi();
                                        //
                                        //                   if (rideController
                                        //                           .selectedTimeOption
                                        //                           .value ==
                                        //                       "ASAP") {
                                        //                     Get.offAllNamed(
                                        //                       routesName
                                        //                           .RideSearchScreen,
                                        //                     );
                                        //                   } else {
                                        //                     Get.offAllNamed(
                                        //                       routesName
                                        //                           .DeshBoard_Screen,
                                        //                     );
                                        //                   }
                                        //                 },
                                        //                 backgroundColor:
                                        //                     Colors.red,
                                        //                 textColor: CustomColor
                                        //                     .Button_Text_Color,
                                        //                 borderRadius: 8,
                                        //                 elevation: 2,
                                        //                 fontSize: 15,
                                        //                 fontWeight:
                                        //                     FontWeight.bold,
                                        //                 padding:
                                        //                     const EdgeInsets.symmetric(
                                        //                       horizontal: 16,
                                        //                       vertical: 10,
                                        //                     ),
                                        //               ),
                                        //               const SizedBox(width: 20),
                                        //               CustomTextButton(
                                        //                 text: '  No  ',
                                        //                 onPressed: () {
                                        //                   Get.back();
                                        //                   Get.back();
                                        //                 },
                                        //                 backgroundColor: CustomColor
                                        //                     .Button_background_Color,
                                        //                 textColor: Colors.white,
                                        //                 borderRadius: 8,
                                        //                 elevation: 2,
                                        //                 fontSize: 15,
                                        //                 fontWeight:
                                        //                     FontWeight.bold,
                                        //                 padding:
                                        //                     const EdgeInsets.symmetric(
                                        //                       horizontal: 16,
                                        //                       vertical: 10,
                                        //                     ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // );

                                        rideController.calculateFareApi();
                                      },
                                      textWidget: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "Book Ride",
                                          style: AppTextStyles.medium(
                                            size: 25,
                                            weight: FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      textWidget: FittedBox(
                        // fit: BoxFit.scaleDown,
                        child: Text(
                          "Schedule Booking",
                          style: AppTextStyles.medium(
                            size: 25,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
