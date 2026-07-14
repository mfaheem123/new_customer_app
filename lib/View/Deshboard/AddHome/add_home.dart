import 'package:customer/Controller/Deshboard/deshboard_cont.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/textformfield.dart';
import 'package:customer/View/profile/controller/profile_controller.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Widgets/all_text.dart';
import '../../Widgets/text_button.dart';

class AddHomeScreen extends StatefulWidget {
  const AddHomeScreen({super.key});

  @override
  State<AddHomeScreen> createState() => _AddHomeScreenState();
}

class _AddHomeScreenState extends State<AddHomeScreen> {

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
          child:  Column(
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: CustomColor.Icon_Color,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Home Address",
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
                      controller: mydeshcontroller.HomeController,
                      textCapitalization: TextCapitalization.characters,
                      hintText: "Search Home Address",
                      borderRadius: 15,
                      onChanged: mydeshcontroller.addhomeLocation,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          mydeshcontroller.HomeController.clear();
                          mydeshcontroller.addhomeLocation("");
                        },
                      ),
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
                      onPressed: mydeshcontroller.AddhomeApi,
                    );
                  }),
                ],
              ),

              /// 🔍 LIVE SEARCH RESULTS
              Obx(() {
                if (mydeshcontroller.homeSearchloading.value) {
                  return const Padding(
                    padding: EdgeInsets.all(15),
                    child: LinearProgressIndicator(
                      minHeight: 3,
                      color: CustomColor.Icon_Color,
                      backgroundColor: Colors.white24,
                    ),
                  );
                }

                if (mydeshcontroller.homeSearchList.isNotEmpty) {

                  return  commonSearchContainer(
                    context: context,
                    list: mydeshcontroller.homeSearchList,
                    onTap: (item) {
                      mydeshcontroller.HomeController.text = "${item.name} ${item.postcode}";
                      mydeshcontroller.selectHomeLocation(item);

                    },
                  );
                }

                return const SizedBox();
              }),

              /// 🏠 SAVED HOME CARD
              Obx(() {
                if (mydeshcontroller.homeSearchList.isNotEmpty || mydeshcontroller.homeSearchloading.value) {
                  return const SizedBox();
                }

                return GetBuilder<profileModelController>(
                  builder: (controller) {
                    final address = controller.profileData?.customer?.address1;

                    if (address == null ||address.isEmpty || address == " ") {
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
                                Navigator.of(context).pop();
                                mydeshcontroller.editItem();
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
                                                  mydeshcontroller.deleteHomeApi();
                                                  Navigator.of(context).pop();
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
                                                  Navigator.of(context).pop();
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
    );
  }

  //======================================================   list

  Widget commonSearchContainer({
    required BuildContext context,
    required List list,
    required Function(dynamic) onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      height: MediaQuery.sizeOf(context).height * 0.7,
      // ❌ REMOVE FIXED HEIGHT
      child: ListView.builder(

        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];

          return ListTile(
            leading: const Icon(
              Icons.location_on,
              color: CustomColor.Icon_Color,
            ),
            title: Text(
             ( "${item.name ?? ""} ${item.postcode ?? ""}").toUpperCase(),
              style: AppTextStyles.regular(),
            ),
            onTap: () => onTap(item),
          );
        },
      ),
    );
  }
  // Widget commonSearchContainer({
  //   required BuildContext context,
  //   required List list,
  //   required Function(dynamic) onTap,
  // }) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
  //     height: MediaQuery.of(context).size.height * 0.8,
  //     child: ListView.builder(
  //       itemCount: list.length,
  //       itemBuilder: (context, index) {
  //         final item = list[index];
  //         return ListTile(
  //           leading: const Icon(
  //             Icons.location_on,
  //             color: CustomColor.Icon_Color,
  //           ),
  //           title: Text(
  //             "${item.name ?? ""} ${item.postcode ?? ""}",
  //             style: AppTextStyles.regular(),
  //           ),
  //           onTap: () => onTap(item),
  //         );
  //       },
  //     ),
  //   );
  // }


}


