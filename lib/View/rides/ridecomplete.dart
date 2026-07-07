
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
                                Get.to(ThanksScreen());

                                // /// Booking ID
                                // final box = GetStorage();
                                //
                                // final bookingData = box.read("booking");
                                //
                                // final bookingId = bookingData != null
                                //     ? bookingData["id"].toString()
                                //     : "";
                                //
                                // if (bookingId.isEmpty) {
                                //   Get.snackbar(
                                //     "Error",
                                //     "Booking ID not found",
                                //   );
                                //   return;
                                // }
                                //
                                // /// Cash = 1
                                // if (paymentController.paymentMethod.value == "Cash") {
                                //   paymentController.selectMethod(0);
                                // }
                                //
                                // /// Credit Card = 2
                                // else {
                                //   paymentController.selectMethod(1);
                                // }
                                //
                                // /// API
                                // // await paymentController.updatePaymentMethodApi(bookingId);


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