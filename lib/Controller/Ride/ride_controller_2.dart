// import 'dart:convert';
// import 'dart:io';
//
// import 'package:cross_file/cross_file.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
//
// class BookingConfirmationController extends GetxController {
//   /// Loading
//   RxBool isLoading = true.obs;
//
//   /// Booking Data
//   RxMap<String, dynamic> booking = <String, dynamic>{}.obs;
//
//   /// Error
//   RxString errorMessage = ''.obs;
//
//   /// Fetch Booking API
//   Future<void> fetchBooking(String referenceNumber) async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';
//
//       final url = Uri.parse(
//         'https://nexustechnologys.com:4000/api/dashboard/getByReferenceNumber?referenceNumber=$referenceNumber',
//       );
//
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final List data = json.decode(response.body);
//
//         if (data.isNotEmpty) {
//           booking.value = Map<String, dynamic>.from(data.first);
//         } else {
//           errorMessage.value = "No booking found";
//         }
//       } else {
//         errorMessage.value = "Failed to load booking";
//       }
//     } catch (e) {
//       errorMessage.value = e.toString();
//
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// Generate PDF & Share
//   // Future<void> generatePdf() async {
//   //   try {
//   //     if (booking.isEmpty) {
//   //       Get.snackbar(
//   //         "Error",
//   //         "Booking data not found.",
//   //         snackPosition: SnackPosition.BOTTOM,
//   //       );
//   //       return;
//   //     }
//   //
//   //     final pdf = pw.Document();
//   //
//   //     pdf.addPage(
//   //       pw.Page(
//   //         build: (context) {
//   //           return pw.Padding(
//   //             padding: const pw.EdgeInsets.all(20),
//   //             child: pw.Column(
//   //               crossAxisAlignment: pw.CrossAxisAlignment.start,
//   //               children: [
//   //                 pw.Text(
//   //                   "Booking Confirmation",
//   //                   style: pw.TextStyle(
//   //                     fontSize: 24,
//   //                     fontWeight: pw.FontWeight.bold,
//   //                   ),
//   //                 ),
//   //
//   //                 pw.SizedBox(height: 20),
//   //
//   //                 _pdfRow("Name", booking['name']),
//   //                 _pdfRow("Reference Number", booking['referenceNumber']),
//   //                 _pdfRow("Pickup Location", booking['pickupLocation']),
//   //                 _pdfRow("Dropoff Location", booking['dropoffLocation']),
//   //                 _pdfRow("Mobile Number", booking['mobileNumber']),
//   //                 _pdfRow("Email", booking['email']),
//   //                 _pdfRow("Date", booking['date']),
//   //                 _pdfRow("Time", booking['time']),
//   //                 _pdfRow("Vehicle Type", booking['vehicleType']),
//   //
//   //                 // Uncomment if API provides fare
//   //                 // _pdfRow("Fare", "£${booking['fares']}"),
//   //
//   //                 pw.SizedBox(height: 30),
//   //
//   //                 pw.Divider(),
//   //
//   //                 pw.Text(
//   //                   "Thank you for booking with Nexus Tech Groups Ltd.",
//   //                   style: const pw.TextStyle(fontSize: 14),
//   //                 ),
//   //               ],
//   //             ),
//   //           );
//   //         },
//   //       ),
//   //     );
//   //
//   //     final directory = await getTemporaryDirectory();
//   //
//   //     final file = File(
//   //       "${directory.path}/Booking_${booking['referenceNumber']}.pdf",
//   //     );
//   //
//   //     await file.writeAsBytes(await pdf.save());
//   //
//   //     await Share.shareXFiles(
//   //       [
//   //         XFile(file.path),
//   //       ],
//   //       text: "Your booking confirmation",
//   //       subject: "Booking ${booking['referenceNumber']}",
//   //     );
//   //   } catch (e) {
//   //     Get.snackbar(
//   //       "PDF Error",
//   //       e.toString(),
//   //       snackPosition: SnackPosition.BOTTOM,
//   //       backgroundColor: Colors.red,
//   //       colorText: Colors.white,
//   //     );
//   //   }
//   // }
//
//   /// PDF Row Widget
//     // pw.Widget _pdfRow(String title, dynamic value) {
//     //   return pw.Padding(
//     //     padding: const pw.EdgeInsets.symmetric(vertical: 5),
//     //     child: pw.Row(
//     //       crossAxisAlignment: pw.CrossAxisAlignment.start,
//     //       children: [
//     //         pw.SizedBox(
//     //           width: 130,
//     //           child: pw.Text(
//     //             "$title :",
//     //             style: pw.TextStyle(
//     //               fontWeight: pw.FontWeight.bold,
//     //             ),
//     //           ),
//     //         ),
//     //         pw.Expanded(
//     //           child: pw.Text(
//     //             value?.toString() ?? "",
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //   );
//     // }
//
//   /// Getter Methods (Optional but Cleaner UI)
//
//   String get name => booking['name'] ?? '';
//
//   String get referenceNumber => booking['referenceNumber'] ?? '';
//
//   String get pickupLocation => booking['pickupLocation'] ?? '';
//
//   String get dropoffLocation => booking['dropoffLocation'] ?? '';
//
//   String get mobileNumber => booking['mobileNumber'] ?? '';
//
//   String get email => booking['email'] ?? '';
//
//   String get date => booking['date'] ?? '';
//
//   String get time => booking['time'] ?? '';
//
//   String get vehicleType => booking['vehicleType'] ?? '';
//
// // String get fare => booking['fares']?.toString() ?? '';
// }