import 'package:customer/View/Reebook/reebooking_confirmation_screen.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:customer/View/yourtrip/booking_history_model/bookingHistorymodel.dart';
import 'package:customer/View/yourtrip/widget/card%20widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controller/Home/home-controller.dart';
import '../../Controller/Ride/RideController.dart';
import '../../Controller/reebooking/reebookingcontroller.dart';
import '../../Routing/routes_name.dart';
import '../Deshboard/map_widget/map_polyLine.dart';
import '../Deshboard/map_widget/open_street_map.dart';
import '../Widgets/all_text.dart';
import '../Widgets/color.dart';
import '../Widgets/elevat_button.dart';
import '../Widgets/text_button.dart';
import '../Widgets/textformfield.dart';
import '../payments/paymentscreen.dart';
import '../profile/controller/profile_controller.dart';
import '../rides/ridesearchscreen.dart';
import 'extras.dart';

class ReebookingScreen extends StatefulWidget {
  ReebookingScreen({super.key});

  @override
  State<ReebookingScreen> createState() => _ReebookingScreenState();
}

class _ReebookingScreenState extends State<ReebookingScreen> {
  final BookingController reebookingController = Get.put(BookingController());

  final rideController = Get.isRegistered<RideController>()
      ? Get.find<RideController>()
      : Get.put(RideController());
  late Booking trip;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   trip = Get.arguments;
  //  reebookingController.getVehicleTypes();
  //
  // }
  @override
  void initState() {
    super.initState();

    trip = Get.arguments;

    reebookingController.getVehicleTypes().then((_) {
      reebookingController.calculateFareAllVehiclesApi(trip);
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
              ///
              Expanded(
                child: Stack(
                  children: [
                    // ============================ Map
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: MapScreen(),
                    ),

                    // ============================ Back Button
                    Positioned(
                      top: 40,
                      left: 10,
                      child: Container(
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
                    ),

                    // ============================ Draggable Vehicle List
                    DraggableScrollableSheet(
                      initialChildSize: 0.3, // 50% of screen initially
                      minChildSize: 0.3, // can shrink to 30%
                      maxChildSize: 0.8, // can drag up to 80%
                      builder: (context, scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 30, 1, 44).withOpacity(0.9),
                                Color.fromARGB(255, 227, 194, 242),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Column(
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
                              Expanded(
                                child: GetBuilder<BookingController>(
                                  builder: (controller) {
                                    if (controller.loading) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    if (controller.vehicles.isEmpty) {
                                      return Center(
                                        child: Text("No vehicles found"),
                                      );
                                    }

                                    return ListView.builder(
                                      controller: scrollController,
                                      itemCount: controller.vehicles.length,
                                      itemBuilder: (context, index) {
                                        var vehicle =
                                        controller.vehicles[index];

                                        return Obx(() {
                                          bool isSelected =
                                              controller
                                                  .selectedVehicleIndex
                                                  .value ==
                                                  index;

                                          return GestureDetector(
                                            onTap: () {
                                              //controller.selectedVehicleIndex.value = index;
                                              controller.selectItem(index);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 16,
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
                                                borderRadius:
                                                BorderRadius.circular(15),
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
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  /// 🔹 Vehicle Info
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        ("${vehicle.name ?? ""}").toUpperCase(),
                                                        style:
                                                        AppTextStyles.regular(weight: FontWeight.bold),
                                                      ),

                                                      SizedBox(height: 5),

                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            color: CustomColor
                                                                .Icon_Color,
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
                                                            color: CustomColor
                                                                .Icon_Color,
                                                            size: 18,
                                                          ),
                                                          Text(
                                                            " x${vehicle.luggages ?? 0}",
                                                            style: AppTextStyles.regular(
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
                                                        color: CustomColor
                                                            .Icon_Color,
                                                        size: 32,
                                                      ),

                                                      SizedBox(width: 10),

                                                      controller.fareLoading
                                                          ? const SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                        CircularProgressIndicator(
                                                          strokeWidth:
                                                          2,
                                                        ),
                                                      )
                                                          : Column(
                                                        children: [
                                                          Text(
                                                            "£${(controller.vehicleFareMap[vehicle.id] ?? 0).toStringAsFixed(2)}",
                                                            style: AppTextStyles.regular(
                                                              size: 18,
                                                              weight:
                                                              FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Estimated",
                                                            style: AppTextStyles.small(),
                                                          ),
                                                        ],
                                                      ),

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
                                          );
                                        });
                                      },
                                    );
                                  },
                                ),

                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                height: MediaQuery.of(context).size.height * 0.14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(15),
                  ),
                  color: CustomColor.Container_Colors,
                ),

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        //color: CustomColor.Container_Colors,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(PaymentScreen());
                              },
                              child: BottomButton(
                                icon: Icons.credit_card,
                                button_name: "Card",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(ExtrasScreen());
                              },
                              child: BottomButton(
                                icon: Icons.add_circle_outline,
                                button_name: "Extras",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print(
                                  "======================================================================${reebookingController.selectedVehicleId}",
                                );
                                print(
                                  "======================================================================${reebookingController.selectedPassengers}",
                                );

                                Get.bottomSheet(
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
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 8),
                                        Container(
                                          height: 5,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: CustomColor.Icon_Color,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
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
                                                  onPressed: () =>
                                                      reebookingController
                                                          .setASAP(),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    reebookingController
                                                        .selectedTimeOption
                                                        .value ==
                                                        "ASAP"
                                                        ? CustomColor
                                                        .Button_background_Color
                                                        : Colors.black54,
                                                    elevation: 2,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "ASAP",
                                                    style: AppTextStyles.small(
                                                      weight:
                                                      reebookingController
                                                          .selectedTimeOption
                                                          .value ==
                                                          "ASAP"
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
                                                  onPressed: () =>
                                                      reebookingController
                                                          .addMinutes(15),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    reebookingController
                                                        .selectedTimeOption
                                                        .value ==
                                                        "15 min"
                                                        ? CustomColor
                                                        .Button_background_Color
                                                        : Colors.black54,
                                                    elevation: 2,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "15 min",
                                                    style: AppTextStyles.small(
                                                      weight:
                                                      reebookingController
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
                                                      reebookingController
                                                          .addMinutes(30),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    reebookingController
                                                        .selectedTimeOption
                                                        .value ==
                                                        "30 min"
                                                        ? CustomColor
                                                        .Button_background_Color
                                                        : Colors.black54,
                                                    elevation: 2,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "30 min",
                                                    style: AppTextStyles.small(
                                                      weight:
                                                      reebookingController
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

                                        /// ---------- Date & Time ----------

                                        Center(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              // ----- Date Picker -----
                                              Obx(
                                                    () => GestureDetector(
                                                  onTap: () =>
                                                      reebookingController
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
                                                      BorderRadius.circular(
                                                        10,
                                                      ),
                                                      color: Colors.black,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.calendar_today,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            DateFormat(
                                                              'yyyy-MM-dd',
                                                            ).format(
                                                              reebookingController
                                                                  .selectedDate
                                                                  .value,
                                                            ),
                                                            style:
                                                            const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
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
                                                  onTap: () =>
                                                      reebookingController
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
                                                      BorderRadius.circular(
                                                        10,
                                                      ),
                                                      color: Colors.black,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.access_time,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            reebookingController
                                                                .formattedTime24(), // FIXED: now 24-hour time
                                                            style:
                                                            AppTextStyles.regular(
                                                              weight:
                                                              FontWeight
                                                                  .bold,
                                                            ),
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
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
                                          width: 250,
                                          child: MyElevatedButton(
                                            text: '',
                                            onPressed: () {
                                              // Get.to(RideSearchScreen());

                                              reebookingController.calculateHistoryBookingFareApi(trip,
                                              );
                                              Get.dialog(
                                                Dialog(
                                                  backgroundColor:
                                                  Colors.transparent,
                                                  insetPadding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: Container(
                                                    height: 300,
                                                    padding:
                                                    const EdgeInsets.all(
                                                      20,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: CustomColor
                                                          .Container_Colors,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        20,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                      MainAxisSize.min,
                                                      children: [
                                                        /// TITLE
                                                        Text(
                                                          "Book Ride",
                                                          textAlign:
                                                          TextAlign.center,
                                                          style:
                                                          AppTextStyles.heading(),
                                                        ),

                                                        const SizedBox(
                                                          height: 12,
                                                        ),

                                                        /// ICON
                                                        Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration:
                                                          BoxDecoration(
                                                            color: Colors
                                                                .yellow
                                                                .withOpacity(
                                                              0.08,
                                                            ),
                                                            shape: BoxShape
                                                                .circle,
                                                          ),
                                                          child: const Icon(
                                                            Icons
                                                                .check_circle_rounded,
                                                            color:
                                                            Colors.yellow,
                                                            size: 34,
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                          height: 12,
                                                        ),

                                                        /// DESCRIPTION
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                          ),
                                                          child: Text(
                                                            CustomText
                                                                .Ride_book_ride_alert,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                            AppTextStyles.regular(),
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                          height: 20,
                                                        ),

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
                                                              TextAlign
                                                                  .center,
                                                              rowMainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              columnCrossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,

                                                              onPressed: () async {
                                                                Get.dialog(
                                                                  const Center(
                                                                    child: CircularProgressIndicator(),
                                                                  ),
                                                                  barrierDismissible: false,
                                                                );

                                                                await reebookingController.historyBookingApi(trip);

                                                                await Get.find<profileModelController>().getuserProfile();

                                                                if (reebookingController.selectedTimeOption.value == "ASAP") {
                                                                  rideController.isFromHistory = true;

                                                                  Navigator.of(context).pop(); // Loader close

                                                                  Get.offAllNamed(routesName.RideSearchScreen);
                                                                } else {
                                                                  // await reebookingController.getReBookingById();

                                                                  //Get.back(); // Loader close
                                                                  Get.offAll(()=> ReeBookingConfirmationScreen());
                                                                  // Get.offAllNamed(routesName.DeshBoard_Screen);
                                                                }
                                                              },
                                                              backgroundColor:
                                                              Colors.red,
                                                              textColor:
                                                              CustomColor
                                                                  .textColor,
                                                              borderRadius: 10,
                                                              elevation: 2,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                            ),

                                                            const SizedBox(
                                                              width: 15,
                                                            ),

                                                            /// NO BUTTON
                                                            CustomTextButton(
                                                              width: 70,
                                                              height: 42,
                                                              text: ' No ',

                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                              rowMainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              columnCrossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,

                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },

                                                              backgroundColor:
                                                              CustomColor
                                                                  .Button_background_Color,
                                                              textColor:
                                                              CustomColor
                                                                  .textColor,
                                                              borderRadius: 10,
                                                              elevation: 2,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
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
                                );
                              },
                              child: BottomButton(
                                icon: Icons.schedule,
                                button_name: "Schedule",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: CustomColor.Container_Colors,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    width: double.infinity,
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.5,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 8),
                                          Center(
                                            child: Container(
                                              height: 5,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: CustomColor.Icon_Color,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),

                                          Row(
                                            children: [
                                              SizedBox(width: 20),

                                              IconButton(
                                                icon: Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.red,
                                                ),
                                                iconSize: 35,
                                                onPressed: () => Navigator.of(context).pop(),
                                              ),

                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "ADD ORDER DETAILS",
                                                    style:
                                                    AppTextStyles.medium(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(width: 48),
                                            ],
                                          ),

                                          SizedBox(
                                            height:
                                            MediaQuery.of(
                                              context,
                                            ).size.height *
                                                0.03,
                                          ),

                                          const Text(
                                            "Order Number",
                                            style: TextStyle(
                                              color: CustomColor.textColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          CustomTextField(
                                            hintText: "Type your order number",
                                            borderRadius: 15,
                                            fillColor:
                                            CustomColor.textfield_fill,
                                          ),

                                          SizedBox(
                                            height:
                                            MediaQuery.of(
                                              context,
                                            ).size.height *
                                                0.015,
                                          ),
                                          Text(
                                            "Name on order",
                                            style: AppTextStyles.medium(),
                                          ),
                                          const SizedBox(height: 3),
                                          CustomTextField(
                                            hintText: "Type name on order",
                                            borderRadius: 15,
                                            fillColor:
                                            CustomColor.textfield_fill,
                                          ),

                                          SizedBox(
                                            height:
                                            MediaQuery.of(
                                              context,
                                            ).size.height *
                                                0.025,
                                          ),

                                          Center(
                                            child: SizedBox(
                                              height: 55,
                                              width: 250,
                                              child: MyElevatedButton(
                                                text: 'DONE',
                                                textWidget: FittedBox(
                                                  child: Text(
                                                    "Done",
                                                    style: AppTextStyles.medium(
                                                      size: 25,
                                                      weight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 100),
                                        ],
                                      ),
                                    ),
                                  ),
                                );


                              },
                              child: BottomButton(
                                icon: Icons.shopping_cart_outlined,
                                button_name: "Shopping",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed('/PromoScreen');
                              },
                              child: BottomButton(
                                icon: Icons.local_offer_outlined,
                                button_name: "Promo",
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Container(
                      //   margin: EdgeInsets.only(top: 15),
                      //     // margin: EdgeInsets.symmetric(vertical: 8),
                      //   //color: CustomColor.Container_Colors,
                      //   height: 55,
                      //   width: 250  ,
                      //   child: MyElevatedButton(
                      //     text: '',
                      //     textWidget: FittedBox(
                      //       child: Text("Confirm Booking",style: AppTextStyles.medium(size: 25 ,weight: FontWeight.bold),),
                      //     ),
                      //     onPressed: () {  },
                      //   ),
                      // ),
                    ],
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

// =========================================================== tab bar  Button

class BottomButton extends StatelessWidget {
  final IconData icon;
  final String button_name;
  const BottomButton({required this.icon, required this.button_name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: CustomColor.Icon_Color, size: 22),
        SizedBox(height: 3),
        Text(button_name, style: AppTextStyles.small()),
      ],
    );
  }
}
