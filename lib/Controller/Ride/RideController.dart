import  'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../View/rides/ride_model/get_vehicle_model.dart';
import '../../api_servies/api_servies.dart';

class RideController extends GetxController {

  GetVehicleModel? vehicleData;
  RxBool loading = false.obs;

  RxInt selectedIndex = (-1).obs;
  RxInt selectedVehicleId = 0.obs;

  ///  Item select (index + ID)
  void selectItem(int index) {
    selectedIndex.value = index;
    setSelectedVehicleId(index);
  }

  ///  Vehicle ID get function
  void setSelectedVehicleId(int index) {
    final vehicle = vehicleData?.vehicleTypes?[index];

    if (vehicle != null && vehicle.id != null) {
      selectedVehicleId.value = vehicle.id!;
    }

  }

  ///  API call
  Future<void> getVehicleTypes() async {
    loading.value = true;
    update();

    var response = await ApiService.get(
      "vehicle-type/get",
      auth: true,
      isProgressShow: false
    );

    if (response != null && response.statusCode == 200) {
      vehicleData = GetVehicleModel.fromJson(response.data);

    }

    loading.value = false;
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
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.value.hour,
      selectedTime.value.minute,
    );

    final newTime = dateTime.add(Duration(minutes: minutesToAdd));
    selectedTime.value = TimeOfDay(hour: newTime.hour, minute: newTime.minute);

    selectedTimeOption.value = "$minutesToAdd min"; // highlight selected
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
    return DateFormat('HH:mm').format(dt); // 24-hour format
  }



// String get formattedDate {
//   return DateFormat('yyyy-MM-dd').format(selectedDate.value);
// }

  // String formattedTime(BuildContext context) {
  //   return selectedTime.value.format(context);
  // }








}
