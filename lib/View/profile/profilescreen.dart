import 'dart:io';
import 'package:customer/View/Deshboard/AddHome/add_home.dart';
import 'package:customer/View/Deshboard/AddWork/add_work.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/text_button.dart';
import 'package:customer/View/profile/changepassword.dart';
import 'package:customer/View/profile/changephone_number.dart';
import 'package:customer/api_servies/session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/all_text.dart';
import '../textstyle/apptextstyle.dart';
import 'controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  //final profileController = Get.put(profileModelController());
    final profileController = Get.isRegistered<profileModelController>()
        ? Get.find<profileModelController>()
        :  Get.put(profileModelController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<profileModelController>(
      builder: (controller) {
        if (controller.loading.value) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
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
              child: const Center(
                  child: CircularProgressIndicator()),
            ),
          );
        }
        final user = controller.profileData;
        if (user == null) {
          return Scaffold(
            body: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
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
                child: Center(child: Text("Server Not Responding",style: AppTextStyles.heading(),))),
          );
        }

        return SafeArea(
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
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
                    // Header
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(
                              Icons.arrow_back,
                              size: MediaQuery.of(context).size.width * 0.06,
                              color: CustomColor.Icon_Color,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Center(
                              child: Text(
                                CustomText.User_Profile,
                                style: AppTextStyles.heading(
                                  size: MediaQuery.of(context).size.width * 0.06,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Profile Picture with Obx ONLY for selectedImage
                Stack(
                  children: [
                    Center(
                      child: Obx(() {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: controller.selectedImage.value != null
                              ? FileImage(controller.selectedImage.value!)
                              : (user.profilePicture != null && user.profilePicture!.isNotEmpty
                              ? NetworkImage(user.profilePicture!)
                              : const AssetImage("assets/images/profileimage.png") as ImageProvider),
                        );
                      }),
                    ),
                    Positioned(
                      right: 150,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          controller.changeProfilePicture(TokenManager.userId);
                        },
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 30,
                          color: CustomColor.Icon_Color,
                        ),
                      ),
                    ),
                  ],
                ),


                // Stack(
                    //   children: [
                    //     Center(
                    //       child: Obx(() {
                    //         return CircleAvatar(
                    //           radius: 50,
                    //           backgroundImage: controller.selectedImage.value != null
                    //               ? FileImage(controller.selectedImage.value!)
                    //               : (user.profilePicture != null && user.profilePicture!.isNotEmpty
                    //               ? NetworkImage(user.profilePicture!) as ImageProvider
                    //               : const AssetImage("assets/images/profileimage.png")),
                    //         );
                    //       }),
                    //     ),
                    //     Positioned(
                    //       left: 230,
                    //       top: 70,
                    //       child: GestureDetector(
                    //         child: Icon(
                    //           Icons.photo_camera_rounded,
                    //           size: 30,
                    //           color: CustomColor.Icon_Color,
                    //         ),
                    //         onTap: () {
                    //          // controller.changeProfilePicture(user.id!);
                    //           if (controller.profileImg == null) {
                    //             controller.pickImage();
                    //           }
                    //         }
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    const SizedBox(height: 10),

                    // User Info
                    ListTile(
                      leading: const Icon(Icons.person, size: 25, color: Colors.white),
                      title: Text(CustomText.Name, style: AppTextStyles.medium()),
                      subtitle: Text("${user.firstName} ${user.lastName}", style: AppTextStyles.medium()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone, size: 25, color: Colors.white),
                      title: Text(CustomText.Mobile, style: AppTextStyles.medium()),
                      subtitle: Text("${user.phoneNumber}", style: AppTextStyles.medium()),
                      trailing: const Icon(Icons.edit, color: Colors.white),
                      onTap: () => Get.to(() => ChangPhoneNumber()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email_outlined, size: 25, color: Colors.white),
                      title: Text(CustomText.Email, style: AppTextStyles.medium()),
                      subtitle: Text("${user.email}", style: AppTextStyles.medium()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.password, size: 25, color: Colors.white),
                      title: Text(CustomText.Change_password, style: AppTextStyles.medium()),
                      subtitle: Text(CustomText.Password_tab_Text, style: AppTextStyles.medium()),
                      trailing: const Icon(Icons.edit, size: 25, color: Colors.white),
                      onTap: () => Get.to(Changepassword()),
                    ),

                    // Add Home & Work
                    ListTile(
                      leading: const Icon(Icons.home, size: 25, color: Colors.white),
                      title: Text(CustomText.Add_Home, style: AppTextStyles.medium()),
                      onTap: () => Get.to(() => AddHomeScreen()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home_work, size: 25, color: Colors.white),
                      title: Text(CustomText.Add_Work, style: AppTextStyles.medium()),
                      onTap: () => Get.to(() => AddWork_Screen()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final profileController = Get.put(profileModelController());
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<profileModelController>(
//       init: profileModelController(),
//       builder: (profileController){
//         return SafeArea(
//           child: Scaffold(
//             //backgroundColor: CustomColor.background,
//             body: Container(
//               height:MediaQuery.of(context).size.height,
//               width:MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color.fromARGB(255, 30, 1, 44),
//                     Color.fromARGB(255, 227, 194, 242)
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               child:Obx(() {
//                 if (profileController.loading.value) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//
//                 if (profileController.profileData.value == null) {
//                   return Center(child: Text("No Data"));
//                 }
//
//                 final user = profileController.profileData.value!;
//
//                 return SingleChildScrollView(
//                   child: Column
//                     (
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.1,
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         decoration: BoxDecoration(
//                           //color: CustomColor.Container_Colors,
//                           borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             bottomRight: Radius.circular(20),
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//
//                             IconButton(
//                               onPressed: () {
//                                 Get.back();
//                               },
//                               icon: Icon(
//                                 Icons.arrow_back,
//                                 size: MediaQuery.of(context).size.width * 0.06,
//                                 color: CustomColor.Icon_Color,
//                               ),
//                             ),
//
//                             const SizedBox(width: 5),
//
//                             Expanded(
//                               child: Center(
//                                 child: Text(
//                                   CustomText.User_Profile,
//                                   style: AppTextStyles.heading(
//                                     size: MediaQuery.of(context).size.width * 0.06,
//                                     weight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//
//                           ],
//                         ),
//                       ),
//
//                       SizedBox(height: 20),
//
//                       Stack(
//
//                         children: [
//                           //   Center(
//                           //   child: Obx(() => Stack(
//                           //     children: [
//                           //       CircleAvatar(
//                           //         radius: 55,
//                           //         backgroundColor: Colors.grey,
//                           //         child: CircleAvatar(
//                           //           radius: 50,
//                           //           backgroundImage: profileController.profileImg?.value == null
//                           //               ? const AssetImage("assets/images/profileimage.png")
//                           //               : FileImage(profileController.profileImg.value!) as ImageProvider,
//                           //         ),
//                           //       ),
//                           //
//                           //       Positioned(
//                           //         bottom: 0,
//                           //         right: 0,
//                           //         child: InkWell(
//                           //           onTap: () {
//                           //             profileController.pickImage();
//                           //           },
//                           //           child: CircleAvatar(
//                           //             radius: 18,
//                           //             backgroundColor: Colors.blue,
//                           //             child: Icon(Icons.camera_alt, size: 18, color: Colors.white),
//                           //           ),
//                           //         ),
//                           //       )
//                           //     ],
//                           //   )),
//                           // ),
//                           //
//
//
//                           Center(
//                               child: Obx(() {
//                                 final profile = profileController.profileData.value;
//
//                                 // Loading state
//                                 if (profileController.loading.value) {
//                                   return CircleAvatar(
//                                     radius: 55,
//                                     backgroundImage: FileImage(
//                                       user.profilePicture,
//                                     ),
//                                     //AssetImage("assets/images/profileimage.png"),
//
//                                   );
//                                 }
//
//                                 // Temporary preview (newly picked image)
//                                 if (profileController.selectedImage.value != null) {
//                                   return CircleAvatar(
//                                     radius: 50,
//                                     backgroundImage: FileImage(
//                                       user.profilePicture,
//                                     ),
//                                   );
//                                 }
//
//                                 // Image from API (after login / refresh)
//                                 if (profile?.profilePicture!= null &&
//                                     profile!.profilePicture!.isNotEmpty) {
//                                   return CircleAvatar(
//                                     radius: 50,
//                                     backgroundImage: NetworkImage(
//                                       profile.profilePicture!,
//                                     ),
//                                   );
//                                 }
//
//                                 // Default image (first time null)
//                                 return CircleAvatar(
//                                   radius: 50,
//                                   backgroundImage: AssetImage("assets/images/profileimage.png"),
//                                 );
//                               })
//
//                           ),
//
//
//                           Positioned(
//                             left: 230,
//                             top: 80,
//                             child: GestureDetector(
//                               child:  Icon(
//                                 Icons.photo_camera_rounded,
//                                 size: 30,
//                                 color:CustomColor.Icon_Color,
//                               ),
//                               onTap: (){
//                                 // profileController.changeProfilePicture(TokenManager.userId);
//                                 if (profileController.profileImg == null) {
//                                   profileController.pickImage();
//                                   print(TokenManager.userId);
//                                 }
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//
//
//
//
//
//
//
//
//                       SizedBox(height: 10),
//
//                       ListTile(
//                         leading: Icon(Icons.person, size: 25, color: Colors.white),
//                         title: Text(
//                           CustomText.Name,
//                           style: AppTextStyles.medium(),
//                         ),
//                         subtitle: Text(
//                           "${user.firstName} ${user.lastName}",
//                           style: AppTextStyles.medium(),
//                         ),
//                       ),
//
//                       ListTile(
//                         leading: Icon(Icons.phone, size: 25, color: Colors.white),
//                         title: Text(
//                           CustomText.Mobile,
//                           style: AppTextStyles.medium(),
//                         ),
//                         subtitle: Text(
//                           " ${user.phoneNumber}",
//                           style: AppTextStyles.medium(),
//                         ),
//                         trailing: Icon(Icons.edit, color: Colors.white),
//                         onTap: () {
//                           Get.to(() => ChangPhoneNumber());
//                         },
//                       ),
//
//                       ListTile(
//                         leading: Icon(
//                           Icons.email_outlined,
//                           size: 25,
//                           color: Colors.white,
//                         ),
//                         title: Text(
//                           CustomText.Email,
//                           style: AppTextStyles.medium(),
//                         ),
//                         subtitle: Text(
//                           "${user.email}",
//                           style: AppTextStyles.medium(),
//                         ),
//                       ),
//
//                       ListTile(
//                         leading: Icon(Icons.password, size: 25, color: Colors.white),
//                         title: Text(
//                           CustomText.Change_password,
//                           style: AppTextStyles.medium(),
//                         ),
//                         subtitle: Text(
//                           CustomText.Password_tab_Text,
//                           style: AppTextStyles.medium(),
//                         ),
//                         trailing: Icon(Icons.edit, size: 25, color: Colors.white),
//                         onTap: () {
//                           Get.to(Changepassword());
//                         },
//                       ),
//
//                       ListTile(
//                         leading: Icon(Icons.delete, size: 25, color: Colors.white),
//                         title: Text(
//                           CustomText.Delete_Account,
//                           style: AppTextStyles.medium(),
//                         ),
//                         onTap: () {
//                           Get.dialog(
//                             //============================  Dialog box
//                             Dialog(
//                               backgroundColor: CustomColor.Container_Colors,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                                     color: CustomColor.Container_Colors
//                                 ),
//                                 height: 260,
//                                 width: 150,
//                                 child: Column(
//                                   children: [
//                                     SizedBox(height: 25),
//
//                                     Text(
//                                       CustomText.Delete_Account,
//                                       style: AppTextStyles.heading(
//                                         size: 20,
//                                       ),
//                                     ),
//                                     SizedBox(height: 12),
//                                     Icon(
//                                       Icons.warning_amber,
//                                       color: Colors.amberAccent,
//                                       size: 40,
//                                     ),
//                                     SizedBox(height: 12),
//                                     Center(
//                                       child: Container(
//                                         height: 80,
//                                         width: 200,
//                                         child: Text(
//                                           CustomText.Delete_Alert,
//
//                                           textAlign: TextAlign.center,
//                                           style: AppTextStyles.small(),
//                                         ),
//                                       ),
//                                     ),
//
//                                     //SizedBox(height: 10,),
//
//                                     Row(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//
//                                         CustomTextButton(
//                                           text: 'Yes',
//                                           onPressed: () {},
//                                           backgroundColor: Colors.red,
//                                           textColor: CustomColor.Text_Color,
//                                           borderRadius: 8,
//                                           elevation: 2,
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.bold,
//                                           padding: EdgeInsets.symmetric(
//                                             horizontal: 16,
//                                             vertical: 10,
//                                           ),
//                                         ),
//                                         SizedBox(width: 20),
//
//                                         CustomTextButton(
//                                           text: ' NO ',
//                                           onPressed: () {
//                                             Get.back();
//                                           },
//                                           backgroundColor: CustomColor.Button_background_Color,
//                                           textColor: CustomColor.Text_Color,
//                                           borderRadius: 8,
//                                           elevation: 2,
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.bold,
//                                           padding: EdgeInsets.symmetric(
//                                             horizontal: 16,
//                                             vertical: 10,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.home, size: 25, color: Colors.white),
//                         title: Text(
//                           CustomText.Add_Home,
//                           style: AppTextStyles.medium(),
//                         ),
//                         onTap: () {
//                           Get.to(() => AddHomeScreen());
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.home_work, size: 25, color: Colors.white),
//                         title: Text(
//                           CustomText.Add_Work,
//                           style: AppTextStyles.medium(),
//                         ),
//                         onTap: () {
//                           Get.to(() => AddWork_Screen());
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               })
//               ,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// import 'package:customer/View/Deshboard/AddHome/add_home.dart';
// import 'package:customer/View/Deshboard/AddWork/add_work.dart';
// import 'package:customer/View/Widgets/color.dart';
// import 'package:customer/View/Widgets/text_button.dart';
// import 'package:customer/View/profile/changepassword.dart';
// import 'package:customer/View/profile/changephone_number.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../api_servies/session.dart';
// import '../Widgets/all_text.dart';
// import '../textstyle/apptextstyle.dart';
// import 'controller/profile_controller.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final profileController = Get.put(profileModelController());
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         //backgroundColor: CustomColor.background,
//         body: Container(
//           height:MediaQuery.of(context).size.height,
//           width:MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromARGB(255, 30, 1, 44),
//                 Color.fromARGB(255, 227, 194, 242)
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child:Obx(() {
//             if (profileController.loading.value) {
//               return Center(child: CircularProgressIndicator());
//             }
//
//             if (profileController.profileData.value == null) {
//               return Center(child: Text("No Data"));
//             }
//
//             final user = profileController.profileData.value!;
//
//             return SingleChildScrollView(
//               child: Column
//                 (
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.1,
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                         //color: CustomColor.Container_Colors,
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(20),
//                         bottomRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//
//                         IconButton(
//                           onPressed: () {
//                             Get.back();
//                           },
//                           icon: Icon(
//                             Icons.arrow_back,
//                             size: MediaQuery.of(context).size.width * 0.06,
//                             color: CustomColor.Icon_Color,
//                           ),
//                         ),
//
//                         const SizedBox(width: 5),
//
//                         Expanded(
//                           child: Center(
//                             child: Text(
//                               CustomText.User_Profile,
//                               style: AppTextStyles.heading(
//                                 size: MediaQuery.of(context).size.width * 0.06,
//                                 weight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//
//
//                       ],
//                     ),
//                   ),
//
//                   SizedBox(height: 20),
//
//                   // Stack(
//                   //
//                   //   children: [
//                     //   Center(
//                     //   child: Obx(() => Stack(
//                     //     children: [
//                     //       CircleAvatar(
//                     //         radius: 55,
//                     //         backgroundColor: Colors.grey,
//                     //         child: CircleAvatar(
//                     //           radius: 50,
//                     //           backgroundImage: profileController.profileImg?.value == null
//                     //               ? const AssetImage("assets/images/profileimage.png")
//                     //               : FileImage(profileController.profileImg.value!) as ImageProvider,
//                     //         ),
//                     //       ),
//                     //
//                     //       Positioned(
//                     //         bottom: 0,
//                     //         right: 0,
//                     //         child: InkWell(
//                     //           onTap: () {
//                     //             profileController.pickImage();
//                     //           },
//                     //           child: CircleAvatar(
//                     //             radius: 18,
//                     //             backgroundColor: Colors.blue,
//                     //             child: Icon(Icons.camera_alt, size: 18, color: Colors.white),
//                     //           ),
//                     //         ),
//                     //       )
//                     //     ],
//                     //   )),
//                     // ),
//                     //
//
//             //
//             //           Center(
//             //             child: Obx(() => profileController.loadere.value == true
//             // ? CircleAvatar(
//             //               radius: 55,
//             //               backgroundColor: Colors.grey,
//             //               child: CircleAvatar(
//             //                 radius: 50,
//             //                 backgroundColor: Colors.transparent,
//             //                 backgroundImage: AssetImage("assets/images/profileimage.png"),
//             //             )):CircleAvatar(
//             //               radius: 55,
//             //               backgroundColor: Colors.grey,
//             //               child: CircleAvatar(
//             //                 radius: 50,
//             //                 backgroundColor: Colors.transparent,
//             //                 backgroundImage:profileController.profileImgss == null?AssetImage("assets/images/profileimage.png"):
//             //                 FileImage(File(profileController.profileImgss!.files[0].path!)) as ImageProvider,
//             //               ),
//             //             )),
//             //           ),
//             //
//             //
//             //           Positioned(
//             //             left: 230,
//             //             top: 85,
//             //             child: GestureDetector(
//             //               child:  Icon(
//             //                 Icons.photo_camera_rounded,
//             //                 size: 30,
//             //                 color:CustomColor.Icon_Color,
//             //               ),
//             //               onTap: (){
//             //                 // profileController.changeProfilePicture(TokenManager.userId);
//             //                 if (profileController.profileImg == null) {
//             //                   profileController.pickImage();
//             //                 }
//             //               },
//             //             ),
//             //           )
//             //         ],
//             //       ),
//             //
//             //
//             //
//
//
//
//
//
//             SizedBox(height: 10),
//
//                   ListTile(
//                     leading: Icon(Icons.person, size: 25, color: Colors.white),
//                     title: Text(
//                       CustomText.Name,
//                       style: AppTextStyles.medium(),
//                     ),
//                     subtitle: Text(
//                       "${user.firstName} ${user.lastName}",
//                       style: AppTextStyles.medium(),
//                     ),
//                   ),
//
//                   ListTile(
//                     leading: Icon(Icons.phone, size: 25, color: Colors.white),
//                     title: Text(
//                       CustomText.Mobile,
//                       style: AppTextStyles.medium(),
//                     ),
//                     subtitle: Text(
//                       " ${user.phoneNumber}",
//                       style: AppTextStyles.medium(),
//                     ),
//                     trailing: Icon(Icons.edit, color: Colors.white),
//                     onTap: () {
//                       Get.to(() => ChangPhoneNumber());
//                     },
//                   ),
//
//                   ListTile(
//                     leading: Icon(
//                       Icons.email_outlined,
//                       size: 25,
//                       color: Colors.white,
//                     ),
//                     title: Text(
//                       CustomText.Email,
//                       style: AppTextStyles.medium(),
//                     ),
//                     subtitle: Text(
//                       "${user.email}",
//                       style: AppTextStyles.medium(),
//                     ),
//                   ),
//
//                   ListTile(
//                     leading: Icon(Icons.password, size: 25, color: Colors.white),
//                     title: Text(
//                       CustomText.Change_password,
//                       style: AppTextStyles.medium(),
//                     ),
//                     subtitle: Text(
//                       CustomText.Password_tab_Text,
//                       style: AppTextStyles.medium(),
//                     ),
//                     trailing: Icon(Icons.edit, size: 25, color: Colors.white),
//                     onTap: () {
//                       Get.to(Changepassword());
//                     },
//                   ),
//                   //===============================================================================  Delete
//                     ListTile(
//                       leading: Icon(Icons.delete, size: 25, color: Colors.white),
//                       title: Text(
//                         CustomText.Delete_Account,
//                         style: AppTextStyles.medium(),
//                       ),
//                       onTap: () {
//                         Get.dialog(
//   //============================  Dialog box
//                           Dialog(
//                             backgroundColor: CustomColor.Container_Colors,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                                   color: CustomColor.Container_Colors
//                               ),
//                               height: 260,
//                               width: 150,
//                               child: Column(
//                                 children: [
//                                   SizedBox(height: 25),
//
//                                   Text(
//                                     CustomText.Delete_Account,
//                                     style: AppTextStyles.heading(
//                                       size: 20,
//                                     ),
//                                   ),
//                                   SizedBox(height: 12),
//                                   Icon(
//                                     Icons.warning_amber,
//                                     color: Colors.amberAccent,
//                                     size: 40,
//                                   ),
//                                   SizedBox(height: 12),
//                                   Center(
//                                     child: Container(
//                                       height: 80,
//                                       width: 200,
//                                       child: Text(
//                                         CustomText.Delete_Alert,
//
//                                         textAlign: TextAlign.center,
//                                         style: AppTextStyles.small(),
//                                       ),
//                                     ),
//                                   ),
//
//                                                //SizedBox(height: 10,),
//
//                                   Row(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//
//                                       CustomTextButton(
//                                         text: 'Yes',
//                                         onPressed: ()  {
//                                            profileController.deleteAccount(user.id!);
//
//                                           // await Future.delayed(const Duration(milliseconds: 200));
//                                           //
//                                           // await Get.find<profileModelController>().deleteAccount(TokenManager.userId);
//                                         },
//                                         backgroundColor: Colors.red,
//                                         textColor: CustomColor.Text_Color,
//                                         borderRadius: 8,
//                                         elevation: 2,
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.bold,
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 16,
//                                           vertical: 10,
//                                         ),
//                                       ),
//                                       SizedBox(width: 20),
//
//                                       CustomTextButton(
//                                         text: ' NO ',
//                                         onPressed: () {
//                                           Get.back();
//                                         },
//                                         backgroundColor: CustomColor.Button_background_Color,
//                                         textColor: CustomColor.Text_Color,
//                                         borderRadius: 8,
//                                         elevation: 2,
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.bold,
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 16,
//                                           vertical: 10,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ListTile(
//                     leading: Icon(Icons.home, size: 25, color: Colors.white),
//                     title: Text(
//                       CustomText.Add_Home,
//                       style: AppTextStyles.medium(),
//                     ),
//                     onTap: () {
//                       Get.to(() => AddHomeScreen());
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.home_work, size: 25, color: Colors.white),
//                     title: Text(
//                       CustomText.Add_Work,
//                       style: AppTextStyles.medium(),
//                     ),
//                     onTap: () {
//                       Get.to(() => AddWork_Screen());
//                     },
//                   ),
//                 ],
//               ),
//             );
//           })
//           ,
//         ),
//       ),
//     );
//   }
// }
