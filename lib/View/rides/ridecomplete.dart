//
// import 'package:customer/View/textstyle/apptextstyle.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../Controller/payment/paymentcontroller.dart';
// import '../Widgets/all_text.dart';
// import '../Widgets/color.dart';
// import '../Widgets/elevat_button.dart';
// import 'feedback_screen.dart';
//
//
//
// class RideCompleteScreen extends StatelessWidget {
//
//   final PaymentController  paymentController= Get.put(PaymentController());
//   RideCompleteScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//           backgroundColor: CustomColor.background,
//           body: Container(
//             height:MediaQuery.of(context).size.height,
//             width:MediaQuery.of(context).size.width,
//
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 30, 1, 44),
//                   Color.fromARGB(255, 227, 194, 242)
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 15),
//                   height: MediaQuery.of(context).size.height*0.85,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                         Container(
//
//                           height: MediaQuery.of(context).size.height * 0.1,
//                          //padding: EdgeInsets.symmetric(horizontal: 10),
//                           decoration: BoxDecoration(
//                            // color: CustomColor.Container_Colors,
//                             borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               bottomRight: Radius.circular(20),
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               // IconButton(
//                               //   onPressed: () {
//                               //     Get.back();
//                               //   },
//                               //   icon: Icon(
//                               //     Icons.arrow_back,
//                               //     size: MediaQuery.of(context).size.width * 0.06,
//                               //     color: CustomColor.Icon_Color,
//                               //   ),
//                               // ),
//
//                               SizedBox(width: 5),
//
//                               Expanded(
//                                 child: Center(
//                                   child: Text(
//                                     CustomText.Ride_Complete,
//                                     style: AppTextStyles.heading(
//                                       size: MediaQuery.of(context).size.width * 0.06,
//
//                                     ),
//                                   ),
//                                 ),
//                               ),
//
//                               // IconButton(
//                               //   onPressed: () {
//                               //     Get.back();
//                               //   },
//                               //   icon: Icon(
//                               //     Icons.edit_notifications_sharp,
//                               //     size: MediaQuery.of(context).size.width * 0.06,
//                               //     color: Colors.yellow,
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ),
//
//                       SizedBox(height: 30,),
//
//                       Center(
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.13,
//                           width: MediaQuery.of(context).size.width ,
//                           decoration: BoxDecoration(
//                             color: Colors.green,
//                             borderRadius: BorderRadius.all(Radius.circular(25)),
//                           ),
//                           child: Container(
//                             //padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SizedBox(height: 10),
//                                 Text(
//                                   CustomText.Reached_Destination,
//                                   textAlign: TextAlign.center,
//                                   style: AppTextStyles.medium(),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Icon(Icons.favorite,color: Colors.black,size: 25,),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       SizedBox(height: 30,),
//
//
//
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Icon(Icons.location_on,size: 25,color: Colors.red),
//                           //CustomColor.Icon_Color,),
//                           SizedBox(width: 10,),
//
//                           Expanded(
//                             child: Text(
//                               "1A Worrior Garden St.LEO "
//                                   " Worrior Garden St.LEO TN36eb",
//                               softWrap: true,
//                               textAlign: TextAlign.start,
//                               maxLines: 2,
//                               style: AppTextStyles.medium(),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 15,),
//
//                     Row(
//                         children: [
//                           Icon(Icons.money,size: 25,color: CustomColor.Icon_Color,),
//                           SizedBox(width: 15,),
//
//                           Text(
//                             "3.000",
//                             textAlign: TextAlign.center,
//                             style: AppTextStyles.medium(),
//                           ),
//                           Icon(Icons.currency_pound_sharp,size: 25,color: CustomColor.Icon_Color,),
//
//
//                         ],
//                       ),
//                       SizedBox(height: 15,),
//
//                       Text(
//                         "Payment Method",
//                         style: AppTextStyles.medium(
//                         ),
//                       ),
//
//                       Obx(() => Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//
//                           Radio<String>(
//                             value: 'Cash',
//                             groupValue: paymentController.paymentMethod.value,
//                             onChanged: paymentController.setPaymentMethod,
//                             activeColor: CustomColor.Icon_Color,
//                             fillColor: MaterialStateProperty.all<Color>(CustomColor.Container_Colors),
//
//                           ),
//
//                           Text(
//                             "Cash",
//                             textAlign: TextAlign.center,
//                             style: AppTextStyles.medium(
//
//                             ),
//                           ),
//
//                            SizedBox(width: 20),
//
//                           Radio<String>(
//                             value: 'Credit Card',
//                             groupValue: paymentController.paymentMethod.value,
//                             onChanged: paymentController.setPaymentMethod,
//                             activeColor: CustomColor.Icon_Color,
//                             fillColor: MaterialStateProperty.all<Color>(CustomColor.Container_Colors),
//                           ),
//                           Text(
//                             "Credit Card",
//                             textAlign: TextAlign.center,
//                             style:  AppTextStyles.medium()
//                           ),
//                         ],
//                       )),
//
//                       SizedBox(height: 50,),
//
//                       Center(
//                         child:  SizedBox(
//                           height: 55,
//                           width: 250  ,
//                           child: MyElevatedButton(
//                             text: '',
//                             onPressed: () {
//                              // Get.toNamed('/ThanksScreen');
//                               Get.to(ThanksScreen());
//                             },
//                             textWidget:
//                             FittedBox(
//                                 //fit: BoxFit.scaleDown,
//                                 child: Text('Done',style: AppTextStyles.medium(size: 25 ,weight: FontWeight.bold),
//                                 )
//                             ),
//
//
//                           ),
//                         ),
//
//                       ),
//
//
//
//
//
//                     ],
//                   ),
//                 ),
//                 Spacer(),
//
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 5),
//                  decoration: BoxDecoration(
//                    color: CustomColor.Container_Colors,
//                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
//                  ),
//                   //height: MediaQuery.of(context).size.height*0.15,
//                   child:   Row(
//                     mainAxisAlignment:MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Center(
//                         child: TextButton(
//                           onPressed: () async {
//                             const phone = "tel://01424202020";
//                             final Uri phoneUri = Uri.parse(phone);
//
//                             try {
//                               bool launched = await launchUrl(
//                                 phoneUri,
//                                 mode: LaunchMode.externalApplication,
//                               );
//
//                               if (!launched) {
//                                 print("Dialer app not found");
//                               }
//                             } catch (e) {
//                               print("Error: $e");
//                             }
//                           },
//                           child: Text(
//                             "Help And Support Please Call",
//                             textAlign: TextAlign.center,
//                             style: AppTextStyles.medium(),
//                           ),
//                         ),
//                       ),
//                       Icon(
//                         Icons.call,size: 25,
//                         color: CustomColor.Icon_Color,
//                       ),
//
//
//
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//
//         )
//     );
//   }
// }
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Controller/Ride/RideController.dart';
import '../../Controller/payment/paymentcontroller.dart';
import '../Widgets/all_text.dart';
import '../Widgets/color.dart';
import '../Widgets/elevat_button.dart';

import 'feedback_screen.dart';
import 'model/booking_get_by_id/booking_get_model.dart';

class RideCompleteScreen extends StatelessWidget {
  RideCompleteScreen({super.key});


  final PaymentController paymentController = Get.put(PaymentController());
  //final rideController controller = Get.find();

  final rideController = Get.isRegistered<RideController>()
      ? Get.find<RideController>()
      :  Get.put(RideController(),);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<RideController>(
        builder: (controller) {

          // final booking = controller.currentBooking;
          final box = GetStorage();

          final bookingData = box.read("booking");

          final booking = bookingData != null
              ? Booking.fromJson(bookingData)
              : controller.currentBooking;


          print("BOOKING DATA => ${controller.currentBooking}");


          return Scaffold(
            backgroundColor: CustomColor.background,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 30, 1, 44),
                    Color.fromARGB(255, 227, 194, 242)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),

              child: Column(
                children: [

                  /// ================= TOP =================
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Center(
                            child: Text(
                              CustomText.Ride_Complete,
                              style: AppTextStyles.heading(
                                // size: MediaQuery.of(context).size.width * 0.06,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// GREEN BOX (UNCHANGED)
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.13,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  CustomText.Reached_Destination,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.medium(),
                                ),
                                const SizedBox(height: 10),
                                const Icon(Icons.favorite,
                                    color: Colors.black, size: 25),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// ================= ADDRESS (API) =================
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 25, color: Colors.red),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                booking?.dropoff ?? "No Address Found",
                                softWrap: true,
                                maxLines: 2,
                                style: AppTextStyles.medium(),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        /// ================= FARE (API) =================
                        Row(
                          children: [
                            const Icon(Icons.money,
                                size: 25, color: Colors.white),
                            const SizedBox(width: 15),
                            Text(
                              booking?.totalCharges?.toString() ?? "0.00",
                              style: AppTextStyles.medium(),
                            ),
                            const Icon(Icons.currency_pound_sharp,
                                size: 25, color: Colors.white),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Text(
                          "Payment Method",
                          style: AppTextStyles.medium(),
                        ),

                        /// ================= PAYMENT (UNCHANGED) =================
                        Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Radio<String>(
                              value: 'Cash',
                              groupValue: paymentController.paymentMethod.value,
                              onChanged: paymentController.setPaymentMethod,
                              activeColor: CustomColor.Icon_Color,
                              fillColor: MaterialStateProperty.all(
                                  CustomColor.Container_Colors),
                            ),

                            Text("Cash",
                                style: AppTextStyles.medium()),

                            const SizedBox(width: 20),

                            Radio<String>(
                              value: 'Credit Card',
                              groupValue: paymentController.paymentMethod.value,
                              onChanged: paymentController.setPaymentMethod,
                              activeColor: CustomColor.Icon_Color,
                              fillColor: MaterialStateProperty.all(
                                  CustomColor.Container_Colors),
                            ),

                            Text("Credit Card",
                                style: AppTextStyles.medium()),
                          ],
                        )),

                        const SizedBox(height: 50),

                        Center(
                          child: SizedBox(
                            height: 55,
                            width: 250,
                            child: MyElevatedButton(
                              text: '',
                              onPressed: () async {

                                /// Booking ID
                                final box = GetStorage();

                                final bookingData = box.read("booking");

                                final bookingId = bookingData != null
                                    ? bookingData["id"].toString()
                                    : "";

                                if (bookingId.isEmpty) {
                                  Get.snackbar(
                                    "Error",
                                    "Booking ID not found",
                                  );
                                  return;
                                }

                                /// Cash = 1
                                if (paymentController.paymentMethod.value == "Cash") {
                                  paymentController.selectMethod(0);
                                }

                                /// Credit Card = 2
                                else {
                                  paymentController.selectMethod(1);
                                }

                                /// API
                                await paymentController.updatePaymentMethodApi(bookingId);


                              },

                              textWidget: FittedBox(
                                child: Text(
                                  'Done',
                                  style: AppTextStyles.medium(
                                      size: 25,
                                      weight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  /// ================= CALL SUPPORT =================
                  InkWell(
                    onTap: ()async {

                        final phone =
                            "01424202020";

                        final Uri phoneUri = Uri.parse("tel:$phone");

                        await launchUrl(
                        phoneUri,
                        mode: LaunchMode.externalApplication,
                        );
                    },
                    child: Container(
                     padding: const EdgeInsets.symmetric(vertical: 13),
                      height: MediaQuery.of(context).size.height*0.1,
                      decoration: BoxDecoration(
                        color: CustomColor.Container_Colors,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                              "Help And Support Please Call",
                              style: AppTextStyles.medium(),
                            ),

                          const Icon(Icons.call,
                              size: 25, color: Colors.white),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}