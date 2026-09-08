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
import 'booking_confirmation_screen.dart';
import 'ridesearchscreen.dart';
import '../Deshboard/Home/drivernotes_alert.dart';
import '../Deshboard/Home/child_seat_dialog.dart';

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

  final homeC = Get.isRegistered<SwapController>()
      ? Get.find<SwapController>()
      : Get.put(SwapController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await rideController.getVehicleTypes();
      await rideController.calculateFareAllVehiclesApi();
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Get.find<RideController>().getVehicleTypes();
  //
  //   });
  // }

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
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: CustomColor.Icon_Color,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),

                            Expanded(
                              child: Center(
                                child: Text(
                                  CustomText.Ride_Info,
                                  style: AppTextStyles.heading(
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // Back button ke barabar khali jagah
                            const SizedBox(width: 48),
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
                                final fare =
                                    rideController.vehicleFareMap[vehicle.id] ??
                                    0.0;

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
                                              style: AppTextStyles.regular(
                                                weight: FontWeight.bold,
                                              ),
                                            ),

                                            SizedBox(height: 5),

                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  color: CustomColor.Icon_Color,
                                                  size: 18,
                                                ),
                                                Text(
                                                  " x${vehicle.passengers ?? 0}",
                                                  style: AppTextStyles.medium(),
                                                ),

                                                SizedBox(width: 10),

                                                Icon(
                                                  Icons.work,
                                                  color: CustomColor.Icon_Color,
                                                  size: 18,
                                                ),
                                                Text(
                                                  " x${vehicle.luggages ?? 0}",
                                                  style: AppTextStyles.regular(
                                                    color:
                                                        CustomColor.Text_Color,
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

                                            const SizedBox(width: 12),

                                            rideController.fareLoading
                                                ? const SizedBox(
                                                    width: 18,
                                                    height: 18,
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                        ),
                                                  )
                                                : Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "£${fare.toStringAsFixed(2)}",
                                                        style:
                                                            AppTextStyles.regular(
                                                              weight: FontWeight.bold,
                                                              size: 14,
                                                            ),
                                                      ),
                                                      Text(
                                                        "Estimated",
                                                        style:
                                                        AppTextStyles.small(),
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
                      // Get.to(BookingConfirmationScreen());
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
                          height: 470,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // ----- Date Picker -----
                                      Obx(
                                        () => GestureDetector(
                                          onTap: () =>
                                              rideController.pickDate(context),
                                          child: Container(
                                            width: 150,
                                            padding: const EdgeInsets.symmetric(
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

                                      ///----- Time Picker (24-hour format) -----


                                      Obx(
                                            () => GestureDetector(
                                          onTap: () => rideController.pickTime(context),
                                          child: Container(
                                            width: 150,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.access_time_outlined,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    "${rideController.selectedTime.value.hour.toString().padLeft(2, '0')}:${rideController.selectedTime.value.minute.toString().padLeft(2, '0')}",
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyles.regular(
                                                      weight: FontWeight.bold,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Obx(
                                      //   () => GestureDetector(
                                      //     onTap: () =>
                                      //         rideController.pickTime(context),
                                      //     child: Container(
                                      //       width: 150,
                                      //       padding: const EdgeInsets.symmetric(
                                      //         horizontal: 10,
                                      //         vertical: 12,
                                      //       ),
                                      //       decoration: BoxDecoration(
                                      //         borderRadius:
                                      //             BorderRadius.circular(10),
                                      //         color: Colors.black,
                                      //       ),
                                      //       child: Row(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment.center,
                                      //         children: [
                                      //           const Icon(
                                      //             Icons.access_time_outlined,
                                      //             color: Colors.white,
                                      //             size: 20,
                                      //           ),
                                      //           const SizedBox(width: 6),
                                      //           Flexible(
                                      //             child: Text(
                                      //               rideController
                                      //                   .formattedTime24(), // FIXED: now 24-hour time
                                      //               style:
                                      //                   AppTextStyles.regular(
                                      //                     weight:
                                      //                         FontWeight.bold,
                                      //                   ),
                                      //               overflow:
                                      //                   TextOverflow.ellipsis,
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // ========= Child Seat / Driver Notes / Cash Row ==========
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [

                                        // ------ Child Seat ------
                                        Expanded(
                                          child: _ScheduleOptionButton(
                                            icon: Icons.child_friendly_rounded,
                                            label: 'Child Seat',
                                            subLabel: 'Add Child Seat',
                                            onTap: () {
                                              showChildSeatDialog(context);
                                            },
                                          ),
                                        ),

                                        const SizedBox(width: 10),

                                        // ------ Driver Notes ------
                                        Expanded(
                                          child: _ScheduleOptionButton(
                                            icon: Icons.description_outlined,
                                            label: 'Driver Notes',
                                            subLabel: 'Add Note',
                                            onTap: () {
                                              showDriverNotesDialog(context);
                                            },
                                          ),
                                        ),

                                        const SizedBox(width: 10),

                                        // ------ Cash / Payment ------
                                        Expanded(
                                          child: _ScheduleOptionButton(
                                            icon: Icons.account_balance_wallet_outlined,
                                            label: 'Cash',
                                            subLabel: 'Payment',
                                            onTap: () {
                                              // Get.bottomSheet(
                                              //   const _PaymentBottomSheet(),
                                              //   isScrollControlled: true,
                                              //   ignoreSafeArea: false,
                                              //   backgroundColor: Colors.transparent,
                                              //   enterBottomSheetDuration: const Duration(milliseconds: 250),
                                              //   exitBottomSheetDuration: const Duration(milliseconds: 200),
                                              // );
                                            },
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 18),

                                // ========================================================== Book Ride Button
                                SizedBox(
                                  height: 55,
                                  width: 180,
                                  child: MyElevatedButton(
                                    text: '',
                                    onPressed: () {

                                      rideController.calculateFareApi();

                                      // if (rideController.selectedTimeOption.value != "ASAP") {
                                      //
                                      //   Get.back(); // BottomSheet close
                                      //
                                      //   Get.to(() =>  BookingConfirmationScreen());
                                      //
                                      //   return;
                                      // }
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
                                              color:
                                              CustomColor.Container_Colors,
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
                                                    Icons.check_circle_rounded,
                                                    color: Colors.yellow,
                                                    size: 34,
                                                  ),
                                                ),

                                                const SizedBox(height: 12),

                                                /// Fare
                                                // Padding(
                                                //   padding:
                                                //   const EdgeInsets.symmetric(
                                                //     horizontal: 10,
                                                //   ),
                                                //   child: Text("Total Fare "
                                                //       " ${rideController.totalFare} ",
                                                //     textAlign:
                                                //     TextAlign.center,
                                                //     style:
                                                //     AppTextStyles.regular(),
                                                //   ),
                                                // ),
                                                /// DESCRIPTION
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  child: Text(
                                                    CustomText
                                                        .Ride_book_ride_alert,
                                                    textAlign: TextAlign.center,
                                                    style:
                                                    AppTextStyles.regular(),
                                                  ),
                                                ),

                                                const SizedBox(height: 20),

                                                /// BUTTONS
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    /// YES BUTTON
                                                    CustomTextButton(
                                                      width: 70,
                                                      height: 42,
                                                      text: 'Yes',

                                                      textAlign:TextAlign.center,
                                                      rowMainAxisAlignment: MainAxisAlignment.center,
                                                      columnCrossAxisAlignment: CrossAxisAlignment.center,

                                                      onPressed: () async{
                                                        // rideController.getBookingApi();
                                                        // if (rideController.selectedTimeOption.value == "ASAP") {
                                                        //   Get.offAllNamed(routesName.RideSearchScreen,);
                                                        // } else {
                                                        //   //rideController.getBookingById();
                                                        //   Get.offAll(BookingConfirmationScreen());
                                                        //   // Get.offAllNamed(
                                                        //   //   routesName.DeshBoard_Screen,
                                                        //   // );
                                                        // }
                                                        Get.dialog(
                                                          const Center(
                                                            child: CircularProgressIndicator(),
                                                          ),
                                                          barrierDismissible: false,
                                                        );

                                                        await rideController.getBookingApi();

                                                        //Get.back(); // Loader close

                                                        if (rideController.selectedTimeOption.value == "ASAP") {
                                                          Get.offAllNamed(routesName.RideSearchScreen);
                                                        } else {
                                                          Get.offAll(BookingConfirmationScreen());
                                                        }



                                                        // homeC.resetRouteState();homeC.resetRouteState();
                                                        // homeC.dropOff.clear();
                                                        // homeC.pickUp.clear();
                                                        // homeC.viaController1.clear();
                                                        // homeC.viaController2.clear();
                                                        // homeC.activeField.value = "";

                                                      },
                                                      backgroundColor:
                                                      Colors.red,
                                                      textColor:
                                                      CustomColor.textColor,
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
                                                        Navigator.of(context).pop();
                                                      },

                                                      backgroundColor: CustomColor
                                                          .Button_background_Color,
                                                      textColor:
                                                      CustomColor.textColor,
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

                                     // rideController.calculateFareApi();
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
    );
  }
}

/// ScheduleBottomSheet ma use hone wala option button widget
/// image ma Child Seat, Driver Notes, Cash jaisa
class _ScheduleOptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subLabel;
  final VoidCallback onTap;

  const _ScheduleOptionButton({
    required this.icon,
    required this.label,
    required this.subLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withOpacity(0.12),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with green "+" badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white70,
                    size: 22,
                  ),
                ),
                // Green "+" badge — top right
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Color(0xFF34A853), // green
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Main label
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.small(
                size: 12,
                weight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            // Sub label
            Text(
              subLabel,
              textAlign: TextAlign.center,
              style: AppTextStyles.small(
                size: 10,
                color: const Color(0xFF34A853),
                weight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────
/// Payment BottomSheet — image jaisi card payment form
/// Driver Notes jaisi dark purple gradient theme
/// ─────────────────────────────────────────────────────────────────
class _PaymentBottomSheet extends StatefulWidget {
  const _PaymentBottomSheet();

  @override
  State<_PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<_PaymentBottomSheet> {
  final _cardNumberCtrl = TextEditingController();
  final _mmyyCtrl = TextEditingController();
  final _cvcCtrl = TextEditingController();
  final _countryCtrl = TextEditingController(text: 'United Kingdom');
  final _postalCtrl = TextEditingController();

  @override
  void dispose() {
    _cardNumberCtrl.dispose();
    _mmyyCtrl.dispose();
    _cvcCtrl.dispose();
    _countryCtrl.dispose();
    _postalCtrl.dispose();
    super.dispose();
  }

  // Card number format: XXXX XXXX XXXX XXXX
  String _formatCardNumber(String input) {
    final digits = input.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  // MM/YY format
  String _formatMMYY(String input) {
    final digits = input.replaceAll('/', '');
    if (digits.length >= 3) {
      return '${digits.substring(0, 2)}/${digits.substring(2)}';
    }
    return input;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: CustomColor.Container_Colors,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      // Shrink to content + keyboard height only
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.92,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset > 0 ? bottomInset + 12 : 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            // ── Drag handle ──
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ── Header row ──
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Add card',
                    style: AppTextStyles.heading(
                      size: 22,
                      weight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white70, size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── Card Information ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Card information',
                  style: AppTextStyles.small(
                    // color: const Color.fromARGB(255, 180, 120, 220),
                    color: const Color(0xFF34A853),
                    weight: FontWeight.w600,
                    size: 11,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.camera_alt_outlined,
                      //  color: Color.fromARGB(255, 180, 120, 220),
                        color: const Color(0xFF34A853),
                        size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Scan card',
                      style: AppTextStyles.small(
                        // color: const Color.fromARGB(255, 180, 120, 220),
                        color: const Color(0xFF34A853),
                        size: 11,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Card number field
            _paymentField(
              controller: _cardNumberCtrl,
              hintText: 'Card number',
              keyboardType: TextInputType.number,
              maxLength: 19,
              suffixIcon: const Icon(Icons.credit_card, color: Colors.white38, size: 20),
              onChanged: (val) {
                final formatted = _formatCardNumber(val.replaceAll(' ', ''));
                if (formatted != val) {
                  _cardNumberCtrl.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(offset: formatted.length),
                  );
                }
              },
              topRadius: true,
              bottomRadius: false,
            ),

            const SizedBox(height: 1),

            // MM/YY + CVC row
            Row(
              children: [
                Expanded(
                  child: _paymentField(
                    controller: _mmyyCtrl,
                    hintText: 'MM / YY',
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    onChanged: (val) {
                      final formatted = _formatMMYY(val.replaceAll('/', ''));
                      if (formatted != val) {
                        _mmyyCtrl.value = TextEditingValue(
                          text: formatted,
                          selection: TextSelection.collapsed(offset: formatted.length),
                        );
                      }
                    },
                    topRadius: false,
                    bottomRadius: false,
                    rightBorder: true,
                  ),
                ),
                Expanded(
                  child: _paymentField(
                    controller: _cvcCtrl,
                    hintText: 'CVC',
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    suffixIcon: const Icon(Icons.help_outline, color: Colors.white38, size: 18),
                    topRadius: false,
                    bottomRadius: true,
                    leftBorder: true,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Billing Address ──
            Text(
              'Billing address',
              style: AppTextStyles.small(
                // color: const Color.fromARGB(255, 180, 120, 220),
                color: const Color(0xFF34A853),
                weight: FontWeight.w600,
                size: 11,
              ),
            ),
            const SizedBox(height: 8),

            // Country field
            _paymentField(
              controller: _countryCtrl,
              hintText: 'Country or region',
              suffixIcon: const Icon(Icons.keyboard_arrow_down, color: Colors.white54, size: 22),
              topRadius: true,
              bottomRadius: false,
            ),
            const SizedBox(height: 1),

            // Postal code field
            _paymentField(
              controller: _postalCtrl,
              hintText: 'Postal code',
              keyboardType: TextInputType.text,
              topRadius: false,
              bottomRadius: true,
            ),

            const SizedBox(height: 24),

            // ── Pay Button ──
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // Payment action here
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.Button_background_Color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pay',
                      style: AppTextStyles.medium(
                        size: 17,
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.lock_outline, color: Colors.white70, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      );
  }

  /// Reusable payment text field with project theme
  Widget _paymentField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    Widget? suffixIcon,
    ValueChanged<String>? onChanged,
    bool topRadius = false,
    bool bottomRadius = false,
    bool rightBorder = false,
    bool leftBorder = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.only(
          topLeft: topRadius && !leftBorder ? const Radius.circular(12) : Radius.zero,
          topRight: topRadius && !rightBorder ? const Radius.circular(12) : Radius.zero,
          bottomLeft: bottomRadius && !leftBorder ? const Radius.circular(12) : Radius.zero,
          bottomRight: bottomRadius && !rightBorder ? const Radius.circular(12) : Radius.zero,
        ),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.12), width: 1),
          bottom: BorderSide(color: Colors.white.withOpacity(0.12), width: 1),
          left: leftBorder
              ? BorderSide(color: Colors.white.withOpacity(0.12), width: 1)
              : BorderSide(color: Colors.white.withOpacity(0.12), width: 1),
          right: rightBorder
              ? BorderSide(color: Colors.white.withOpacity(0.12), width: 1)
              : BorderSide(color: Colors.white.withOpacity(0.12), width: 1),
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        onChanged: onChanged,
        style: AppTextStyles.regular(color: Colors.white, size: 15),
        cursorColor: const Color.fromARGB(255, 180, 120, 220),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.regular(color: Colors.white38, size: 14),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
    );
  }
}
