///===================================================== === >>   (Address/ Airport / station) container and list hai ini teeno ki

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/Home/home-controller.dart';
import '../../Widgets/color.dart';
import '../../Widgets/elevat_button.dart';
import '../../Widgets/text_button.dart';
import '../../Widgets/textformfield.dart';
import '../../profile/controller/profile_controller.dart';
import '../../textstyle/apptextstyle.dart';
import '../AddHome/add_home.dart';
import '../AddWork/add_work.dart';


class containerWidget extends StatefulWidget {
  const containerWidget({super.key});

  @override
  State<containerWidget> createState() => _containerWidgetState();
}

class _containerWidgetState extends State<containerWidget> {
  final homeC = Get.isRegistered<SwapController>()
      ? Get.find<SwapController>()
      : Get.put(SwapController());

  final profileController = Get.isRegistered<profileModelController>()
      ? Get.find<profileModelController>()
      : Get.put(profileModelController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SwapController>(
      builder: (controller) {
        return Container(
          // color: Colors.black,
          child: Column(
            children: [
              // ================================================ Address / Airoplane / Train  Coloum
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 100,
                width: MediaQuery.of(context).size.width * 0.93,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  // color: const Color.fromARGB(255, 54, 54, 54),
                  color: CustomColor.Button_background_Color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ==========================================================       Address
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          homeC.selectedItem(0);
                          homeC.changeIndex(0);
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: homeC.selectedItem.value == 0
                                ? Colors.white
                                : Colors.white10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 25,
                                color: homeC.selectedItem.value == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Address",
                                style: AppTextStyles.small(
                                  weight: FontWeight.bold,
                                  size: 11,
                                  color: homeC.selectedItem.value == 0
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // =================== Airport ===================
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          homeC.selectedItem(1);
                          homeC.changeIndex(1);
                        },
                        child: Container(
                          height: 70,
                          width: 70,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: homeC.selectedItem.value == 1
                                ? Colors.white
                                : Colors.white10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.airplanemode_active,
                                size: 25,
                                color: homeC.selectedItem.value == 1
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Airport",
                                style: AppTextStyles.small(
                                  weight: FontWeight.bold,
                                  color: homeC.selectedItem.value == 1
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // =================== Train ===================
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          homeC.selectedItem(2);
                          homeC.changeIndex(2);
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: homeC.selectedItem.value == 2
                                ? Colors.white
                                : Colors.white10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.train_outlined,
                                size: 25,
                                color: homeC.selectedItem.value == 2
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Train",
                                style: AppTextStyles.small(
                                  weight: FontWeight.bold,

                                  color: homeC.selectedItem.value == 2
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              //===========================-========================  list show addresses
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.selectedIndex.value == 0
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,

                            //color: Colors.grey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Get.to(AddHomeScreen());
                                    },
                                    title: Text(
                                      "Home",
                                      style: AppTextStyles.regular(),
                                    ),
                                    // subtitle: Text(
                                    //   profileController
                                    //           .profileData
                                    //           ?.addhomeAddress ??
                                    //       'Address',
                                    //   style: AppTextStyles.small(),
                                    // ),

                                    leading: Icon(
                                      controller.iconItems[controller.selectedIndex.value]["icon"],
                                      color: CustomColor.textColor,
                                      size: 25,
                                    ),
                                  ),

                                  ListTile(
                                    onTap: () {
                                      Get.to(AddWork_Screen());
                                    },
                                    title: Text(
                                      "Add Work",
                                      style: AppTextStyles.regular(),
                                    ),
                                    // subtitle: Text(
                                    //   profileController.profileData?.addworkAddress ?? 'Address',
                                    //   style: AppTextStyles.small(),
                                    // ),
                                    leading: Icon(
                                      controller.iconItems[controller
                                          .selectedIndex
                                          .value]["icon"],
                                      color: CustomColor.textColor,
                                      size: 25,
                                    ),
                                  ),

                                  ListTile(
                                    onTap: () {
                                      print("Baby note ");
                                      showBabyNoteDialog();
                                    },
                                    title: Text(
                                      "Baby Note",
                                      style: AppTextStyles.regular(),
                                    ),
                                    leading: Icon(
                                      Icons.note_alt_outlined,
                                      color: CustomColor.Icon_Color,
                                      size: 25,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            // height: (homeC.showVia1.value && homeC.showVia2.value)
                            //     ? MediaQuery.of(context).size.height * 0.2
                            //     : (homeC.showVia1.value)
                            //     ? MediaQuery.of(context).size.height * 0.25
                            //     : MediaQuery.of(context).size.height * 0.3,
                            height:
                                (homeC.showVia1.value && homeC.showVia2.value)
                                ? MediaQuery.of(context).size.height * 0.18 // 2 VIA → smallest
                                : (homeC.showVia1.value)
                                ? MediaQuery.of(context).size.height *0.25 // 1 VIA → medium
                                : MediaQuery.of(context).size.height *0.35, // 0 VIA → large

                            child: Obx(
                              () => homeC.airportLoading.value
                               ? Column(
                                children: [
                                  /// 🔹 TOP SLIM LOADER
                                  SizedBox(
                                    height: 3,
                                    width: double.infinity,
                                    child: LinearProgressIndicator(
                                      minHeight: 3,
                                      color: CustomColor.Icon_Color,
                                      backgroundColor: Colors.white24,
                                    ),
                                  ),

                                  /// 🔹 Remaining empty space (so height stays same)
                                  const Expanded(child: SizedBox()),
                                ],
                              )
        //     SizedBox(
                              //   height: 2,
                              //   width: double.infinity,
                              //   child: LinearProgressIndicator(
                              //     minHeight: 3,
                              //     color: CustomColor.Icon_Color,
                              //     backgroundColor: Colors.white24,
                              //   ),
                              // )
                                  : ListView.builder(
                                      itemCount: homeC.busStops.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                            homeC.busStops[index],
                                            style: AppTextStyles.medium(),
                                          ),

                                          leading: Icon(
                                            controller.iconItems[controller.selectedIndex.value]["icon"],
                                            color: CustomColor.textColor,
                                            size: 25,
                                          ),
                                          onTap: () {
                                            homeC.selectLocationFromList(index);
                                            //homeC.selectDrop(index);
                                            // Get.back();
                                          },
                                        );
                                      },
                                    ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  void showBabyNoteDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: CustomColor.Container_Colors,
        title: Text(
          "Baby Note",
          textAlign: TextAlign.center,
          style: AppTextStyles.medium(
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
        content:
        CustomTextField(
          controller: homeC.babyNoteController,
          hintText: "Enter baby note...",
          borderRadius: 15,
          // fillColor: CustomColor.textfield_fill,
          maxlength: 30,
          maxLines: 3,
          contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        ),
        // TextField(
        // //  controller: babyNoteController,
        //   maxLines: 3,
        //   style: const TextStyle(color: Colors.white),
        //   decoration: InputDecoration(
        //     hintText: "Enter baby note...",
        //     hintStyle: TextStyle(color: Colors.white54),
        //     filled: true,
        //     fillColor: Colors.white10,
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(8),
        //       borderSide: BorderSide.none,
        //     ),
        //   ),
        // ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextButton(
                text: 'Cancel',
                onPressed: () {
                  homeC.babyNoteController.clear();
                  Get.back();

                },
                backgroundColor: Colors.red,
                textColor: Colors.white,
                borderRadius: 8,
                elevation: 2,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),

              SizedBox(width: 12),

              CustomTextButton(
                text: '  Save  ',
                onPressed: () {
                  homeC.babynoteText();
                },
                backgroundColor: CustomColor.Button_background_Color,
                textColor: Colors.white,
                borderRadius: 8,
                elevation: 2,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ],
          ),
        ],

      ),
      barrierDismissible: false,
    );
  }

}
