import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Deshboard/dashboard.dart';
import '../Widgets/all_text.dart';
import '../Widgets/color.dart';
import '../Widgets/elevat_button.dart';
import 'model/booking_get_by_id/booking_get_model.dart';

class ThanksScreen extends StatelessWidget {
  ThanksScreen({super.key});

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {

    /// 🔥 GET BOOKING FROM STORAGE
    final bookingData = box.read("booking");

    final booking = bookingData != null
        ? Booking.fromJson(bookingData)
        : null;

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final isTablet = maxWidth > 600;

            final contentWidth = isTablet ? 600.0 : maxWidth;
            final horizontalPadding = isTablet ? 30.0 : 15.0;

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 30, 1, 44),
                    Color.fromARGB(255, 227, 194, 242),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// ================= TOP BAR =================
                          Row(
                            children: [
                              Container(
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

                              Expanded(
                                child: Center(
                                  child: Text(
                                    CustomText.PaymentsDone,
                                    style: TextStyle(
                                      fontSize: isTablet ? 24 : 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                              // right side balance space (same as back button)
                              const SizedBox(width: 48),
                            ],
                          ),

                          const SizedBox(height: 20),

                          /// ================= THANK YOU BOX =================
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 25,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  CustomText.Thanks_caption,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.medium(
                                    size: isTablet ? 20 : 16,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25),

                          /// ================= NAME =================
                          Row(
                            children: [
                              Text(
                                "${CustomText.Name_thnks_scr} : ",
                                style: AppTextStyles.medium(
                                  size: isTablet ? 20 : 18,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  (booking?.name ?? "N/A").toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.medium(
                                    size: isTablet ? 20 : 18,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          /// ================= ADDRESS =================
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on, color: Colors.red),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  (booking?.dropoff ?? "No Address Found").toUpperCase(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.medium(
                                    size: isTablet ? 20 : 18,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          /// ================= PAYMENT METHOD =================
                          Row(
                            children: [
                              Text(
                                "${CustomText.Payments_Method} : ",
                                style: AppTextStyles.medium(
                                  size: isTablet ? 20 : 18,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                booking?.paymentTypeId == 1
                                    ? "Cash"
                                    : "Credit Card",
                                style: AppTextStyles.medium(
                                  size: isTablet ? 20 : 18,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          /// ================= STATUS =================
                          Row(
                            children: [
                              Text(
                                "${CustomText.Status} : ",
                                style: AppTextStyles.medium(
                                  size: isTablet ? 20 : 18,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Paid",
                                style: AppTextStyles.medium(
                                  size: isTablet ? 20 : 18,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 35),

                          /// ================= EMOJI =================
                          Center(
                            child: SizedBox(
                              width: isTablet ? 400 : double.infinity,
                              child: EmojiFeedback(
                                initialRating: 4,
                                animDuration: const Duration(milliseconds: 300),
                                curve: Curves.bounceIn,
                                labelTextStyle: AppTextStyles.small(
                                  size: isTablet ? 16 : 14,
                                ),
                                inactiveElementScale: .5,
                                onChanged: (value) {},
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          /// ================= DONE BUTTON =================
                          Center(
                            child: SizedBox(
                              height: 55,
                              width: isTablet ? 300 : 240,
                              child: MyElevatedButton(
                                text: '',
                                textWidget: FittedBox(
                                  child: Text(
                                    "Done",
                                    style: AppTextStyles.medium(
                                      size: isTablet ? 26 : 22,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onPressed: () {

                                  /// 🔥 REMOVE BOOKING FROM STORAGE
                                  box.remove("booking");

                                  /// GO DASHBOARD
                                  Get.offAll(() => DeshBoard_Screen());
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}