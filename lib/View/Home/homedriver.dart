import 'package:customer/Controller/Home/home-controller.dart';
import 'package:customer/View/Home/widget.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/textformfield.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/elevat_button.dart';
import '../profile/controller/profile_controller.dart';
import 'dialogbox.dart';

class HomeDriver extends StatelessWidget {
  HomeDriver({super.key});

  final homeC = Get.isRegistered<SwapController>()
      ? Get.find<SwapController>()
      : Get.put(SwapController());

  final profileController = Get.isRegistered<profileModelController>()
      ? Get.find<profileModelController>()
      : Get.put(profileModelController());

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        //backgroundColor: CustomColor.background,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 30, 1, 44),
                Color.fromARGB(255, 227, 194, 242),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: GetBuilder<SwapController>(
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () => Get.back(),
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: CustomColor.Icon_Color,
                                  size: 30,
                                ),
                              ),

                              const SizedBox(height: 20),

                              ///======================================================== ================= MAIN AREA with Equal Padding
                              ///
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        /// ---------- PICKUP ----------
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 25.0,
                                          ),
                                          child: CustomTextField(
                                            controller: homeC.pickUp,
                                            hintText: "Pick Up",
                                            borderRadius: 20,
                                            prefixIcon: Icon(
                                              Icons.circle,
                                              size: 15,
                                              color: CustomColor
                                                  .textField_Icon_Color,
                                            ),
                                            onChanged: (v) {
                                                homeC.pickupLocation(v);
                                                },
                                          ),
                                        ),
                                        const SizedBox(height: 12),

                                        /// ---------- VIA FIELDS ----------
                                        Obx(
                                          () => Column(
                                            children: [
                                              if (homeC.showVia1.value)
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomTextField(
                                                        controller: homeC.viaController1,
                                                        hintText: "1st Stop",
                                                        borderRadius: 20,
                                                        prefixIcon: Icon(
                                                          Icons.wb_sunny_outlined,
                                                          size: 20,
                                                          color: CustomColor.textField_Icon_Color,
                                                        ),
                                                        onChanged: (v) {
                                                          homeC.viaLocation1(v);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    GestureDetector(
                                                      onTap: () => homeC
                                                          .removeField(1),
                                                      child: const Icon(
                                                        Icons.clear,
                                                        color: CustomColor.Icon_Color,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (homeC.showVia1.value)
                                                const SizedBox(height: 12),

                                              if (homeC.showVia2.value)
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomTextField(
                                                        controller: homeC.viaController2,
                                                        hintText: "2nd Stop",
                                                        borderRadius: 20,
                                                        prefixIcon: Icon(
                                                          Icons.wb_sunny_outlined,
                                                          size: 20,
                                                          color: CustomColor.textField_Icon_Color,
                                                        ),
                                                        onChanged: (v) {
                                                          homeC.viaLocation2(v);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    GestureDetector(
                                                      onTap: () => homeC
                                                          .removeField(2),
                                                      child: const Icon(
                                                        Icons.clear,
                                                        color: CustomColor
                                                            .Icon_Color,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (homeC.showVia2.value)
                                                const SizedBox(height: 12),
                                            ],
                                          ),
                                        ),

                                        /// ---------- DROPOFF ----------
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 25.0,
                                          ),
                                          child: CustomTextField(
                                            controller: homeC.dropOff,
                                            hintText: "Destination",
                                            borderRadius: 20,
                                            prefixIcon: Icon(
                                              Icons.location_pin,
                                              size: 20,
                                              color: CustomColor
                                                  .textField_Icon_Color,
                                            ),
                                            onChanged: (v) {
                                                homeC.dropOffLocation(v);
                                            }
                                          ),
                                        ),
                                        const SizedBox(height: 20),


                                      ],
                                    ),

                                    /// ---------- SWAP BUTTON ----------
                                    Obx(
                                          () => homeC.canShowSwap
                                          ? Positioned(
                                        right: -5,
                                        top: 40,
                                        child: RotatedBox(
                                          quarterTurns: 1,
                                          child: GestureDetector(
                                            onTap: homeC.swapField,
                                            child: Icon(
                                              Icons.compare_arrows,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      )
                                          : SizedBox.shrink(),
                                    ),

                                  ],
                                ),
                              ),



                              /// ---------- +ADD(VIA) BUTTON ----------
                              Padding(
                                padding: const EdgeInsets.only(right: 45),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: controller.addField,
                                      child: Text(
                                        '+Add(Via)',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),

                          ///
                          Obx(() {
                            if (controller.searchloading.value
                                || controller.dropSearchLoading.value
                                || controller.viaSearchloading1.value
                                || controller.viaSearchloading2.value)
                            {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: LinearProgressIndicator(
                                  minHeight: 3,
                                  color: CustomColor.Icon_Color,
                                  backgroundColor: Colors.white24,
                                ),
                              );
                            }

                            if ((controller.pickUp.text.isEmpty)
                                && (controller.dropOff.text.isEmpty)
                                && (controller.viaController1.text.isEmpty)
                                && (controller.viaController2.text.isEmpty)) {
                              return containerWidget();
                            }

                            if (controller.searchList.isNotEmpty && controller.pickUp.text.isNotEmpty) {
                              return commonSearchContainer(
                                context: context,
                                list: controller.searchList,
                                onTap: (item) {
                                  homeC.pickUp.text = item.name ?? "";
                                  controller.searchList.clear();
                                },
                              );
                            }

                            if (controller.dropSearchList.isNotEmpty && controller.dropOff.text.isNotEmpty) {
                              return commonSearchContainer(
                                context: context,
                                list: controller.dropSearchList,
                                onTap: (item) {
                                  homeC.dropOff.text = item.name ?? "";
                                  controller.dropSearchList.clear();
                                },
                              );
                            }

                            if (controller.viaSearchList1.isNotEmpty && controller.viaController1.text.isNotEmpty) {
                              return commonSearchContainer(
                                context: context,
                                list: controller.viaSearchList1,
                                onTap: (item) {
                                  homeC.viaController1.text = item.name ?? "";
                                  controller.viaSearchList1.clear();
                                },
                              );
                            }

                            if (controller.viaSearchList2.isNotEmpty && controller.viaController2.text.isNotEmpty) {
                              return commonSearchContainer(
                                context: context,
                                list: controller.viaSearchList2,
                                onTap: (item) {
                                  homeC.viaController2.text = item.name ?? "";
                                  controller.viaSearchList2.clear();
                                },
                              );
                            }


                            // if (controller.searchList.isNotEmpty && controller.pickUp.text.isNotEmpty ) {
                            //   return Container(
                            //     margin: const EdgeInsets.symmetric(
                            //       horizontal: 20,
                            //     ),
                            //     height: (homeC.showVia1.value && homeC.showVia2.value)
                            //         ? MediaQuery.of(context).size.height * 0.3   // 2 VIA → smallest
                            //         : (homeC.showVia1.value)
                            //         ? MediaQuery.of(context).size.height * 0.38   // 1 VIA → medium
                            //         : MediaQuery.of(context).size.height * 0.45,  // 0 VIA → large
                            //
                            //
                            //     child: ListView.builder(
                            //       itemCount: controller.searchList.length,
                            //       itemBuilder: (context, index) {
                            //         final item = controller.searchList[index];
                            //         return ListTile(
                            //           leading: Icon(
                            //             Icons.location_on,
                            //             color: CustomColor.Icon_Color,
                            //           ),
                            //           title: Text(
                            //             "${item.name ?? ""} ${item.postcode ?? ""}",
                            //             style: AppTextStyles.regular(),
                            //           ),
                            //           //subtitle: Text(item.postcode ?? "", style: AppTextStyles.regular()),
                            //           onTap: () {
                            //             homeC.pickUp.text = item.name ?? "";
                            //             homeC.searchList.clear();
                            //           },
                            //         );
                            //       },
                            //     ),
                            //   );
                            // }
                            // if (controller.dropSearchList.isNotEmpty && controller.dropOff.text.isNotEmpty) {
                            //   return Container(
                            //     margin: const EdgeInsets.symmetric(
                            //       horizontal: 20,
                            //     ),
                            //     height: (homeC.showVia1.value && homeC.showVia2.value)
                            //         ? MediaQuery.of(context).size.height * 0.3
                            //         : (homeC.showVia1.value)
                            //         ? MediaQuery.of(context).size.height * 0.38
                            //         : MediaQuery.of(context).size.height * 0.45,
                            //
                            //     child: ListView.builder(
                            //       itemCount: controller.dropSearchList.length,
                            //       itemBuilder: (context, index) {
                            //         final item =
                            //             controller.dropSearchList[index];
                            //         return ListTile(
                            //           leading: Icon(
                            //             Icons.location_on,
                            //             color: CustomColor.Icon_Color,
                            //           ),
                            //           title: Text(
                            //             "${item.name ?? ""} ${item.postcode ?? ""}",
                            //             style: AppTextStyles.regular(),
                            //           ),
                            //           // subtitle: Text(item.postcode ?? "", style: AppTextStyles.small()),
                            //           onTap: () {
                            //             homeC.dropOff.text = item.name ?? "";
                            //             homeC.dropSearchList.clear();
                            //           },
                            //         );
                            //       },
                            //     ),
                            //   );
                            // }
                            // if (controller.viaSearchList1.isNotEmpty && controller.viaController1.text.isNotEmpty) {
                            //   return Container(
                            //     margin: const EdgeInsets.symmetric(
                            //       horizontal: 20,
                            //     ),
                            //     height: (homeC.showVia1.value && homeC.showVia2.value)
                            //         ? MediaQuery.of(context).size.height * 0.3   // 2 VIA → smallest
                            //         : (homeC.showVia1.value)
                            //         ? MediaQuery.of(context).size.height * 0.38   // 1 VIA → medium
                            //         : MediaQuery.of(context).size.height * 0.45,  // 0 VIA → large
                            //
                            //
                            //     child: ListView.builder(
                            //       itemCount: controller.viaSearchList1.length,
                            //       itemBuilder: (context, index) {
                            //         final item =
                            //         controller.viaSearchList1[index];
                            //         return ListTile(
                            //           leading: Icon(
                            //             Icons.location_on,
                            //             color: CustomColor.Icon_Color,
                            //           ),
                            //           title: Text(
                            //             "${item.name ?? ""} ${item.postcode ?? ""}",
                            //             style: AppTextStyles.regular(),
                            //           ),
                            //           // subtitle: Text(item.postcode ?? "", style: AppTextStyles.small()),
                            //           onTap: () {
                            //             homeC.viaController1.text = item.name ?? "";
                            //             homeC.viaSearchList1.clear();
                            //           },
                            //         );
                            //       },
                            //     ),
                            //   );
                            // }
                            // if (controller.viaSearchList2.isNotEmpty && controller.viaController2.text.isNotEmpty) {
                            //   return Container(
                            //     margin: const EdgeInsets.symmetric(
                            //       horizontal: 20,
                            //     ),
                            //     height: (homeC.showVia1.value && homeC.showVia2.value)
                            //         ? MediaQuery.of(context).size.height * 0.3
                            //         : (homeC.showVia1.value)
                            //         ? MediaQuery.of(context).size.height * 0.38
                            //         : MediaQuery.of(context).size.height * 0.45,
                            //
                            //
                            //     child: ListView.builder(
                            //       itemCount: controller.viaSearchList2.length,
                            //       itemBuilder: (context, index) {
                            //         final item =
                            //         controller.viaSearchList2[index];
                            //         return ListTile(
                            //           leading: Icon(
                            //             Icons.location_on,
                            //             color: CustomColor.Icon_Color,
                            //           ),
                            //           title: Text(
                            //             "${item.name ?? ""} ${item.postcode ?? ""}",
                            //             style: AppTextStyles.regular(),
                            //           ),
                            //           // subtitle: Text(item.postcode ?? "", style: AppTextStyles.small()),
                            //           onTap: () {
                            //             homeC.viaController2.text = item.name ?? "";
                            //             homeC.viaSearchList2.clear();
                            //           },
                            //         );
                            //       },
                            //     ),
                            //   );
                            // }


                            return containerWidget();
                          }),

                          SizedBox(height: 15),
                        ],
                      ),
                    ),

                    //Spacer(),
                    /// ==============================================================  BOTTOM BUTTONS+=> CONTINUE / SET LOCATION ON MAP
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 55,
                            width: 250,
                            child: MyElevatedButton(
                              text: '',
                              textWidget: FittedBox(
                                child: Text(
                                  "Continue",
                                  style: AppTextStyles.medium(
                                    size: 25,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.dialog(
                                  Dialog(
                                    backgroundColor: Color(0xFF231F20),
                                    child: Dialogbox(),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 10),

                          // SET LOCATION ON MAP
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 25,
                                  color: Colors.red,
                                  //CustomColor.Icon_Color,
                                ),
                                const SizedBox(width: 5),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed('/PickupScreen');
                                  },
                                  child: Text(
                                    "SET LOCATION ON MAP",
                                    style: AppTextStyles.medium(
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget commonSearchContainer({
    required BuildContext context,
    required List list,
    required Function(dynamic) onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: (homeC.showVia1.value && homeC.showVia2.value)
          ? MediaQuery.of(context).size.height * 0.3
          : (homeC.showVia1.value)
          ? MediaQuery.of(context).size.height * 0.38
          : MediaQuery.of(context).size.height * 0.45,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return ListTile(
            leading: const Icon(Icons.location_on, color: CustomColor.Icon_Color),
            title: Text(
              "${item.name ?? ""} ${item.postcode ?? ""}",
              style: AppTextStyles.regular(),
            ),
            onTap: () => onTap(item),
          );
        },
      ),
    );
  }

}
