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
  //final mydeshcontroller = Get.put(DeshBoardAddHome_Controller());
  final mydeshcontroller = Get.isRegistered<DeshBoardAddHome_Controller>()
      ? Get.find<DeshBoardAddHome_Controller>()
      :  Get.put(DeshBoardAddHome_Controller());
  // final profileC = Get.put(profileModelController());
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
                        mydeshcontroller.workSearchList.clear();
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
                      final address = controller.profileData?.addworkAddress;

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
                                      backgroundColor: CustomColor.Container_Colors,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        height: 220,
                                        width: 100,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 15),

                                            Text(
                                              CustomText.Delete_address,
                                              style: AppTextStyles.heading(

                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Icon(
                                              Icons.warning_amber,
                                              color: Colors.amberAccent,
                                              size: 40,
                                            ),
                                            SizedBox(height: 5),
                                            Center(
                                              child:  Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  CustomText.Delete_home_address_Alert,
                                                  textAlign: TextAlign.center,

                                                  style: AppTextStyles.small(),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15,),

                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                CustomTextButton(
                                                  text: 'Yes',
                                                  onPressed: () async {
                                                    mydeshcontroller.deleteWorkapi();
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
                                                SizedBox(width: 20),

                                                CustomTextButton(
                                                  text: '  No  ',
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  backgroundColor: CustomColor.Button_background_Color,
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
          return ListTile(
            leading: const Icon(
              Icons.location_on,
              color: CustomColor.Icon_Color,
            ),
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

// class AddWork_Screen extends StatefulWidget {
//   const AddWork_Screen({super.key});
//
//   @override
//   State<AddWork_Screen> createState() => _AddWork_ScreenState();
// }
//
// class _AddWork_ScreenState extends State<AddWork_Screen> {
//
//   final mydeshcontroller = Get.isRegistered<DeshBoardAddHome_Controller>()
//       ? Get.find<DeshBoardAddHome_Controller>()
//       : Get.put(DeshBoardAddHome_Controller());
//
//   final profileC = Get.isRegistered<profileModelController>()
//       ? Get.find<profileModelController>()
//       : Get.put(profileModelController());
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color.fromARGB(255, 30, 1, 44), Color.fromARGB(255, 227, 194, 242)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//
//                 const SizedBox(height: 30),
//                 Row(
//                   children: [
//                     IconButton(onPressed: Get.back,
//                         icon: const Icon(Icons.arrow_back, color: Colors.white)),
//                     const Spacer(),
//                     Text("Work Address",
//                         style:AppTextStyles.heading()),
//                     const Spacer(),
//                   ],
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 /// 🔍 WORK SEARCH FIELD
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomTextField(
//                         controller: mydeshcontroller.WorkAdressController,
//                         hintText: "Search Work Address",
//                         borderRadius: 15,
//                         onChanged: mydeshcontroller.addworkLocation,
//                       ),
//                     ),
//                     Obx(() => IconButton(
//                       icon: Icon(
//                           mydeshcontroller.editingIndex.value != null
//                           ? Icons.check
//                           : Icons.add, color: Colors.white),
//                       onPressed:(){
//                         mydeshcontroller.AddworkApi();
//                       } ,
//                     )),
//                   ],
//                 ),
//
//                 /// 🔍 LIVE SEARCH LIST
//                 Obx(() {
//                   if (mydeshcontroller.workSearchloading.value) {
//                     return const Padding(
//                       padding: EdgeInsets.all(15),
//                       child: LinearProgressIndicator(
//                         minHeight: 3,
//                         color: CustomColor.Icon_Color,
//                         backgroundColor: Colors.white24,
//                       ),
//                     );
//                   }
//
//                   if (mydeshcontroller.workSearchList.isNotEmpty) {
//                     return commonSearchContainer(
//                       context: context,
//                       list: mydeshcontroller.workSearchList,
//                       onTap: (item) {
//                         mydeshcontroller.WorkAdressController.text =
//                         "${item.name} ${item.postcode}";
//                         mydeshcontroller.workSearchList.clear();
//                       },
//                     );
//                   }
//                   return const SizedBox();
//                 }),
//
//                 /// 🏢 SAVED WORK CARD
//                 Obx(() {
//                   if (mydeshcontroller.workSearchList.isNotEmpty || mydeshcontroller.workSearchloading.value) {
//                     return const SizedBox();
//                   }
//
//                   return GetBuilder<profileModelController>(
//                       builder: (controller) {
//                     final address = controller.profileData?.addworkAddress;
//                     if (address == null ||
//                         address.isEmpty ||
//                         address == " ") {
//                       return Padding(
//                         padding: const EdgeInsets.all(40),
//                         child: Text(
//                           "No data",
//                           style: AppTextStyles.heading(),
//                         ),
//                       );
//                     }
//
//                     return Card(
//                       margin: const EdgeInsets.only(top: 50),
//                       color: CustomColor.Container_Colors,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                       child: ListTile(
//                         leading: const Icon(Icons.work),
//                         title: Text(address, style: AppTextStyles.small()),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.edit, color: Colors.blue),
//                               onPressed: () async {
//                                 Get.dialog(
//                                   Center(
//                                     child: CircularProgressIndicator(
//                                       color: CustomColor.Icon_Color,
//                                       backgroundColor: Colors.white24,
//                                     ),
//                                   ),
//                                   barrierDismissible: false,
//                                 );
//                                 await Future.delayed(Duration(seconds: 1));
//                                 Get.back();
//                                 mydeshcontroller.editWorkAddress();
//                               },
//                             ),
//
//                             IconButton(icon: const Icon(Icons.delete, color: Colors.red),
//                                 onPressed: () {
//                                   Get.dialog(
//                                     Dialog(
//                                       backgroundColor: CustomColor.Container_Colors,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(Radius.circular(30)),
//                                         ),
//                                         height: 220,
//                                         width: 100,
//                                         child: Column(
//                                           children: [
//                                             SizedBox(height: 15),
//
//                                             Text(
//                                               CustomText.Delete_address,
//                                               style: AppTextStyles.heading(
//
//                                               ),
//                                             ),
//                                             SizedBox(height: 5),
//                                             Icon(
//                                               Icons.warning_amber,
//                                               color: Colors.amberAccent,
//                                               size: 40,
//                                             ),
//                                             SizedBox(height: 5),
//                                             Center(
//                                               child:  Padding(
//                                                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                                                 child: Text(
//                                                   CustomText.Delete_home_address_Alert,
//                                                   textAlign: TextAlign.center,
//
//                                                   style: AppTextStyles.small(),
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(height: 15,),
//
//                                             Row(
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               children: [
//                                                 CustomTextButton(
//                                                   text: 'Yes',
//                                                   onPressed: () async {
//                                                     mydeshcontroller.deleteWorkapi();
//                                                     Get.back();
//
//
//
//                                                   },
//                                                   backgroundColor: Colors.red,
//                                                   textColor: Colors.white,
//                                                   borderRadius: 8,
//                                                   elevation: 2,
//                                                   fontSize: 10,
//                                                   fontWeight: FontWeight.bold,
//                                                   padding: EdgeInsets.symmetric(
//                                                     horizontal: 16,
//                                                     vertical: 10,
//                                                   ),
//                                                 ),
//                                                 SizedBox(width: 20),
//
//                                                 CustomTextButton(
//                                                   text: '  No  ',
//                                                   onPressed: () {
//                                                     Get.back();
//                                                   },
//                                                   backgroundColor: CustomColor.Button_background_Color,
//                                                   textColor: Colors.white,
//                                                   borderRadius: 8,
//                                                   elevation: 2,
//                                                   fontSize: 10,
//                                                   fontWeight: FontWeight.bold,
//                                                   padding: EdgeInsets.symmetric(
//                                                     horizontal: 16,
//                                                     vertical: 10,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   });
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//   //======================================================   list widget
//   Widget commonSearchContainer({
//     required BuildContext context,
//     required List list,
//     required Function(dynamic) onTap,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//       height: MediaQuery.of(context).size.height * 0.8,
//       child: ListView.builder(
//         itemCount: list.length,
//         itemBuilder: (context, index) {
//           final item = list[index];
//           return ListTile(
//             leading: const Icon(
//               Icons.location_on,
//               color: CustomColor.Icon_Color,
//             ),
//             title: Text(
//               "${item.name ?? ""} ${item.postcode ?? ""}",
//               style: AppTextStyles.regular(),
//             ),
//             onTap: () => onTap(item),
//           );
//         },
//       ),
//     );
//   }
// }

