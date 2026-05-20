import 'package:customer/Controller/Deshboard/deshboard_cont.dart';
import 'package:customer/View/Deshboard/AddHome/add_home.dart';
import 'package:customer/View/Deshboard/AddWork/add_work.dart';

import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/text_button.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/Home/home-controller.dart';
import '../../Routing/routes_name.dart';
import '../profile/controller/profile_controller.dart';
import '../yourtrip/yourtrip.dart';
import 'Home/homedriver.dart';
import 'drawer/drawer.dart';
import 'map_widget/open_street_map.dart';

class DeshBoard_Screen extends StatefulWidget {
  DeshBoard_Screen({super.key});

  @override
  State<DeshBoard_Screen> createState() => _DeshBoard_ScreenState();
}

class _DeshBoard_ScreenState extends State<DeshBoard_Screen> {

  final profileController = Get.isRegistered<profileModelController>()
      ? Get.find<profileModelController>()
      : Get.put(profileModelController());

  final homeC = Get.isRegistered<SwapController>()
      ? Get.find<SwapController>()
      : Get.put(SwapController());

  final deshboard_controller = Get.isRegistered<DeshBoardAddHome_Controller>()
      ? Get.find<DeshBoardAddHome_Controller>()
      : Get.put(DeshBoardAddHome_Controller());

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

    final bool isKeyboardOpen =
        MediaQuery.of(context).viewInsets.bottom > 0;

    return GetBuilder<profileModelController>(
      builder: (profileController) {

        return SafeArea(
          child: Scaffold(
            key: _scaffoldkey,
            drawerEnableOpenDragGesture: false,
            drawer: appDrawer(),
            backgroundColor: const Color(0xFF5E266F),

            body: Column(
              children: [

                // ================= MAP SECTION =================
                Flexible(
                  flex: 6,
                  child: Stack(
                    children: [

                      if (!isKeyboardOpen)
                        Obx(() {
                          return deshboard_controller.showMap.value
                              ? RepaintBoundary(
                            child: PickupLocationScreen(),
                          )
                              : const SizedBox();
                        }),

                      Positioned(
                        left: 10,
                        top: 20,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: CustomColor.Container_Colors,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _scaffoldkey.currentState!.openDrawer();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ================= BOTTOM SECTION =================
                Flexible(
                  flex: 4,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // ================= USER NAME =================
                        Row(
                          children: [
                            const SizedBox(width: 8),

                            Icon(
                              Icons.person_2_rounded,
                              size: 27,
                              color: CustomColor.textColor,
                            ),

                            const SizedBox(width: 10),

                            Text(
                              profileController.profileData?.customer?.name ??
                                  "Loading...",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.medium(
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // ================= WHERE TO =================
                        InkWell(
                          onTap: () {
                            Get.toNamed(routesName.HomeDriver);
                            homeC.pickupCurrentLocation();
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: const Color(0xFFB7D98F).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Where To",
                                  style: AppTextStyles.medium(
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  size: 40,
                                  color: CustomColor.Icon_Color,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // ================= ADD HOME =================
                        CustomTextButton(
                          text: "Add Home",
                          onPressed: () => Get.to(AddHomeScreen()),
                          icon: Icon(Icons.home,
                              color: CustomColor.Icon_Color),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),

                        const SizedBox(height: 5),

                        // ================= ADD WORK =================
                        CustomTextButton(
                          text: "Add Work",
                          onPressed: () => Get.to(AddWork_Screen()),
                          icon: Icon(Icons.work,
                              color: CustomColor.Icon_Color),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),

                        const SizedBox(height: 5),

                        // ================= PREVIOUS TRIP =================
                        CustomTextButton(
                          text: "Previous Trip",
                          onPressed: () => Get.to(Yourtrip()),
                          icon: Icon(Icons.picture_in_picture,
                              color: CustomColor.Icon_Color),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// class DeshBoard_Screen extends StatefulWidget {
//   DeshBoard_Screen({super.key});
//
//   @override
//   State<DeshBoard_Screen> createState() => _DeshBoard_ScreenState();
// }
//
// class _DeshBoard_ScreenState extends State<DeshBoard_Screen> {
//
//   final profileController = Get.isRegistered<profileModelController>()
//       ? Get.find<profileModelController>()
//       :  Get.put(profileModelController());
//
//   final homeC = Get.isRegistered<SwapController>()
//       ? Get.find<SwapController>()
//       : Get.put(SwapController());
//
//   final deshboard_controller = Get.isRegistered<DeshBoardAddHome_Controller>()
//       ? Get.find<DeshBoardAddHome_Controller>()
//       : Get.put(DeshBoardAddHome_Controller());
//
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
//     final screenHeight = MediaQuery.of(context).size.height;
//
//
//     /// Keyboard check (NON-reactive → Obx se bahar)
//     final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
//
//
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldkey,
//         resizeToAvoidBottomInset: true,
//         drawerEnableOpenDragGesture: false,
//         drawer: appDrawer(),
//         backgroundColor:   Color(0xFF5E266F),
//         body: Column(
//           children: [
//             // ================= Top → Map Area
//             Flexible(
//               flex: 6,
//               child: Stack(
//                 children: [
//
//                   ///          ================= Map Widget FIXED =================
//
//
//                   /// MAP (Only Rx here)
//                   if (!isKeyboardOpen)
//                     Obx(() {
//                       return deshboard_controller.showMap.value
//                           ? RepaintBoundary(
//                         child: PickupLocationScreen(),
//                       )
//                           : const SizedBox();
//                     }),
//
//
//
//                   // Obx(() {
//                   //     if (MediaQuery.of(context).viewInsets.bottom > 0) {
//                   //       return const SizedBox(); // keyboard open → hide map
//                   //     }
//                   //     if (deshboard_controller.showMap.value) {
//                   //       return RepaintBoundary(child: PickupLocationScreen());
//                   //     } else {
//                   //       return const SizedBox();
//                   //     }
//                   //   }),
//
//                     // SizedBox(
//                     //   height: screenHeight * 0.6,
//                     //   width: double.infinity,
//                     //   child:   // 🔒 isolates map from rebuild
//                     //   PickupLocationScreen(),
//                     //
//                     // ),
//
//                   // Positioned.fill(
//                   //   child: LayoutBuilder(
//                   //     builder: (context, constraints) {
//                   //       final isKeyboardOpen =
//                   //           MediaQuery.of(context).viewInsets.bottom > 0;
//                   //
//                   //       return IgnorePointer(
//                   //         ignoring: isKeyboardOpen,
//                   //         child: PickupLocationScreen(),
//                   //       );
//                   //     },
//                   //   ),
//                   // ),
//                  //  Positioned.fill(
//                  //    child: Image.asset(
//                  //      "assets/images/map2.png",
//                  //      fit: BoxFit.cover,
//                  //    ),
//                  //  ),
//                  // // Uncomment this to use actual map widget
//                  //  Positioned.fill(
//                  //    child:PickupLocationScreen(),
//                  //  ),
//
//                   // Drawer button
//
//                   Positioned(
//                     left: 10,
//                     top: 20,
//                     child: Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                         color: CustomColor.Container_Colors,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: IconButton(
//                         icon: Icon(
//                           Icons.person,
//                           size: 30,
//                           color: Colors.grey,
//                         ),
//                         onPressed: () {
//                           _scaffoldkey.currentState!.openDrawer();
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // ================= Bottom → Content
//             Flexible(
//               flex: 4,
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // User row
//                     Row(
//                       children: [
//                         const SizedBox(width: 8),
//                         Icon(
//                           Icons.person_2_rounded,
//                           size: 27,
//                           color: CustomColor.textColor,
//                         ),
//                         const SizedBox(width: 10),
//                         Text(
//                          profileController.profileData?.customer!.name ?? "User name ",
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: AppTextStyles.medium(weight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//
//                     // "Where To" box
//
//                     InkWell(
//                       onTap: () {
//                         Get.toNamed(routesName.HomeDriver);
//                         homeC.pickupCurrentLocation();
//                       },
//                       child: Container(
//                         height: 50,
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFB7D98F).withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Where To",
//                               style: AppTextStyles.medium(
//                                 weight: FontWeight.bold,
//                               ),
//                             ),
//                             Icon(
//                               Icons.arrow_right,
//                               size: 40,
//                               color: CustomColor.Icon_Color,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//
//                     // Add Home
//                     CustomTextButton(
//                       text: "Add Home",
//                       onPressed: () => Get.to(AddHomeScreen()),
//                       icon: Icon(Icons.home, color: CustomColor.Icon_Color),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                     const SizedBox(height: 5),
//
//                     // Add Work
//                     CustomTextButton(
//                       text: "Add Work",
//                       onPressed: () => Get.to(AddWork_Screen()),
//                       icon: Icon(Icons.work, color: CustomColor.Icon_Color),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                     const SizedBox(height: 5),
//
//                     // Previous Trip
//                     CustomTextButton(
//                       text: "Previous Trip",
//                       onPressed: () => Get.to(Yourtrip()),
//                       icon: Icon(
//                         Icons.picture_in_picture,
//                         color: CustomColor.Icon_Color,
//                       ),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//














