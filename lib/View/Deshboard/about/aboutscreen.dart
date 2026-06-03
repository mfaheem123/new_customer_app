// import 'package:customer/View/Widgets/all_text.dart';
// import 'package:customer/View/Widgets/color.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../Controller/Deshboard/deshboard_cont.dart';
// import '../../Widgets/elevat_button.dart';
// import '../../textstyle/apptextstyle.dart';
// import '../map_widget/map_controller.dart';
// import '../map_widget/open_street_map.dart';
//
//
//
// class Aboutscreen extends StatelessWidget {
//    Aboutscreen({super.key});
//   // final mapWedgit =OpenStreetMapWidget();
//
//
//    final controller = Get.isRegistered<PickLocationController>()
//        ? Get.find<PickLocationController>()
//        : Get.put(PickLocationController());
//    final deshboardcontroller = Get.isRegistered<DeshBoardAddHome_Controller>()
//        ? Get.find<DeshBoardAddHome_Controller>()
//        : Get.put(DeshBoardAddHome_Controller());
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         //backgroundColor: CustomColor.background,
//
//         body:  Container(
//           height:MediaQuery.of(context).size.height,
//           width:MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromARGB(255, 30, 1, 44),
//                 Color.fromARGB(255, 227, 194, 242)
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child : Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             Get.back();
//                           },
//                           icon: Icon(
//                             Icons.arrow_back,
//                             size: MediaQuery.of(context).size.width * 0.06,
//                             color: CustomColor.Icon_Color,
//                           ),
//                         ),
//
//                         // SizedBox(width: 5),
//
//                         Expanded(
//                           child: Center(
//                             child: Text(
//                               CustomText.About,
//                               style: AppTextStyles.heading(
//                                 size: MediaQuery.of(context).size.width * 0.06,
//
//                               ),
//                             ),
//                           ),
//                         ),
//
//
//                       ],
//                     ),
//
//
//                     // Row(
//                     //   children: [
//                     //
//                     //     Padding(
//                     //       padding:  EdgeInsets.only(left: 15),
//                     //       child: Container(
//                     //         decoration: BoxDecoration(
//                     //           color: Colors.blueGrey,
//                     //           borderRadius: BorderRadius.circular(7),
//                     //         ),
//                     //         height: 40,
//                     //         width: 40,
//                     //         child: IconButton(
//                     //           onPressed: () {
//                     //             Get.back();
//                     //           },
//                     //           icon:  Icon(Icons.arrow_back, size: 25, color: Colors.white),
//                     //         ),
//                     //       ),
//                     //     ),
//                     //
//                     //
//                     //      SizedBox(width: 10),
//                     //
//                     //
//                     //     Expanded(
//                     //       child: Center(
//                     //         child: Text(
//                     //           CustomText.About,
//                     //           style: TextStyle(
//                     //             fontSize: MediaQuery.of(context).size.width * 0.065, // responsive font
//                     //             color: Colors.white,
//                     //             fontWeight: FontWeight.bold,
//                     //           ),
//                     //         ),
//                     //       ),
//                     //     ),
//                     //
//                     //
//                     //     SizedBox(width: 55),
//                     //   ],
//                     // ),
//
//
//                     SizedBox(height: 15,),
//
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Text("CRMILES",
//                           style: AppTextStyles.heading()
//                       ),
//                     ),
//                     //==================================  address
//                     Container(
//                       padding: const EdgeInsets.all(10.0),
//                       width: 400,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           Padding(
//                             padding: const EdgeInsets.only(top: 5.0),
//                             child: Icon(Icons.location_on_rounded, size:20 , color: Colors.white),
//                           ),
//                           SizedBox(width: 5),
//                           Expanded(
//                             child: Obx(() => Text(
//                               controller.address.value, // ✅ correct
//                               softWrap: true,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: AppTextStyles.medium(),
//                             )),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     //=====================================          buttons call and email
//                     Container(
//                       height: 50,
//                       padding:  EdgeInsets.symmetric(horizontal: 10), // optional padding
//                       child: Row(
//                         children: [
//
//                           Spacer(),
//
//
//                           CircleAvatar(
//                             radius: 20,
//                             backgroundColor: Colors.white,
//                             child: IconButton(
//                               onPressed: () async {
//                                 const phone = "tel://03001234567";
//                                 final Uri phoneUri = Uri.parse(phone);
//
//                                 try {
//                                   bool launched = await launchUrl(
//                                     phoneUri,
//                                     mode: LaunchMode.externalApplication,
//                                   );
//
//                                   if (!launched) {
//                                     print("Dialer app not found");
//                                   }
//                                 } catch (e) {
//                                   print("Error: $e");
//                                 }
//                               },
//                               icon:  Icon(Icons.call, size: 20, color: Colors.black),
//                             ),
//                           ),
//
//                           SizedBox(width: 5),
//
//
//                           CircleAvatar(
//                             radius: 20,
//                             backgroundColor: Colors.white,
//                             child: IconButton(
//                               onPressed: () {
//                                 deshboardcontroller.sendEmail();
//                               },
//                               icon:  Icon(Icons.email, size: 20, color: Colors.black),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 10
//                       ,),
//                   ],
//                 ),
//               ),
//
//               //============================================   map
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: Colors.grey, width: 2),
//                   image: const DecorationImage(
//                     image: AssetImage("assets/images/map_image.png"),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 height: 450,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(18),
//                   child: PickupLocationScreen(),
//                 ),
//                 // child: Image(image: AssetImage("assets/images/map2.png"),fit: BoxFit.cover,),
//
//               ),
//
//               SizedBox(
//                 height: 55,
//                 width: 250,
//                 child: MyElevatedButton(
//                   text: '',
//                   fontSize: 14,
//                   onPressed: ()async  {
//                     final Uri url = Uri.parse('https://seacars.co.uk');
//
//                     if (await canLaunchUrl(url)) {
//                     await launchUrl(
//                     url,
//                     mode: LaunchMode.externalApplication,
//                     );
//                     }
//
//
//                   },
//                   textWidget: FittedBox(
//                     child: Text(
//                       "WebSite Link",
//                       style: AppTextStyles.regular(
//                         size: 25,
//                         weight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//
//
//
//             ],
//           ),
//         ),
//
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Controller/Deshboard/deshboard_cont.dart';
import '../map_widget/map_controller.dart';
import '../map_widget/open_street_map.dart';
import '../../Widgets/color.dart';
import '../../Widgets/elevat_button.dart';
import '../../Widgets/all_text.dart';
import '../../textstyle/apptextstyle.dart';

class Aboutscreen extends StatelessWidget {
  Aboutscreen({super.key});

  final controller = Get.isRegistered<PickLocationController>()
      ? Get.find<PickLocationController>()
      : Get.put(PickLocationController());

  final deshboardcontroller =
  Get.isRegistered<DeshBoardAddHome_Controller>()
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

          // ✅ IMPORTANT FIX
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ================= HEADER
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.arrow_back,
                            size: size.width * 0.06,
                            color: CustomColor.Icon_Color,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              CustomText.About,
                              style: AppTextStyles.heading(
                                size: size.width * 0.06,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ================= APP NAME
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "CRMILES",
                      style: AppTextStyles.heading(),
                    ),
                  ),

                  // ================= ADDRESS
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Obx(() => Text(
                            controller.address.value,
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.medium(),
                          )),
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
                              final Uri phoneUri =
                              Uri.parse("tel://01424202020");

                              await launchUrl(
                                phoneUri,
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            icon: const Icon(Icons.call,
                                size: 20, color: Colors.black),
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
                            icon: const Icon(Icons.email,
                                size: 20, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ================= MAP (RESPONSIVE)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: size.height * 0.5, // ✅ FIXED RESPONSIVE
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey, width: 2),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/map_image.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: PickupLocationScreen(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= WEBSITE BUTTON
                  Center(
                    child: SizedBox(
                      height: 55,
                      width: 200,
                      child: MyElevatedButton(
                        text: '',
                        fontSize: 14,
                        onPressed: () async {
                          final Uri url =
                          Uri.parse('https://seacars.co.uk');

                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        textWidget: FittedBox(
                          child: Text(
                            "WebSite Link",
                            style: AppTextStyles.regular(
                              size: 25,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
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
  }
}