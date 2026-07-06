 import 'package:customer/Controller/Home/home-controller.dart';
import 'package:customer/View/Deshboard/Home/widget.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/textformfield.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Widgets/elevat_button.dart';
import '../../profile/controller/profile_controller.dart';

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
        body: Container(
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
          child: GetBuilder<SwapController>(
            id: "map",
            builder: (controller) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back, color: CustomColor.Icon_Color),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () => Get.back(),
                          //   icon: Icon(
                          //     Icons.arrow_back,
                          //     color: CustomColor.Icon_Color,
                          //     size: 25,
                          //   ),
                          // ),
                          const SizedBox(height: 10),

                          /// MAIN AREA WITH SWAP BUTTON
                          Stack(
                            children: [
                              Column(
                                children: [
                                  /// PICKUP
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: CustomTextField(
                                      focusNode: homeC.pickupFocus,
                                      controller: homeC.pickUp,
                                      textCapitalization: TextCapitalization.characters,
                                      hintText: "Pick Up",
                                      borderRadius: 20,
                                      prefixIcon: Icon(
                                        Icons.circle,
                                        size: 15,
                                        color: CustomColor.textField_Icon_Color,
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          homeC.removePickUpField();
                                        },
                                        child:  Icon(
                                          Icons.close,
                                          size: 18,
                                          color: CustomColor.textField_Icon_Color,
                                        ),
                                      ),
                                      onChanged: (v) {
                                        homeC.isPickupEmpty.value = v.isEmpty;
                                        homeC.pickupLocation(v);
                                      },
                                      onTap: () {

                                        homeC.activeField.value = "pickup";

                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  /// VIA FIELDS
                                  Obx(
                                    () => Column(
                                      children: [
                                        if (homeC.showVia1.value)
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CustomTextField(
                                                  focusNode: homeC.via1Focus,
                                                  textCapitalization: TextCapitalization.characters,
                                                  controller:
                                                      homeC.viaController1,

                                                  hintText: "1st Stop",
                                                  borderRadius: 20,
                                                  prefixIcon: Icon(
                                                    Icons.wb_sunny_outlined,
                                                    size: 20,
                                                    color: CustomColor
                                                        .textField_Icon_Color,
                                                  ),
                                                  suffixIcon: InkWell(
                                                    onTap: () {
                                                      homeC.viaController1
                                                          .clear();
                                                    },
                                                    child:  Icon(
                                                      Icons.close,
                                                      size: 18,
                                                      color: CustomColor.textField_Icon_Color,
                                                    ),
                                                  ),
                                                  onChanged: (v) {
                                                    homeC.viaLocation1(v);
                                                  },
                                                  onTap: () {
                                                    homeC.activeField.value =
                                                        "via1";
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              GestureDetector(
                                                onTap: () {
                                                  homeC.removeVia1();
                                                },
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
                                                  focusNode: homeC.via2Focus,
                                                  textCapitalization: TextCapitalization.characters,
                                                  controller:
                                                      homeC.viaController2,
                                                  hintText: "2nd Stop",
                                                  borderRadius: 20,
                                                  prefixIcon: Icon(
                                                    Icons.wb_sunny_outlined,
                                                    size: 20,
                                                    color: CustomColor
                                                        .textField_Icon_Color,
                                                  ),
                                                  suffixIcon: InkWell(
                                                    onTap: () {
                                                      homeC.viaController2
                                                          .clear();
                                                    },
                                                    child:   Icon(
                                                      Icons.close,
                                                      size: 18,
                                                      color: CustomColor.textField_Icon_Color,
                                                    ),
                                                  ),
                                                  onChanged: (v) {
                                                    homeC.viaLocation2(v);
                                                  },
                                                  onTap: () {
                                                    homeC.activeField.value =
                                                        "via2";
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              GestureDetector(
                                                onTap: () => homeC.removeVia2(),
                                                child: const Icon(
                                                  Icons.clear,
                                                  color: CustomColor.Icon_Color,
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

                                  /// DROPOFF
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: CustomTextField(
                                      focusNode: homeC.dropFocus,
                                      controller: homeC.dropOff,
                                      textCapitalization: TextCapitalization.characters,
                                      hintText: "Destination",
                                      borderRadius: 20,
                                      prefixIcon: Icon(
                                        Icons.location_pin,
                                        size: 20,
                                        color: CustomColor.textField_Icon_Color,
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          homeC.removeDropOff();
                                        },
                                        child:  Icon(
                                          Icons.close,
                                          size: 18,
                                          color: CustomColor.textField_Icon_Color,
                                        ),
                                      ),
                                      onChanged: (v) {
                                        homeC.dropOffLocation(v);
                                      },
                                      onTap: () {
                                        homeC.activeField.value = "drop";
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),

                              /// SWAP BUTTON
                              Obx(
                                () => homeC.canShowSwap
                                    ? Positioned(
                                        right: -5,
                                        top: 40,
                                        child: RotatedBox(
                                          quarterTurns: 1,
                                          child: GestureDetector(
                                            onTap: homeC.swapField,
                                            child: const Icon(
                                              Icons.compare_arrows,
                                              color: Colors.white,
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),

                          /// +ADD(VIA) BUTTON
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: controller.addField,
                                  child: const Text(
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
                          const SizedBox(height: 10),

                          /// SEARCH RESULTS / LOADING
                          Obx(() {
                            if (controller.searchloading.value ||
                                controller.dropSearchLoading.value ||
                                controller.viaSearchloading1.value ||
                                controller.viaSearchloading2.value) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: LinearProgressIndicator(
                                  minHeight: 3,
                                  color: CustomColor.Icon_Color,
                                  backgroundColor: Colors.white24,
                                ),
                              );
                            }

                            if ((controller.pickUp.text.isEmpty) &&
                                (controller.dropOff.text.isEmpty) &&
                                (controller.viaController1.text.isEmpty) &&
                                (controller.viaController2.text.isEmpty)) {
                              return containerWidget();
                            }

                            if (controller.searchList.isNotEmpty &&
                                controller.pickUp.text.isNotEmpty) {
                              return commonSearchContainer(
                                context: context,
                                list: controller.searchList,
                                onTap: (item) {
                                  homeC.pickUp.text =
                                      "${item.name ?? ""} ${item.postcode ?? ""}".toUpperCase();

                                  homeC.setPickup(item.lat ?? 0.0, item.lon ?? 0.0);
                                  controller.searchList.clear();

                                  Future.delayed(const Duration(milliseconds: 100), () {
                                    if (homeC.showVia1.value) {
                                      homeC.via1Focus.requestFocus();
                                    } else {
                                      homeC.dropFocus.requestFocus();
                                    }
                                  });
                                },
                                // onTap: (item) {
                                //   homeC.pickUp.text ="${item.name ?? ""} ${item.postcode ?? ""}".toUpperCase();
                                //
                                //   homeC.setPickup(
                                //     item.lat ?? 0.0,
                                //     item.lon ?? 0.0,
                                //   );
                                //   controller.searchList.clear();
                                //
                                //
                                // },
                              );
                            }

                            if (controller.dropSearchList.isNotEmpty &&
                                controller.dropOff.text.isNotEmpty) {
                              return commonSearchContainer(
                                context: context,
                                list: controller.dropSearchList,
                                onTap: (item) {
                                  homeC.dropOff.text =
                                      "${item.name ?? ""} ${item.postcode ?? ""}".toUpperCase();

                                  homeC.setDrop(item.lat ?? 0.0, item.lon ?? 0.0);
                                  controller.dropSearchList.clear();

                                  FocusScope.of(context).unfocus();
                                },
                                // onTap: (item) {
                                //   homeC.dropOff.text = "${item.name ?? ""} ${item.postcode ?? ""}".toUpperCase();
                                //   homeC.setDrop(
                                //     item.lat ?? 0.0,
                                //     item.lon ?? 0.0,
                                //   );
                                //   controller.dropSearchList.clear();
                                //
                                //
                                // },
                              );
                            }

                            if (controller.viaSearchList1.isNotEmpty &&
                                controller.viaController1.text.isNotEmpty) {
                              return commonSearchContainer(
                                context: context,
                                list: controller.viaSearchList1,
                                onTap: (item) {
                                  homeC.viaController1.text =
                                      "${item.name ?? ""} ${item.postcode ?? ""}".toUpperCase();

                                  homeC.setVia1(item.lat ?? 0.0, item.lon ?? 0.0);
                                  controller.viaSearchList1.clear();

                                  Future.delayed(const Duration(milliseconds: 100), () {
                                    if (homeC.showVia2.value) {
                                      homeC.via2Focus.requestFocus();
                                    } else {
                                      homeC.dropFocus.requestFocus();
                                    }
                                  });
                                },
                                // onTap: (item) {
                                //   homeC.viaController1.text = "${item.name ?? ""} ${item.postcode ?? ""}".toUpperCase();
                                //   homeC.setVia1(
                                //     item.lat ?? 0.0,
                                //     item.lon ?? 0.0,
                                //   );
                                //   controller.viaSearchList1.clear();
                                // },
                              );
                            }

                            if (controller.viaSearchList2.isNotEmpty &&
                                controller.viaController2.text.isNotEmpty) {
                              return commonSearchContainer(
                                context: context,
                                list: controller.viaSearchList2,
                                onTap: (item) {
                                  homeC.viaController2.text =
                                      "${item.name ?? ""} ${item.postcode ?? ""}".toUpperCase();

                                  homeC.setVia2(item.lat ?? 0.0, item.lon ?? 0.0);
                                  controller.viaSearchList2.clear();

                                  Future.delayed(const Duration(milliseconds: 100), () {
                                    homeC.dropFocus.requestFocus();
                                  });
                                },
                                // onTap: (item) {
                                //   homeC.setVia2(
                                //     item.lat ?? 0.0,
                                //     item.lon ?? 0.0,
                                //
                                //   );
                                //   homeC.viaController2.text ="${item.name ?? ""} ${item.postcode ?? ""}".toUpperCase();
                                //
                                //   controller.viaSearchList2.clear();
                                // },
                              );
                            }

                            return containerWidget();
                          }),
                        ],
                      ),
                    ),
                  ),

                  /// BOTTOM BUTTONS
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 10),
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
                              // Get.toNamed('/RideInfoScreen');
                              homeC.validateLocations();
                              //Get.to(MapScreen());
                              // Get.dialog(
                              //   const Dialog(
                              //     backgroundColor: Color(0xFF231F20),
                              //     child: Dialogbox(),
                              //   ),
                              // );
                            },
                          ),
                        ),
                        const SizedBox(height: 5),

                        /// SET LOCATION ON MAP
                        Obx(() {
                          return Visibility(
                            visible: homeC.isPickupEmpty.value,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed('/PickupScreen');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.location_on, size: 25, color: Colors.red),
                                      SizedBox(width: 5),
                                      Text("SET LOCATION ON MAP" ,style: AppTextStyles.medium(weight: FontWeight.bold
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })

                        ///

                      ],
                    ),
                  ),
                ],
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
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.45,
        minHeight: 100,
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.location_on,
                  color: CustomColor.Icon_Color,
                ),
                title: Text(
                ("${item.name ?? ""}  ${item.postcode ?? ""}").toUpperCase(),
                  style: AppTextStyles.regular(),
                ),
                onTap: () => onTap(item), // 🔥 callback
              ),

              // 🔥 Line under every address
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


