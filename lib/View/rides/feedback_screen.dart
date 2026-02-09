import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:get/get.dart';
import '../Deshboard/dashboard.dart';
import '../Widgets/all_text.dart';
import '../Widgets/elevat_button.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                              IconButton(
                                onPressed: () => Get.back(),
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: isTablet ? 32 : 26,
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
                                Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: isTablet ? 36 : 28,
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
                                  "Muhammad Ibad Ullah Qureshi",
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
                                  "1A Worrior Garden St. LEO Worrior Garden St. LEO TN36eb",
                                  maxLines: 3,
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
                                "Cash",
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

                          /// ================= EMOJI FEEDBACK =================
                          Center(
                            child: SizedBox(
                              width: isTablet ? 400 : double.infinity,
                              child: EmojiFeedback(
                                initialRating: 4,
                                animDuration:
                                const Duration(milliseconds: 300),
                                curve: Curves.bounceIn,
                                labelTextStyle: AppTextStyles.small(
                                  size: isTablet ? 16 : 14,
                                ),
                                inactiveElementScale: .5,
                                onChanged: (value) {},
                                onChangeWaitForAnimation: true,
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



// import 'package:customer/View/textstyle/apptextstyle.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
// import 'package:get/get.dart';
// import '../Deshboard/dashboard.dart';
// import '../Widgets/all_text.dart';
// import '../Widgets/elevat_button.dart';
//
// class ThanksScreen extends StatelessWidget {
//   const ThanksScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           padding: const EdgeInsets.all(15),
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromARGB(255, 30, 1, 44),
//                 Color.fromARGB(255, 227, 194, 242),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// ================= TOP BAR =================
//                 SizedBox(
//                   height: height * 0.08,
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: () => Get.back(),
//                         icon: Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                           size: width * 0.06,
//                         ),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: Text(
//                             CustomText.PaymentsDone,
//                             style: TextStyle(
//                               fontSize: width * 0.055,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                       // IconButton(
//                       //   onPressed: () {},
//                       //   icon: Icon(
//                       //     Icons.edit_notifications_sharp,
//                       //     color: Colors.yellow,
//                       //     size: width * 0.06,
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: height * 0.02),
//
//                 /// ================= THANK YOU BOX =================
//                 Container(
//                   height: height * 0.2,
//                   padding: EdgeInsets.only(top: 30),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         CustomText.Thanks_caption,
//                         textAlign: TextAlign.center,
//                         style: AppTextStyles.medium(),
//                       ),
//                       const SizedBox(height: 10),
//                       const Icon(
//                         Icons.favorite,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: height * 0.02),
//
//                 /// ================= NAME =================
//                 Row(
//                   children: [
//                     Text(
//                       "${CustomText.Name_thnks_scr} : ",
//                       style: AppTextStyles.medium(),
//                     ),
//                     Expanded(
//                       child: Text(
//                         "Muhammad Ibad Ullah Qureshi",
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: AppTextStyles.medium(),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: height * 0.015),
//
//                 /// ================= ADDRESS =================
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Icon(Icons.location_on, color: Colors.red),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Text(
//                         "1A Worrior Garden St. LEO Worrior Garden St. LEO TN36eb",
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: AppTextStyles.medium(),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: height * 0.015),
//
//                 /// ================= PAYMENT METHOD =================
//                 Row(
//                   children: [
//                     Text(
//                       "${CustomText.Payments_Method} : ",
//                       style: AppTextStyles.medium(),
//                     ),
//                     const SizedBox(width: 5),
//                     Text(
//                       "Cash",
//                       style: AppTextStyles.medium(),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: height * 0.01),
//
//                 /// ================= STATUS =================
//                 Row(
//                   children: [
//                     Text(
//                       "${CustomText.Status} : ",
//                       style: AppTextStyles.medium(),
//                     ),
//                     const SizedBox(width: 5),
//                     Text(
//                       "Paid",
//                       style: AppTextStyles.medium(),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: height * 0.05),
//
//                 /// ================= EMOJI FEEDBACK =================
//                 Center(
//                   child: SizedBox(
//                     width: width * 0.9,
//                     child: EmojiFeedback(
//                       initialRating: 4,
//                       animDuration: const Duration(milliseconds: 300),
//                       curve: Curves.bounceIn,
//                       labelTextStyle: AppTextStyles.small(),
//                       inactiveElementScale: .5,
//                       onChanged: (value) {},
//                       onChangeWaitForAnimation: true,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: height * 0.05),
//
//                 /// ================= DONE BUTTON =================
//                 Center(
//                   child: SizedBox(
//                     height: 55,
//                     width: 250,
//                     child: MyElevatedButton(
//                       text: '',
//                       textWidget: FittedBox(
//                         child: Text(
//                           "Done",
//                           style: AppTextStyles.medium(
//                             size: 25,
//                             weight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       onPressed: () {
//                         Get.offAll(() => DeshBoard_Screen());
//                       },
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: height * 0.03),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
