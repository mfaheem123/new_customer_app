import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:customer/Routing/routes_name.dart';
import 'package:customer/View/rides/model/booking_get_by_id/booking_get_model.dart' hide VehicleType;
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart'  ;
import 'package:get/get.dart' hide FormData, Response;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../View/profile/controller/profile_controller.dart';
import '../../View/rides/model/get_driver_by_id/driver_detail_model.dart' hide VehicleType;
import '../../View/rides/model/ride_model/get_vehicle_model.dart';
import '../../api_servies/api_servies.dart';
import '../Home/home-controller.dart';
import 'dart:convert';


class RideController extends GetxController {


  final swapController = Get.isRegistered<SwapController>()
      ? Get.find<SwapController>()
      : Get.put(SwapController());

  final profileController = Get.isRegistered<profileModelController>()
      ? Get.find<profileModelController>()
      : Get.put(profileModelController());

  bool isFromHistory = false;

  GetVehicleModel? vehicleData;
  bool loading = false;

  RxInt selectedIndex = (0).obs;
  RxInt selectedVehicleId = 0.obs;
  RxInt selectedPassengers = 0.obs;
  String bookingId = "0";

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
  var selectedDate = DateTime
      .now()
      .obs;
  var selectedTime = TimeOfDay
      .now()
      .obs;

// Track which quick-time button is selected ("ASAP", "15 min", "30 min")
  var selectedTimeOption = 'ASAP'.obs;

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

  ///================================================   fare calculation api
  double baseFare = 0;
  double totalFare = 0;

  Future<void> calculateFareApi() async {
    Map<String, dynamic> dataMap = {
      "miles": swapController.totalRouteDistanceMiles,
      "pickup_date": getDate,
      "pickup_time": getTime,
      "vehicle_type_id": selectedVehicleId,

      "pickup": swapController.pickUp.text,
      "dropoff": swapController.dropOff.text,

      "journey_type_id": 1,

      "pickup_latitude": swapController.selectedPickUPLat,
      "pickup_longitude": swapController.selectedPickUPLon,
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

  ///================================================   booking cancel api


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

  ///================================================   Driver detail  Api

  Timer? _timer;
  String? currentDriverId;

//
  BookingGetById? bookingData;
  Booking? currentBooking;
  String? getBookingId;

  void setBookingData(Map data) {
    try {
      bookingData = BookingGetById.fromJson(
        Map<String, dynamic>.from(data),
      );

      final booking = bookingData?.booking;

      if (booking != null) {
        swapController.setBookingRoute(booking);

        // 2. Ride Complete ke liye save
        currentBooking = booking;
        GetStorage().write("booking", booking.toJson());

      }

      getBookingId = booking?.id;
      debugPrint("Booking Stored ✅ ID: $getBookingId");
      debugPrint("=======================================Current Booking Stored ✅ ID: ${currentBooking?.totalCharges}");
      update();
    } catch (e) {
      debugPrint("Booking Parse Error: $e");
    }
  }


  // void setBookingData(Map data) {
  //   try {
  //     bookingData = BookingGetById.fromJson(Map<String, dynamic>.from(data), // ✅ FIX
  //     );
  //
  //     debugPrint("Booking Stored ✅ ID: ${bookingData?.booking?.id}");
  //     update();
  //
  //   } catch (e) {
  //     debugPrint("Booking Parse Error: $e");
  //   }
  // }

  // 🔥 Reactive variables
  var isLoading = true.obs;
  var bookingStatus = "".obs;
  var driverName = "".obs;
  var vehicleColor = "".obs;
  var vehicleNumber = "".obs;

  late DriverGetbyId driverGetbyId;


// 🔥 START POLLING
  void startPolling(String driverId) {
    currentDriverId = driverId;

    stopPolling();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _hitDriverApi(driverId);
    });
  }

// 🔥 STOP POLLING
  void stopPolling() {
    _timer?.cancel();
    _timer = null;
  }
  bool hasNavigated = false;
// 🔥 API CALL
  Future<void> _hitDriverApi(String driverId) async {
    try {
      var response = await ApiService.get(
        "drivers/getbyid/$driverId",
        auth: true,
      );

      if (response != null && response.statusCode == 200) {
        driverGetbyId = DriverGetbyId.fromJson(response.data);

        final driver = driverGetbyId.driver;
        final vehicle = driver.vehicle;

        // ✅ SAFE UPDATE (NO NULL CRASH)
        driverName.value = driver.name ?? "";
        bookingStatus.value = driver.bookingStatus ?? "";
        vehicleColor.value = vehicle.color ?? "";
        vehicleNumber.value = vehicle.vehicleNumber ?? "";

        isLoading.value = false;

        debugPrint("Booking Status: ${bookingStatus.value}");
        print("image ==================================== >>>> ${driver.image}");

        // 🔥 CONDITION FIXED
        if (bookingStatus.value.trim() == "Available" && !hasNavigated) {
          hasNavigated = true;
          stopPolling();
          Get.offAllNamed(routesName.RideCompleteScreen);
        }
        // if (bookingStatus.value.trim() == "Available") {
        //
        //   stopPolling();
        //
        //   Get.offAllNamed(routesName.RideCompleteScreen);
        // }
      }
    } catch (e, s) {
      debugPrint("Polling API error: $e");
      debugPrint("Stack trace: $s");
    }
  }
  //
  // @override
  // void onClose() {
  //   stopPolling();
  //   super.onClose();
  // }
}
///












