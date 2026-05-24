import 'package:customer/Controller/Deshboard/deshboard_cont.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Widgets/all_text.dart';
import '../../Widgets/text_button.dart';
import '../../profile/controller/profile_controller.dart';
import '../../textstyle/apptextstyle.dart';


class AddWork_Screen extends StatefulWidget {
  const AddWork_Screen({super.key});

  @override
  State<AddWork_Screen> createState() => _AddWork_ScreenState();
}

class _AddWork_ScreenState extends State<AddWork_Screen> {

  final mydeshcontroller = Get.isRegistered<DeshBoardAddHome_Controller>()
      ? Get.find<DeshBoardAddHome_Controller>()
      :  Get.put(DeshBoardAddHome_Controller());

  final profileC = Get.isRegistered<profileModelController>()
      ? Get.find<profileModelController>()
      :  Get.put(profileModelController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Spacer(),
                    const Text(
                      "Work Address",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),

                const SizedBox(height: 40),

                /// 🔍 SEARCH FIELD
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: mydeshcontroller.WorkAdressController,
                        hintText: "Search Home Address",
                        borderRadius: 15,
                        onChanged:  mydeshcontroller.addworkLocation,
                      ),
                    ),
                    Obx(() {
                      return IconButton(
                        icon: Icon(
                          mydeshcontroller.editingIndex.value != null
                              ? Icons.check
                              : Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: mydeshcontroller.AddworkApi,
                      );
                    }),
                  ],
                ),

                /// 🔍 LIVE SEARCH RESULTS
                Obx(() {
                  if (mydeshcontroller.workSearchloading.value) {
                    return const Padding(
                      padding: EdgeInsets.all(15),
                      child: LinearProgressIndicator(
                        minHeight: 3,
                        color: CustomColor.Icon_Color,
                        backgroundColor: Colors.white24,
                      ),
                    );
                  }

                  if (mydeshcontroller.workSearchList.isNotEmpty) {
                    return commonSearchContainer(
                      context: context,
                      list: mydeshcontroller.workSearchList,
                      onTap: (item) {
                        mydeshcontroller.WorkAdressController.text =
                        "${item.name} ${item.postcode}";


                        mydeshcontroller.selectWorkLocation(item);
                      },
                    );
                  }

                  return const SizedBox();
                }),

                /// 🏠 SAVED HOME CARD
                Obx(() {
                  if (mydeshcontroller.workSearchList.isNotEmpty || mydeshcontroller.workSearchloading.value) {
                    return const SizedBox();
                  }

                  return GetBuilder<profileModelController>(
                    builder: (controller) {
                     final address = controller.profileData?.customer?.address2;

                      if (address == null || address.isEmpty || address == " ") {
                        return Padding(
                          padding: const EdgeInsets.all(40),
                          child: Text(
                            "No data",
                            style: AppTextStyles.heading(),
                          ),
                        );
                      }

                      return Card(
                        margin: EdgeInsets.only(top: 50),
                        color: CustomColor.Container_Colors,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.home),
                          title: Text(address, style: AppTextStyles.small()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () async {
                                  Get.dialog(
                                    Center(
                                      child: CircularProgressIndicator(
                                        color: CustomColor.Icon_Color,
                                        backgroundColor: Colors.white24,
                                      ),
                                    ),
                                    barrierDismissible: false,
                                  );
                                  await Future.delayed(Duration(seconds: 1));
                                  Get.back();
                                  mydeshcontroller.editWorkAddress();
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  Get.dialog(
                                    Dialog(
                                      backgroundColor: Colors.transparent,
                                      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Container(
                                        height: 300,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: CustomColor.Container_Colors,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [

                                            /// TITLE
                                            Text(
                                              CustomText.Delete_address,
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.heading(),
                                            ),

                                            const SizedBox(height: 12),

                                            /// ICON
                                            Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.red.withOpacity(0.08),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.delete_forever_rounded,
                                                color: Colors.red,
                                                size: 34,
                                              ),
                                            ),

                                            const SizedBox(height: 12),

                                            /// DESCRIPTION
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Text(
                                                CustomText.Delete_home_address_Alert,
                                                textAlign: TextAlign.center,
                                                style: AppTextStyles.regular(),
                                              ),
                                            ),

                                            const SizedBox(height: 20),

                                            /// BUTTONS
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                                /// YES BUTTON
                                                CustomTextButton(
                                                  width: 70,
                                                  height: 42,
                                                  text: 'Yes',

                                                  textAlign: TextAlign.center,
                                                  rowMainAxisAlignment: MainAxisAlignment.center,
                                                  columnCrossAxisAlignment: CrossAxisAlignment.center,

                                                  onPressed: () async {
                                                    mydeshcontroller.deleteWorkapi();
                                                    Get.back();
                                                  },

                                                  backgroundColor: Colors.red,
                                                  textColor: CustomColor.textColor,
                                                  borderRadius: 10,
                                                  elevation: 2,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),

                                                const SizedBox(width: 15),

                                                /// NO BUTTON
                                                CustomTextButton(
                                                  width: 70,
                                                  height: 42,
                                                  text: ' No ',

                                                  textAlign: TextAlign.center,
                                                  rowMainAxisAlignment: MainAxisAlignment.center,
                                                  columnCrossAxisAlignment: CrossAxisAlignment.center,

                                                  onPressed: () {
                                                    Get.back();
                                                  },

                                                  backgroundColor: CustomColor.Button_background_Color,
                                                  textColor: CustomColor.textColor,
                                                  borderRadius: 10,
                                                  elevation: 2,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //======================================================   list widget
  Widget commonSearchContainer({
    required BuildContext context,
    required List list,
    required Function(dynamic) onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      height: MediaQuery.of(context).size.height * 0.8,
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
                ("${item.name ?? ""} ${item.postcode ?? ""}").toUpperCase(),
                  style: AppTextStyles.regular(),
                ),
                onTap: () => onTap(item),
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



