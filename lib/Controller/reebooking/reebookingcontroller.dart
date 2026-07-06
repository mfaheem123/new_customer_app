import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' hide FormData, Response;

import '../../View/Widgets/color.dart';
import '../../View/profile/controller/profile_controller.dart';
import '../../View/rides/model/ride_model/get_vehicle_model.dart';
import '../../View/textstyle/apptextstyle.dart';
import '../../View/yourtrip/booking_history_model/bookingHistorymodel.dart' hide VehicleType;
import '../../api_servies/api_servies.dart';

class BookingController extends GetxController {

  final profileController = Get.isRegistered<profileModelController>()
      ? Get.find<profileModelController>()
      :  Get.put(profileModelController());


  RxInt selectedVehicleIndex = (0).obs;
  RxInt selectedVehicleId = 0.obs;
  RxInt selectedPassengers = 0.obs;
  String bookingId = "0" ;

  /// Item select (index + ID + passengers)
  void selectItem(int index) {
    selectedVehicleIndex.value = index;
    setSelectedVehicleId(index);
    update(); // UI refresh
  }

  /// Vehicle ID & passengers get function
  void setSelectedVehicleId(int index) {
    final vehicle = vehicleData?.vehicleTypes?[index];

    if (vehicle != null) {
      if (vehicle.id != null) selectedVehicleId.value = vehicle.id!;
      if (vehicle.passengers != null) {
        selectedPassengers.value = vehicle.passengers!;
      }
    }
  }


  // final  vehicleList = [
  //   {
  //     "name": "Any Vehicle",
  //     "people": 4,
  //     "bags": 2,
  //     "cases": 2,
  //     "price": 172.00,
  //   },
  //   {
  //     "name": "Saloon Car",
  //     "people": 4,
  //     "bags": 2,
  //     "cases": 2,
  //     "price": 172.00,
  //   },
  //   {
  //     "name": "Luxury Car",
  //     "people": 4,
  //     "bags": 3,
  //     "cases": 2,
  //     "price": 200.00,
  //   },
  // ];
  List<VehicleType> get vehicles => vehicleData?.vehicleTypes ?? [];

  GetVehicleModel? vehicleData;
   bool loading = false;


  Future<void> getVehicleTypes() async {
    loading = true;
    update();

    var response = await ApiService.get(
        "vehicle-type/get",
        auth: true,
        isProgressShow: false
    );

    if (response != null && response.statusCode == 200) {
      vehicleData = GetVehicleModel.fromJson(response.data);
      if (vehicles.isNotEmpty) {
        selectItem(0); // ✅ auto select
      }
    }
    print(response!.data);
    loading = false;
    update();
  }

  Map<int, double> vehicleFareMap = {};
  bool fareLoading = false;

  Future<void> calculateFareAllVehiclesApi(Booking trip) async {
    fareLoading = true;
    update();

    Map<String, dynamic> dataMap = {
      "miles": trip.miles,
      "pickup_date": DateFormat('yyyy-M-d').format(selectedDate.value),
      "pickup_time": formattedTime24(),
      "pickup": trip.pickup,
      "dropoff": trip.dropoff,
      "journey_type_id": trip.journeyTypeId ?? 1,
      "pickup_latitude": trip.pickupLatitude,
      "pickup_longitude": trip.pickupLongitude,
    };

    FormData formData = FormData.fromMap(dataMap);

    Response? response = await ApiService.post(
      formData,
      "fares/calculate-fare-all-vehicles",
      multiPart: true,
      auth: true,
      isProgressShow: true,
    );

    if (response != null && response.statusCode == 200) {
      vehicleFareMap.clear();

      for (var item in response.data["data"]) {
        vehicleFareMap[item["vehicle_type_id"]] =
            (item["total_fare"] as num).toDouble();
      }
    }

    fareLoading = false;
    update();
  }




// ----------------- Date & Time -----------------
var selectedDate = DateTime.now().obs;
var selectedTime = TimeOfDay.now().obs;

// Track which quick-time button is selected ("ASAP", "15 min", "30 min")
var selectedTimeOption = ''.obs;

// ----------------- Pick Date -----------------
Future<void> pickDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate.value,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );

  if (picked != null && picked != selectedDate.value) {
    selectedDate.value = picked;
    selectedTimeOption.value = ''; // clear highlight when user picks manually
  }
}

// ----------------- Pick Time -----------------
  Future<void> pickTime(BuildContext context) async {
    int hour = selectedTime.value.hour;
    int minute = selectedTime.value.minute;

    const Color backgroundColor = Color(0xFF0F172A);
    const Color cardColor = Color(0xFF1E293B);
    const Color accentColor = Color(0xFFF59E0B);

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: 470,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            decoration: const BoxDecoration(
              // color: backgroundColor,
              color:CustomColor.Container_Colors,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),

                /// Drag Handle
                Container(
                  width: 55,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

               // const SizedBox(height: 25),

                // /// Time Icon
                // Container(
                //   height: 75,
                //   width: 75,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: accentColor.withOpacity(.15),
                //     border: Border.all(
                //       color: accentColor.withOpacity(.35),
                //     ),
                //   ),
                //   child: const Icon(
                //     Icons.access_time_filled_rounded,
                //     color: accentColor,
                //     size: 38,
                //   ),
                // ),

                const SizedBox(height: 18),

                const Text(
                  "Schedule Pickup",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .4,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Choose your preferred pickup time",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 28),

                /// Picker Card
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white10,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.35),
                        blurRadius: 25,
                        offset: const Offset(0, 15),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoPicker(
                          backgroundColor: Colors.transparent,
                          itemExtent: 50,
                          scrollController: FixedExtentScrollController(
                            initialItem: hour,
                          ),
                          selectionOverlay: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: accentColor.withOpacity(.12),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: accentColor.withOpacity(.45),
                              ),
                            ),
                          ),
                          onSelectedItemChanged: (value) {
                            setState(() => hour = value);
                          },
                          children: List.generate(
                            24,
                                (index) => Center(
                              child: Text(
                                index.toString().padLeft(2, "0"),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const Text(
                        ":",
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Expanded(
                        child: CupertinoPicker(
                          backgroundColor: Colors.transparent,
                          itemExtent: 50,
                          scrollController: FixedExtentScrollController(
                            initialItem: minute,
                          ),
                          selectionOverlay: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: accentColor.withOpacity(.12),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: accentColor.withOpacity(.45),
                              ),
                            ),
                          ),
                          onSelectedItemChanged: (value) {
                            setState(() => minute = value);
                          },
                          children: List.generate(
                            60,
                                (index) => Center(
                              child: Text(
                                index.toString().padLeft(2, "0"),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //const Spacer(),
                SizedBox(height: 25,),

                SizedBox(
                  width: 250,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.Button_background_Color,
                      foregroundColor: CustomColor.textColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      selectedTime.value = TimeOfDay(
                        hour: hour,
                        minute: minute,
                      );

                      selectedTimeOption.value = "";

                      Get.back();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_rounded),
                        SizedBox(width: 10),
                        Text(
                          "Confirm Pickup Time",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }
//   Future<void> pickTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime.value,
//
//       builder: (BuildContext context, Widget? child) {
//         return MediaQuery(
//           data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
//           child: child!,
//         );
//       },
//
//     );
//
//     if (picked != null && picked != selectedTime.value) {
//       selectedTime.value = picked;
//       selectedTimeOption.value = '';
//     }
//   }
// ----------------- Add Minutes (15 / 30) -----------------
  void addMinutes(int minutesToAdd) {
    final now = DateTime.now(); // 👈 ALWAYS current time

    final newTime = now.add(Duration(minutes: minutesToAdd));

    selectedDate.value = DateTime(
      newTime.year,
      newTime.month,
      newTime.day,
    );

    selectedTime.value = TimeOfDay(
      hour: newTime.hour,
      minute: newTime.minute,
    );

    selectedTimeOption.value = "$minutesToAdd min"; // highlight selected

    print("CURRENT TIME: ${DateFormat('HH:mm').format(now)}");
    print("UPDATED TIME: ${DateFormat('HH:mm').format(newTime)}");
  }

// ----------------- Set ASAP (Current Time) -----------------
  void setASAP() {
    selectedTime.value = TimeOfDay.now();
    selectedTimeOption.value = "ASAP"; // highlight ASAP


  }

// ----------------- Format for Display -----------------
  String formattedTime24() {
    final now = DateTime.now();
    final dt = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.value.hour,
      selectedTime.value.minute,
    );
    return DateFormat('HH:mm').format(dt); // 24-hour forma
  }


  String get getDate {
    return DateFormat('yyyy-MM-dd').format(selectedDate.value);
  }

  String get getTime {
    final now = DateTime.now();
    final dt = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.value.hour,
      selectedTime.value.minute,
    );

    return DateFormat('HH:mm').format(dt); // 24-hour time
  }

  ///================================================   fare calculation api
  double baseFare= 0;
  double totalFare= 0;
  Future<void> calculateHistoryBookingFareApi(Booking trip) async {
    Map<String, dynamic> dataMap = {
      "miles": trip.miles,
      "pickup_date": getDate,
      "pickup_time": getTime,
      "vehicle_type_id": selectedVehicleId,

      "pickup": trip.pickup,
      "dropoff": trip.dropoff,

      "journey_type_id": 1,

      "pickup_latitude": trip.pickupLatitude,
      "pickup_longitude": trip.pickupLongitude,
    };

    FormData formData = FormData.fromMap(dataMap);

    Response<dynamic>? response = await ApiService.post(
      formData,
      "fares/calculate-fare",
      multiPart: true,
      auth: true,
    );

    if (response!.statusCode == 200) {

      final res = response.data;

      final data = res['data']; // 🔥 IMPORTANT FIX

      baseFare = (data['fare'] ?? 0).toDouble();
      totalFare = (data['total_fare'] ?? 0).toDouble();

      print("FARE CALCULATED ✅ => $data");
      print("BASE FARE => $baseFare");
      print("TOTAL FARE => $totalFare");

      BotToast.showText(text: "Fare Calculated Successfully");
    }
  }

  /// ============================== VIA Points Handling ==============================

  List<Map<String, dynamic>> viaPointsList = [];
  void prepareViaPoints({Booking? trip}) {
    viaPointsList.clear();

    final profileName = "${profileController.profileData!.customer!.name}";
    //  final profileName = "Mark";
    final profileMobile = profileController.profileData!.customer!.mobile;
    // final profileMobile ="123467839";

    /// ================= 🔥 FROM HISTORY =================
    if (trip != null && trip.viapoints != null) {

      for (int i = 0; i < trip.viapoints!.length; i++) {

        if (i >= 2) break; // ✅ only 2 via allowed

        var via = trip.viapoints![i];

        /// ⚠️ because it's dynamic
        if (via != null) {
          viaPointsList.add({
            "viapoint": via["viapoint"] ?? "",
            "name": via["name"] ?? profileName,
            "mobile": via["mobile"] ?? profileMobile,
            "arrived": null,
            "passenger_on_board": null,
            "active": via["active"] ?? false,
            "latitude": via["latitude"],
            "longitude": via["longitude"],
          });
        }
      }
    }


    // // VIA 1
    // if (swapController.viaController1.text.isNotEmpty) {
    //   viaPointsList.add(<String, dynamic>{
    //     "viapoint": swapController.viaController1.text,
    //     "name": profileName,
    //     "mobile": profileMobile,
    //     "arrived": null,
    //     "passenger_on_board": null,
    //     "active": false,
    //     "latitude": swapController.via1Lat,
    //     "longitude": swapController.via1Lon,
    //   });
    // }
    // // VIA 2
    // if (swapController.viaController2.text.isNotEmpty) {
    //   viaPointsList.add({
    //     "viapoint": swapController.viaController2.text,
    //     "name": profileName,
    //     "mobile": profileMobile,
    //     "arrived": null,
    //     "passenger_on_board": null,
    //     "active": false,
    //     "latitude": swapController.via2Lat,
    //     "longitude": swapController.via2Lon,
    //   });
    // }
  }

  Future<void> historyBookingApi(Booking trip) async {
    prepareViaPoints(trip: trip);

    // 1. ViaPoints ka structure manually set karein taake nulls mehfooz rahein
    List<Map<String, dynamic>> finalViaPoints = viaPointsList.map((via) {
      return {
        "viapoint": via["viapoint"],
        "name": via["name"],
        "mobile": via["mobile"],
        "arrived": null, // Strict null
        "passenger_on_board": null, // Strict null
        "active": via["active"] ?? false,
        "latitude": via["latitude"],
        "longitude": via["longitude"],
      };
    }).toList();

    // 2. FormData banayein
    Map<String, dynamic> dataMap = {
      "pickup": trip.pickup,
      "pickup_latitude": trip.pickupLatitude,
      "pickup_longitude": trip.pickupLongitude,
      "dropoff": trip.dropoff,
      "dropoff_latitude": trip.dropoffLatitude,
      "dropoff_longitude": trip.dropoffLongitude,



      "name": "${profileController.profileData!.customer!.name}",
      "email": profileController.profileData!.customer!.email,
      "mobile": profileController.profileData!.customer!.mobile,
      "telephone": profileController.profileData!.customer!.mobile,
      "pickup_date": getDate,
      "pickup_time": getTime,
      "journey_type_id": 1,
      "sms": true,
      "passengers": selectedPassengers,
      "luggages": 1,
      "hand_luggages": 1,
      "payment_type_id": 1,
      "vehicle_type_id": selectedVehicleId,
      "eta": trip.eta,
      "miles": trip.miles,
      "booking_status_id": 1,
      "booking_type_id": 1,
      "booking_source": "app",
      "fares": baseFare,
      "total_charges": totalFare,

      // Customer ko stringify kar dein agar indexing masla kar rahi hai
      "customer": jsonEncode([
        {
          "name": "${profileController.profileData!.customer!.name}",
          "email": profileController.profileData!.customer!.email,
          "mobile": profileController.profileData!.customer!.mobile,
          "telephone": profileController.profileData!.customer!.mobile,
          "blacklist": false,
        }
      ]),

      // VIAPOINTS ko jsonEncode karein - Yeh nulls ko preserve karega
      "viapoints": jsonEncode(finalViaPoints),
    };

    FormData formData = FormData.fromMap(dataMap);

    // API Call
    Response<dynamic>? response = (await ApiService.post(
      formData,
      "bookings/add",
      multiPart: true,
      auth: true,
    ));

    if (response!.statusCode == 200) {
      final data = response.data;
      // bookings list
      final List bookings = data['bookings'];

      bookingId = bookings[0]['id'].toString();

      print("BOOKING ID ✅ => $bookingId");

      print("SUCCESS ✅ => ${response.data}");
      Get.back();
      //Get.off(RideSearchScreen());
      //Get.toNamed("/RideSearchScreen ");
      BotToast.showText(text: "Booking Created");
    } else {
      print("FAILED ❌ => ${response.data}");
      BotToast.showText(text: "Booking Failed");
    }
  }

  Future<void> cancelHistoryRideApi() async {
    print(bookingId);
    FormData formData = FormData.fromMap({
      "booking_status_id": 12,

    });

    var response = await ApiService.post(
      formData,
      "bookings/status/$bookingId",

      multiPart: false,
      auth: false,
    );

    if (response!.statusCode == 200) {

      BotToast.showText(text: "Booking Cancel Success");
      print(bookingId);
      Get.offAllNamed('/DeshBoard_Screen');
      return;
    }


  }

}