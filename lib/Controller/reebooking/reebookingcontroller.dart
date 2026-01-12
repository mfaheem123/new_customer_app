import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  var selectedVehicleIndex = 0.obs;

  final  vehicleList = [
    {
      "name": "Any Vehicle",
      "people": 4,
      "bags": 2,
      "cases": 2,
      "price": 172.00,
    },
    {
      "name": "Saloon Car",
      "people": 4,
      "bags": 2,
      "cases": 2,
      "price": 172.00,
    },
    {
      "name": "Luxury Car",
      "people": 4,
      "bags": 3,
      "cases": 2,
      "price": 200.00,
    },
  ];
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
    return DateFormat('HH:mm').format(dt); // 24-hour forma
  }



// String get formattedDate {
//   return DateFormat('yyyy-MM-dd').format(selectedDate.value);
// }

String formattedTime(BuildContext context) {
  return selectedTime.value.format(context);
}







}