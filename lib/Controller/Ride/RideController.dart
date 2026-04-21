import 'package:bot_toast/bot_toast.dart';
import 'package:customer/View/Deshboard/dashboard.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart'  ;
import 'package:get/get.dart' hide FormData, Response;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../View/profile/controller/profile_controller.dart';
import '../../View/rides/model/ride_model/get_vehicle_model.dart';

import '../../View/rides/ridesearchscreen.dart';
import '../../api_servies/api_servies.dart';
import '../Home/home-controller.dart';
import 'dart:convert';


class RideController extends GetxController {

  final swapController = Get.isRegistered<SwapController>()
      ? Get.find<SwapController>()
      : Get.put(SwapController());

  final profileController = Get.isRegistered<profileModelController>()
      ? Get.find<profileModelController>()
      :  Get.put(profileModelController());

  bool isFromHistory = false;

  GetVehicleModel? vehicleData;
  bool loading = false;

  RxInt selectedIndex = (0).obs;
  RxInt selectedVehicleId = 0.obs;
  RxInt selectedPassengers = 0.obs;
    String bookingId = "0" ;

  /// Item select (index + ID + passengers)
  void selectItem(int index) {
    selectedIndex.value = index;
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
  List<VehicleType> get vehicles => vehicleData?.vehicleTypes ?? [];
  ///  API call
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
      // ✅ DIRECT DATA CHECK (best way)
      if (vehicleData?.vehicleTypes != null &&
          vehicleData!.vehicleTypes!.isNotEmpty) {
        selectItem(0); // 👉 auto select first item
      }

    }

    loading = false;
    update();
  }

  // final List<String> CarName = [
  //   "Any Car",
  //   "Saloon Car",
  //   "Estate Car",
  //   "Seven Seater Van",
  //   "Saloon Car",
  //   "Estate Car",
  //   "Seven seater Van"
  // ];
  // final List<String> seats = ["4", "3", "4", "6", "3", "4", "6"];


  ///===============================================================================================  Schedule Working


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
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,

      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },

    );

    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked;
      selectedTimeOption.value = '';
    }
  }


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

//   void addMinutes(int minutesToAdd) {
//     final now = DateTime.now();
//     final newTime = now.add(Duration(minutes: minutesToAdd));
//     final dateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       selectedTime.value.hour,
//       selectedTime.value.minute,
//     );
//
//
//     selectedTime.value = TimeOfDay(hour: newTime.hour, minute: newTime.minute);
//
//     selectedTimeOption.value = "$minutesToAdd min"; // highlight selected
//   }

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
    return DateFormat('HH:mm').format(dt); // 24-hour format
  }

  ///================================================= ========================== =============                         API WORKING

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


  List<Map<String, dynamic>> viaPointsList = [];
  /// ============================== VIA Points Handling ==============================

  void prepareViaPoints() {
    viaPointsList.clear();

    final profileName = "${profileController.profileData!.customer!.name}";
    //  final profileName = "Mark";
    final profileMobile = profileController.profileData!.customer!.mobile;
    // final profileMobile ="123467839";

    // VIA 1
    if (swapController.viaController1.text.isNotEmpty) {
      viaPointsList.add(<String, dynamic>{
        "viapoint": swapController.viaController1.text,
        "name": profileName,
        "mobile": profileMobile,
        "arrived": null,
        "passenger_on_board": null,
        "active": false,
        "latitude": swapController.via1Lat,
        "longitude": swapController.via1Lon,
      });
    }
   // VIA 2
      if (swapController.viaController2.text.isNotEmpty) {
        viaPointsList.add({
          "viapoint": swapController.viaController2.text,
          "name": profileName,
          "mobile": profileMobile,
          "arrived": null,
          "passenger_on_board": null,
          "active": false,
          "latitude": swapController.via2Lat,
          "longitude": swapController.via2Lon,
        });
      }
  }



  Future<void> getBookingApi() async {
    prepareViaPoints();

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
      "pickup": swapController.pickUp.text,
      "pickup_latitude": swapController.selectedPickUPLat,
      "pickup_longitude": swapController.selectedPickUPLon,
      "pickup_door_number": swapController.babyNote,
      "dropoff": swapController.dropOff.text,
      "dropoff_latitude": swapController.selectedDropLat,
      "dropoff_longitude": swapController.selectedDropLon,
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
      "eta": swapController.estimatedTimeText,
      "miles": swapController.totalRouteDistanceMiles,
      "booking_status_id": 1,
      "booking_type_id": 1,
      "booking_source": "app",

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
    Response<dynamic>? response = await ApiService.post(
      formData,
      "bookings/add",
      multiPart: true,
      auth: true,
    );

    if (response!.statusCode == 200) {
      final data = response.data;
      // bookings list
      final List bookings = data['bookings'];

      bookingId = bookings[0]['id'].toString();

      print("BOOKING ID ✅ => $bookingId");

      print("SUCCESS ✅ => ${response.data}");
      //Get.off(RideSearchScreen());
      //Get.toNamed("/RideSearchScreen ");
      BotToast.showText(text: "Booking Created");
    } else {
      print("FAILED ❌ => ${response.data}");
      BotToast.showText(text: "Booking Failed");
    }
  }
  ///
  // void prepareViaPoints() {
  //   viaPointsList.clear();
  //
  //  final profileName = "${profileController.profileData!.customer!.name}";
  //  //  final profileName = "Mark";
  //   final profileMobile = profileController.profileData!.customer!.mobile;
  //   // final profileMobile ="123467839";
  //
  //   // VIA 1
  //   if (swapController.viaController1.text.isNotEmpty) {
  //     viaPointsList.add(<String, dynamic>{
  //       "viapoint": swapController.viaController1.text,
  //       "name": profileName,
  //       "mobile": profileMobile,
  //       "arrived": null,
  //       "passenger_on_board": null,
  //       "active": false,
  //       "latitude": swapController.via1Lat,
  //       "longitude": swapController.via1Lon,
  //     });
  //   }
  //
  //   // VIA 2
  //   if (swapController.viaController2.text.isNotEmpty) {
  //     viaPointsList.add({
  //       "viapoint": swapController.viaController2.text,
  //       "name": profileName,
  //       "mobile": profileMobile,
  //       "arrived": null,
  //       "passenger_on_board": null,
  //       "active": false,
  //       "latitude": swapController.via2Lat,
  //       "longitude": swapController.via2Lon,
  //     });
  //   }
  //
  //   // Add more VIA points here if needed
  // }
  //
  //
  // Future<void> getBookingApi() async {
  //   prepareViaPoints();
  //
  //   FormData formData = FormData.fromMap(<String, dynamic>{
  //     // ---------------- Pickup ----------------
  //     "pickup": swapController.pickUp.text,
  //     "pickup_latitude": swapController.selectedPickUPLat,
  //     "pickup_longitude": swapController.selectedPickUPLon,
  //      "pickup_door_number": swapController.babyNote,
  //
  //     // ---------------- Dropoff ----------------
  //     "dropoff":swapController.dropOff.text,
  //     "dropoff_latitude":swapController.selectedDropLat,
  //     "dropoff_longitude": swapController.selectedDropLon,
  //     // "dropoff_door_number": "dropoff notes",
  //
  //     // ---------------- Customer ----------------
  //     "name": "${profileController.profileData!.customer!.name}" ,
  //     "email": profileController.profileData!.customer!.email,
  //     "mobile": profileController.profileData!.customer!.mobile,
  //     "telephone": profileController.profileData!.customer!.mobile,
  //
  //     // "name": "customer1",
  //     // "email": "tests@mail.com",
  //     // "mobile": "123467839",
  //     // "telephone": "1234536798",
  //
  //     // ---------------- Journey ----------------
  //     "pickup_date": getDate,
  //     "pickup_time": getTime,
  //     "journey_type_id": 1,
  //     "sms": true,
  //
  //     // ---------------- Counts ----------------
  //     "passengers": selectedPassengers,
  //     "luggages": 1,
  //     "hand_luggages": 1,
  //
  //     // ---------------- Payment & Vehicle ----------------
  //     "payment_type_id": 1,
  //     "vehicle_type_id": selectedVehicleId,
  //
  //     // ---------------- Ride Info ----------------
  //     "eta": swapController.estimatedTimeText,
  //     "miles": swapController.totalRouteDistanceMiles,
  //     "booking_status_id": 1,
  //     "booking_type_id": 1,
  //     "booking_source": "app",
  //
  //     // ---------------- Customer Array ----------------
  //     "customer": [
  //       {
  //         "name": "${profileController.profileData!.customer!.name}" ,
  //         "email": profileController.profileData!.customer!.email,
  //         "mobile": profileController.profileData!.customer!.mobile,
  //         "telephone": profileController.profileData!.customer!.mobile,
  //         "blacklist": false,
  //
  //         // "name": "customer1",
  //         // "email": "tests@mail.com",
  //         // "mobile": "123467839",
  //         // "telephone": "1234536798",
  //         // "blacklist": false,
  //       }
  //     ],
  //
  //     // ---------------- Via Points (Optional) ----------------
  //
  //
  //      "viapoints": viaPointsList.isNotEmpty ? viaPointsList : [],
  //
  //     // if (viaPointsList.isNotEmpty)
  //     //   "viapoints": viaPointsList,
  //
  //     // "viapoints": [
  //     //   {
  //     //     "viapoint": "elm park road london n3 1ed",
  //     //     "name": "test",
  //     //     "mobile": "1236547898",
  //     //     "arrived": null,
  //     //     "passenger_on_board": null,
  //     //     "active": false,
  //     //     "latitude": "51.60502870865506",
  //     //     "longitude": "-0.19752048515577314",
  //     //   },
  //     //   {
  //     //     "viapoint": "etchingham park road london n3 2ds",
  //     //     "name": "test 2",
  //     //     "mobile": "0123456879",
  //     //     "arrived": null,
  //     //     "passenger_on_board": null,
  //     //     "active": false,
  //     //     "latitude": "51.60435165870115",
  //     //     "longitude": "-0.18285231654990017",
  //     //   }
  //     // ],
  //   });
  //
  //   // DEBUG
  //   print("FORM DATA ================================");
  //   for (var field in formData.fields) {
  //     print("${field.key} : ${field.value}");
  //   }
  //
  //   Response<dynamic>? response = await ApiService.post(
  //     formData,
  //     "bookings/add",
  //     multiPart: false,
  //     auth: true,
  //   );
  //
  //   if ( response!.statusCode == 200) {
  //     final data = response.data;
  //     // bookings list
  //     final List bookings = data['bookings'];
  //
  //      bookingId = bookings[0]['id'].toString();
  //
  //     print("BOOKING ID ✅ => $bookingId");
  //
  //     print("SUCCESS ✅ => ${response.data}");
  //     Get.off(RideSearchScreen());
  //     //Get.toNamed("/RideSearchScreen ");
  //     BotToast.showText(text: "Booking Created");
  //   } else {
  //     print("FAILED ❌ => ${response.data}");
  //     BotToast.showText(text: "Booking Failed");
  //   }
  // }

///
  // void prepareViaPoints() {
  //   viaPointsList.clear();
  //
  //   final profileName = "${profileController.profileData!.customer!.name}";
  //   final profileMobile = profileController.profileData!.customer!.mobile;
  //
  //   // VIA 1
  //   if (swapController.viaController1.text.isNotEmpty) {
  //     viaPointsList.add({
  //       "viapoint": swapController.viaController1.text,
  //       "name": profileName,
  //       "mobile": profileMobile,
  //       "arrived": null,
  //       "passenger_on_board": null,
  //       "active": false,
  //       "latitude": swapController.via1Lat,
  //       "longitude": swapController.via1Lon,
  //     });
  //   }
  //
  //   // VIA 2
  //   if (swapController.viaController2.text.isNotEmpty) {
  //     viaPointsList.add({
  //       "viapoint": swapController.viaController2.text,
  //       "name": profileName,
  //       "mobile": profileMobile,
  //       "arrived": null,
  //       "passenger_on_board": null,
  //       "active": false,
  //       "latitude": swapController.via2Lat,
  //       "longitude": swapController.via2Lon,
  //     });
  //   }
  // }
  //
  // Future<void> getBookingApi() async {
  //   prepareViaPoints();
  //
  //   // JSON map
  //   Map<String, dynamic> jsonBody = {
  //     "pickup": swapController.pickUp.text,
  //     "pickup_latitude": swapController.selectedPickUPLat,
  //     "pickup_longitude": swapController.selectedPickUPLon,
  //     "pickup_door_number": swapController.babyNote,
  //
  //     "dropoff": swapController.dropOff.text,
  //     "dropoff_latitude": swapController.selectedDropLat,
  //     "dropoff_longitude": swapController.selectedDropLon,
  //
  //     "name": profileController.profileData!.customer!.name,
  //     "email": profileController.profileData!.customer!.email,
  //     "mobile": profileController.profileData!.customer!.mobile,
  //     "telephone": profileController.profileData!.customer!.mobile,
  //
  //     "pickup_date": getDate,
  //     "pickup_time": getTime,
  //     "journey_type_id": 1,
  //     "sms": true,
  //
  //     "passengers": selectedPassengers.value,
  //     "luggages": 1,
  //     "hand_luggages": 1,
  //
  //     "payment_type_id": 1,
  //     "vehicle_type_id": selectedVehicleId.value,
  //
  //     "eta": swapController.estimatedTimeText,
  //     "miles": swapController.totalRouteDistanceMiles,
  //     "booking_status_id": 1,
  //     "booking_type_id": 1,
  //     "booking_source": "app",
  //
  //     "customer": [
  //       {
  //         "name": profileController.profileData!.customer!.name,
  //         "email": profileController.profileData!.customer!.email,
  //         "mobile": profileController.profileData!.customer!.mobile,
  //         "telephone": profileController.profileData!.customer!.mobile,
  //         "blacklist": false,
  //       }
  //     ],
  //
  //     "viapoints": viaPointsList.isNotEmpty ? viaPointsList : [],
  //   };
  //
  //   // FormData me convert karo JSON ke saath
  //   FormData formData = FormData.fromMap({
  //     "data": jsonEncode(jsonBody), // <-- ye important hai
  //   });
  //
  //   // DEBUG
  //   print("FORM DATA ================================");
  //   print(formData.fields);
  //
  //   Response<dynamic>? response = await ApiService.post(
  //     formData,
  //     "bookings/add",
  //     multiPart: true, // multipart ke saath
  //     auth: true,
  //   );
  //
  //   if (response != null && response.statusCode == 200) {
  //     final data = response.data;
  //     final List bookings = data['bookings'];
  //     bookingId = bookings[0]['id'].toString();
  //
  //     print("BOOKING ID ✅ => $bookingId");
  //     print(response.data);
  //     Get.off(RideSearchScreen());
  //     BotToast.showText(text: "Booking Created");
  //   } else {
  //     print("FAILED ❌ => ${response?.data}");
  //     BotToast.showText(text: "Booking Failed");
  //   }
  // }






  Future<void> rideCancelApi() async {
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
     isFromHistory = false;
      Get.offAllNamed('/DeshBoard_Screen');
      return;
    }


  }




}

