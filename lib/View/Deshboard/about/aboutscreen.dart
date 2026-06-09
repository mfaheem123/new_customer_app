//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../Controller/Deshboard/deshboard_cont.dart';
// import '../map_widget/map_controller.dart';
// import '../map_widget/open_street_map.dart';
// import '../../Widgets/color.dart';
// import '../../Widgets/elevat_button.dart';
// import '../../Widgets/all_text.dart';
// import '../../textstyle/apptextstyle.dart';
//
// class Aboutscreen extends StatelessWidget {
//   Aboutscreen({super.key});
//
//   final controller = Get.isRegistered<PickLocationController>()
//       ? Get.find<PickLocationController>()
//       : Get.put(PickLocationController());
//
//   final deshboardcontroller = Get.isRegistered<DeshBoardAddHome_Controller>()
//       ? Get.find<DeshBoardAddHome_Controller>()
//       : Get.put(DeshBoardAddHome_Controller());
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           width: size.width,
//           height: size.height,
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
//
//           // ✅ IMPORTANT FIX
//           child:Padding(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ================= HEADER
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 0),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: () => Get.back(),
//                         icon: Icon(
//                           Icons.arrow_back,
//                           size: 25,
//                           color: CustomColor.Icon_Color,
//                         ),
//                       ),
//
//                       Expanded(
//                         child: Center(
//                           child: Text(
//                             CustomText.About,
//                             style: AppTextStyles.heading(),
//                           ),
//                         ),
//                       ),
//
//                       // right side empty space for perfect center
//                       const SizedBox(width: 48),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 15),
//
//                 // ================= APP NAME
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Text("SEA CARS PRIVATE HIRE LTD", style: AppTextStyles.heading(size: 20)),
//                 ),
//
//                 // ================= ADDRESS
//                 Padding(
//                   padding: const EdgeInsets.all(6.0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Icon(
//                         Icons.location_on_rounded,
//                         size: 20,
//                         color: Colors.red,
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           ("1 Warrior Gardens, St. Leonards-on-Sea TN37 6EB")
//                               .toUpperCase(),
//                           softWrap: true,
//                           maxLines: 3,
//                           overflow: TextOverflow.ellipsis,
//                           style: AppTextStyles.medium(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // ================= CALL / EMAIL
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Row(
//                     children: [
//                       const Spacer(),
//
//                       CircleAvatar(
//                         radius: 20,
//                         backgroundColor: Colors.white,
//                         child: IconButton(
//                           onPressed: () async {
//                             final Uri phoneUri = Uri.parse(
//                               "tel://01424202020",
//                             );
//
//                             await launchUrl(
//                               phoneUri,
//                               mode: LaunchMode.externalApplication,
//                             );
//                           },
//                           icon: const Icon(
//                             Icons.call,
//                             size: 20,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(width: 10),
//
//                       CircleAvatar(
//                         radius: 20,
//                         backgroundColor: Colors.white,
//                         child: IconButton(
//                           onPressed: () {
//                             deshboardcontroller.sendEmail();
//                           },
//                           icon: const Icon(
//                             Icons.email,
//                             size: 20,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                  Spacer(),
//
//                 // const SizedBox(height: 15),
//
//                 // ================= MAP (RESPONSIVE)
//                 Stack(
//                     children: [
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.65,
//                         width: double.infinity,
//                       ),
//
//                       Container(
//                        // margin: const EdgeInsets.symmetric(horizontal: 10),
//                         height: MediaQuery.of(context).size.height * 0.65,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           // borderRadius: BorderRadius.circular(20),
//                           // border: Border.all(color: Colors.grey, width: 2),
//                           image: const DecorationImage(
//                             image: AssetImage("assets/images/map_about.png"),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                          top :MediaQuery.of(context).size.height * 0.45,
//                         bottom: 60, // neechy
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 10),
//                           height: MediaQuery.of(context).size.height * 0.2,
//                           width: 100,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white,
//                             image: const DecorationImage(
//                               image: AssetImage("assets/images/logo.png"),
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                         ),
//                       ),
//
//
//
//                       // ================= WEBSITE BUTTON
//                       Positioned(
//                         //top :MediaQuery.of(context).size.height * 0.54,
//                         bottom: 19, // neechy
//                         left: 0,
//                         right: 0,
//
//                         child: Center(
//                           child: SizedBox(
//                             height: 55,
//                             width: 200,
//                             child: MyElevatedButton(
//                               backgroundColor: CustomColor.Button_background_Color.withOpacity(0.8),
//                               text: '',
//                               fontSize: 14,
//                               onPressed: () async {
//                                 final Uri url = Uri.parse(
//                                   "https://seacars.co.uk/#contact",
//                                 );
//
//                                 try {
//                                   await launchUrl(
//                                     url,
//                                     mode: LaunchMode.platformDefault,
//                                   );
//                                 } catch (e) {
//                                   print("Error: $e");
//                                 }
//                               },
//                               textWidget: FittedBox(
//                                 child: Text(
//                                   "WebSite Link",
//                                   style: AppTextStyles.regular(
//                                     size: 25,
//                                     weight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//
//                           ),
//                         ),
//                       ),
//
//                       Positioned(
//                         bottom: 1,
//                         left: 0,
//                         right: 0,
//                         child: Center(
//                           child: Text(
//                             "Version 1.0.0",
//                             style: AppTextStyles.small(
//                               size: 15,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ]
//
//                 ),
//
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Controller/Deshboard/deshboard_cont.dart';
import '../map_widget/map_controller.dart';
import '../../Widgets/color.dart';
import '../../Widgets/elevat_button.dart';
import '../../Widgets/all_text.dart';
import '../../textstyle/apptextstyle.dart';

class Aboutscreen extends StatelessWidget {
  Aboutscreen({super.key});

  final controller = Get.isRegistered<PickLocationController>()
      ? Get.find<PickLocationController>()
      : Get.put(PickLocationController());

  final deshboardcontroller = Get.isRegistered<DeshBoardAddHome_Controller>()
      ? Get.find<DeshBoardAddHome_Controller>()
      : Get.put(DeshBoardAddHome_Controller());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
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

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: CustomColor.Icon_Color,
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          CustomText.About,
                          style: AppTextStyles.heading(),
                        ),
                      ),
                    ),

                    const SizedBox(width: 48),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // ================= APP NAME
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "SEA CARS PRIVATE HIRE LTD",
                  style: AppTextStyles.heading(size: 20),
                ),
              ),

              // ================= ADDRESS
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 20,
                      color: Colors.red,
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        "1 Warrior Gardens, St. Leonards-on-Sea TN37 6EB"
                            .toUpperCase(),
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.medium(),
                      ),
                    ),
                  ],
                ),
              ),

              // ================= CALL / EMAIL
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Spacer(),

                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () async {
                          final Uri phoneUri = Uri.parse(
                            "tel://01424202020",
                          );

                          await launchUrl(
                            phoneUri,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        icon: const Icon(
                          Icons.call,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          deshboardcontroller.sendEmail();
                        },
                        icon: const Icon(
                          Icons.email,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ================= FULL SCREEN MAP
              Expanded(
                child: Stack(
                  children: [
                    // ================= MAP IMAGE
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/map_about.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // ================= CENTER LOGO
                    Positioned(
                      //top: 40,
                      bottom: 100,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Image(
                              image: AssetImage(
                                "assets/images/logo.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ================= WEBSITE BUTTON
                    Positioned(
                      bottom: 35,
                      left: 0,
                      right: 0,
                      child: Center(
                        child:SizedBox(
                          height: 55,
                          width: 200,
                          child: MyElevatedButton(
                            backgroundColor:
                            CustomColor.Button_background_Color.withOpacity(0.8),
                            text: '',
                            fontSize: 14,
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                "https://seacars.co.uk/#contact",
                              );

                              try {
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              } catch (e) {
                                print("Error: $e");
                              }
                            },

                            // 👇 Yahan icon + text add kiya hai
                            textWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.public, // world icon
                                  color: Colors.white,
                                  size: 24,
                                ),
                                const SizedBox(width: 8),

                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      "WebSite Link",
                                      style: AppTextStyles.regular(
                                        size: 25,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 55,
                        //   width: 200,
                        //   child: MyElevatedButton(
                        //     backgroundColor:
                        //     CustomColor.Button_background_Color
                        //         .withOpacity(0.8),
                        //     text: '',
                        //     fontSize: 14,
                        //     onPressed: () async {
                        //       final Uri url = Uri.parse(
                        //         "https://seacars.co.uk/#contact",
                        //       );
                        //
                        //       try {
                        //         await launchUrl(
                        //           url,
                        //           mode: LaunchMode.platformDefault,
                        //         );
                        //       } catch (e) {
                        //         print("Error: $e");
                        //       }
                        //     },
                        //     textWidget: FittedBox(
                        //       child: Text(
                        //         "WebSite Link",
                        //         style: AppTextStyles.regular(
                        //           size: 25,
                        //           weight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),

                    // ================= VERSION
                    Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          "Version 1.0.0",
                          style: AppTextStyles.small(
                            size: 15,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}