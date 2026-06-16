
import 'package:customer/View/Deshboard/map_widget/map_polyLine.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/rides/ridecomplete.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/Home/home-controller.dart';
import '../../Controller/Ride/RideController.dart';
import '../Deshboard/map_widget/tracking_driver_map.dart';
import '../Widgets/all_text.dart';


class Driverdetailscreen extends StatefulWidget {
  const Driverdetailscreen({super.key});

  @override
  State<Driverdetailscreen> createState() => _DriverdetailscreenState();
}

class _DriverdetailscreenState extends State<Driverdetailscreen> {
  final controller = Get.isRegistered<RideController>()
      ? Get.find<RideController>()
      : Get.put(RideController());

  final swapController = Get.isRegistered<SwapController>()
      ? Get.find<SwapController>()
      : Get.put(SwapController());



  @override
  void initState() {
    super.initState();

    // 🔥 driverId arguments se lo
    final driverId = Get.arguments['id'];

    controller.startPolling(driverId.toString());
  }


  @override
      void dispose() {
          controller.stopPolling();
          super.dispose();
      }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
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
              // ================= Top section (Back + Title)
              Container(
                height: screenHeight * 0.08,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    // IconButton(
                    //   onPressed: () => Get.back(),
                    //   icon: Icon(
                    //     Icons.arrow_back,
                    //     size: screenWidth * 0.06,
                    //     color: CustomColor.Icon_Color,
                    //   ),
                    // ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Center(
                        child: Text(
                          CustomText.Driver_Info,
                          style: AppTextStyles.heading(
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.06),
                  ],
                ),
              ),

              // ================= Map Section
              // Expanded(
              //   flex: 6,
              //   child: Container(
              //     margin: const EdgeInsets.symmetric(horizontal: 10),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(18),
              //     ),
              //     child: const ClipRRect(
              //       borderRadius: BorderRadius.all(Radius.circular(18)),
              //       child: MapScreen(),
              //     ),
              //   ),
              // ),
              SizedBox(height: 20),
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
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
                   child: TrackingMap( c: Get.isRegistered<SwapController>()
                       ? Get.find<SwapController>()
                       : Get.put(SwapController())),
                   //  child: MapScreen(),
                  ),
                ),
              ),

             // ================= Bottom Driver Info Section
              ///
              SizedBox(height: 50,),
              Expanded(
                flex: 4,
                child: Obx(() {
                  // 🔥 FULL LOADING STATE
                  if (controller.isLoading.value) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: CustomColor.Container_Colors,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        ),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  // 🔥 DATA UI (same as your UI)
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    decoration: BoxDecoration(
                      color: CustomColor.Container_Colors,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                          SizedBox(height: 15),
                      
                          // 🔹 Driver Name
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.grey, width: 1.5),
                                  ),
                                  child: CircleAvatar(
                                    radius: 25, // 👈 choti profile image
                                    backgroundImage: NetworkImage(
                                      Uri.encodeFull(controller.driverGetbyId!.driver.image),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    controller.driverName.value,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.heading(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                      
                          // 🔹 Status
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  CustomText.Status + " : ",
                                  style: AppTextStyles.medium(),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  height: 30,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: controller.bookingStatus.value == "Available"
                                        ? Colors.blueAccent
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      controller.bookingStatus.value,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.medium(weight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                      
                          // 🔹 Vehicle info + image
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${CustomText.Vehicle_Color} : ",
                                            style: AppTextStyles.medium()),
                                        Text(
                                          controller.vehicleColor.value,
                                          style:  AppTextStyles.medium(weight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Text("${CustomText.Vehicle_number} : ",
                                            style: AppTextStyles.medium()),
                                        Text(
                                          controller.vehicleNumber.value,
                                          style: AppTextStyles.medium(weight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                // Container(
                                //   margin: EdgeInsets.only(right: 10),
                                //   height: 60,
                                //   width: 100,
                                //   child: Image.asset(
                                //     "assets/images/carimage.jpg",
                                //     fit: BoxFit.contain,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          // Center(
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       Get.to(RideCompleteScreen());
                          //     },
                          //     child: Text("Move to feedback screen"),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}






