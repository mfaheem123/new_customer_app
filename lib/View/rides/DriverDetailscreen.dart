
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

    final driverId = (Get.arguments is Map) ? Get.arguments['id'] : Get.arguments;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      swapController.resetDriverTracking();
      if (driverId != null) {
        controller.startPolling(driverId.toString());
      }
    });
  }


  @override
      void dispose() {
          controller.stopPolling();
          super.dispose();
      }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
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
            children: [
              // ================= Top section (Back + Title)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: CustomColor.Icon_Color,
                        size: 24,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          CustomText.Driver_Info,
                          style: AppTextStyles.heading(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // ================= Map Section (Bigger & Sleek)
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(12, 0, 12, 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const MapScreen(),
                  ),
                ),
              ),

              // ================= Bottom Driver Info Section
              Obx(() {
                // 🔥 FULL LOADING STATE
                if (controller.isLoading.value) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                      color: CustomColor.Container_Colors,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                // 🔥 DATA UI
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  decoration: const BoxDecoration(
                    color: CustomColor.Container_Colors,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Drag handle
                        Center(
                          child: Container(
                            width: 38,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // 🔹 Driver Name & Photo
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white24, width: 1.5),
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      (controller.driverGetbyId?.driver.image == null ||
                                              controller.driverGetbyId!.driver.image.isEmpty)
                                          ? const AssetImage("assets/images/profileimage.png")
                                          : NetworkImage(
                                              Uri.encodeFull(controller.driverGetbyId!.driver.image),
                                            ) as ImageProvider,
                                ),
                              ),
                              const SizedBox(width: 12),
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
                        const SizedBox(height: 12),

                        // 🔹 Status
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Row(
                            children: [
                              Text(
                                "${CustomText.Status} : ",
                                style: AppTextStyles.medium(),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                height: 30,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        const SizedBox(height: 12),

                        // 🔹 Vehicle info
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
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
                                        style: AppTextStyles.medium(weight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}






