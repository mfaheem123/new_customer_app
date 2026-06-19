
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
        final user = controller.profileData?.customer;
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
                                Get.back();
                              },
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
                        Obx(() {
                          return CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.green,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: controller.selectedImage.value != null
                                  ? FileImage(controller.selectedImage.value!)
                                  : (user.profileImage != null && user.profileImage!.isNotEmpty
                                  ? NetworkImage(user.profileImage!)
                                  : const AssetImage("assets/images/profileimage.png")
                              as ImageProvider),
                            ),
                          );
                        }),

                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              controller.showImageSourceDialog(user.id!);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: CustomColor.Button_background_Color,
                                border: Border.all(color: CustomColor.Icon_Color, width: 2),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                size: 20,
                                color: CustomColor.Icon_Color,
                              ),
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
                //           radius: 55,
                //           // backgroundColor: CustomColor.black,
                //           backgroundColor: Colors.green,
                //           child: CircleAvatar(
                //             radius: 50,
                //            backgroundImage: controller.selectedImage.value != null
                //                 ? FileImage(controller.selectedImage.value!)
                //                 : (user.profileImage != null && user.profileImage!.isNotEmpty
                //                 ? NetworkImage(user.profileImage!)
                //                 : const AssetImage("assets/images/profileimage.png") as ImageProvider),
                //           ),
                //         );
                //       }),
                //     ),
                //     Positioned(
                //       bottom: 0,
                //       right: MediaQuery.of(context).size.width * 0.4,
                //       child: GestureDetector(
                //         onTap: () {
                //           controller.changeProfilePicture(TokenManager.userId);
                //         },
                //         child: Container(
                //           padding: const EdgeInsets.all(6),
                //           decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: CustomColor.Button_background_Color,
                //           ),
                //           child: Icon(
                //             Icons.camera_alt_rounded,
                //             size: 25,
                //             // MediaQuery.of(context).size.width * 0.048,
                //             color: CustomColor.Icon_Color,
                //           ),
                //         ),
                //       ),
                //     ),
                //     // Positioned(
                //     //   right: 130,
                //     //   bottom: 0,
                //     //   child: GestureDetector(
                //     //     onTap: () {
                //     //       controller.changeProfilePicture(TokenManager.userId);
                //     //     },
                //     //     child: Icon(
                //     //       Icons.camera_alt_rounded,
                //     //       size: 30,
                //     //       color: CustomColor.Icon_Color,
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // ),




                    const SizedBox(height: 10),

                    // User Info
                    ListTile(
                      leading: const Icon(Icons.person, size: 25, color: Colors.white),
                      title: Text(CustomText.Name, style: AppTextStyles.medium()),
                      subtitle: Text("${user.name}", style: AppTextStyles.medium()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone, size: 25, color: Colors.white),
                      title: Text(CustomText.Mobile, style: AppTextStyles.medium()),
                      subtitle: Text("${user.mobile}", style: AppTextStyles.medium()),
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
                    ListTile(
                        leading: Icon(Icons.delete, size: 25, color: Colors.white),
                        title: Text(CustomText.Delete_Account, style: AppTextStyles.medium(),
                        ),
                        onTap: () {
                          Get.dialog(
                            Dialog(
                              backgroundColor: Colors.transparent,
                              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: 320,
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
                                      CustomText.Delete_Account,
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
                                        CustomText.Delete_Alert,
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

                                            profileController.deleteAccount(TokenManager.userId);

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
                                          text: '  No ',

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



