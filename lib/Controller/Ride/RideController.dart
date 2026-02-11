import  'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../View/rides/ride_model/get_vehicle_model.dart';
import '../../api_servies/api_servies.dart';
import '../Home/home-controller.dart';

class RideController extends GetxController {

  final swapController = Get.isRegistered<SwapController>()
      ? Get.find<SwapController>()
      : Get.put(SwapController());


  GetVehicleModel? vehicleData;
  bool loading = false;

  RxInt selectedIndex = (-1).obs;
  RxInt selectedVehicleId = 0.obs;
  RxInt selectedPassengers = 0.obs;

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
      if (vehicle.passengers != null) selectedPassengers.value = vehicle.passengers!;
    }
  }

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


    // // time format for console
    // final hour = selectedTime.value.hourOfPeriod.toString().padLeft(2, '0');
    // final minute = selectedTime.value.minute.toString().padLeft(2, '0');
    // final period =
    // selectedTime.value.period == DayPeriod.am ? "AM" : "PM";

    // print("ASAP Time: ${selectedTimeOption.value}");
    // print("ASAP Time: $hour:$minute $period");

    print("pickup   ${swapController.pickUp.text}");
    print("pickup_latitude    ${swapController.selectedPickUPLat}");
    print("pickup_latitude    ${swapController.selectedPickUPLon}");
    print("dropoff            ${swapController.dropOff.text}");
    print("dropoff_latitude   ${swapController.selectedDropLat}");
    print("dropoff_longitude  ${swapController.selectedDropLon}");
    print("eta                ${swapController.totalRouteDistanceMiles}");
    print("miles              ${swapController.estimatedTimeMinutes}");

    print("passengers              ${selectedPassengers}");
    print("vehicle_type_id              ${selectedVehicleId}");




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

    return DateFormat('HH:mm:ss').format(dt); // 24-hour time
  }






}
