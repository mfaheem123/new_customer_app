import 'package:customer/Controller/Deshboard/deshboard_cont.dart';
import 'package:customer/View/Deshboard/AddHome/add_home.dart';
import 'package:customer/View/Deshboard/AddWork/add_work.dart';
import 'package:customer/View/Home/homedriver.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/text_button.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../yourtrip/yourtrip.dart';
import 'drawer/drawer.dart';


class DeshBoard_Screen extends StatelessWidget {
  DeshBoard_Screen({super.key});

 // final DeshBoardAddHome_Controller deshboard_controller = Get.find();
  final deshboard_controller = Get.isRegistered<DeshBoardAddHome_Controller>()
      ? Get.find<DeshBoardAddHome_Controller>()
      :  Get.put(DeshBoardAddHome_Controller());


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        drawerEnableOpenDragGesture: false,
        drawer: appDrawer(),
        backgroundColor: CustomColor.background,
        body: Container(
          color:  Color(0xFF5E266F),
          // height:MediaQuery.of(context).size.height,
          // width:MediaQuery.of(context).size.width,
          //
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [
          //       Color.fromARGB(255, 30, 1, 44),
          //       Color.fromARGB(255, 227, 194, 242)
          //     ],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //   ),
          // ),
          child: Column(
            children: [
              // ================= Top 60% → Map
              SizedBox(
                height: screenHeight * 0.6,
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/map2.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned(
                      left: 10,
                      top: 20,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: CustomColor.background,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.person, size: 30, color: Colors.grey),
                          onPressed: () {
                            _scaffoldkey.currentState!.openDrawer();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ================= Bottom 40% → Content
              Container(
                height: screenHeight * 0.358,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                color: Color(0xFF5E266F),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User row
                    Row(
                      children: [
                        SizedBox(width: 8,),
                        Icon(Icons.person_2_rounded, size: 27, color: CustomColor.textColor),
                        const SizedBox(width: 10),
                        Text(
                          "User Name",
                          style: AppTextStyles.medium(weight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // "Where To" box
                    InkWell(
                      onTap: () => Get.to(HomeDriver()),
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
                              style: AppTextStyles.medium(weight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_right, size: 40, color: CustomColor.Icon_Color),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Add Home
                    CustomTextButton(
                      text: "Add Home",
                      onPressed: () => Get.to(AddHomeScreen()),
                      icon: Icon(Icons.home, color: CustomColor.Icon_Color),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    // Obx(
                    //       () => Padding(
                    //         padding: EdgeInsetsGeometry.only(left:20 ),
                    //         child: Text(
                    //                               deshboard_controller.homeAddress.isEmpty
                    //           ? ''
                    //           : deshboard_controller.homeAddress.toString(),
                    //                               style: AppTextStyles.small(size: 12),
                    //                             ),
                    //       ),
                    // ),
                    const SizedBox(height: 5),

                    // Add Work
                    CustomTextButton(
                      text: "Add Work",
                      onPressed: () => Get.to(AddWork_Screen()),
                      icon: Icon(Icons.work, color: CustomColor.Icon_Color),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    const SizedBox(height: 5),

                    // Previous Trip
                    CustomTextButton(
                      text: "Previous Trip",
                      onPressed: () => Get.to(Yourtrip()),
                      icon: Icon(Icons.picture_in_picture, color: CustomColor.Icon_Color),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
