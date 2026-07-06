import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:customer/View/profile/model/get_profile_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../api_servies/api_servies.dart';
import '../../../api_servies/session.dart';
import 'package:dio/dio.dart';


class profileModelController extends GetxController {
  RxBool loading = true.obs; // Remove Rx, will call update()
  GetProfileModel? profileData;


  @override
  void onInit() {
    super.onInit();
    getuserProfile();
  }

  ///--------------------------------------------------------------  user get profile api







  ///===================================================================

  Future<void> getuserProfile() async {
    loading.value = true;
    update();
    var response = await ApiService.get(
        "customers/getbyid/${TokenManager.userId}",
     //  "customers/getbyid/419",
      auth: true,
    );

    if (response !.statusCode == 200) {
      profileData= GetProfileModel. fromJson(response.data);
    } else {
      profileData = null;
    }

    loading.value = false;
    update();
  }

  /// ================================= ========================= ==================================== ================== profile image Update


  Rx<File?> selectedImage = Rx<File?>(null);
  RxBool loader = false.obs;
  void showImageSourceDialog(int userId) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: Color(0xffF8F9FD),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Drag Handle
              Container(
                width: 55,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xffEEF4FF),
                child: Icon(
                  Icons.photo_camera_back_rounded,
                  size: 30,
                  color: Color(0xff2962FF),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Change Profile Photo",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "Choose where you want to pick your photo from.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              /// Camera
              InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () async {
                  Get.back();

                  if (await requestCameraPermission()) {
                    changeProfilePicture(userId, ImageSource.camera);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0xffEEF4FF),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: Color(0xff2962FF),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          "Take Photo",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// Gallery
              InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  Get.back();
                  changeProfilePicture(userId, ImageSource.gallery);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0xffEEF4FF),
                        child: Icon(
                          Icons.photo_library_rounded,
                          color: Color(0xff2962FF),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          "Choose from Gallery",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () => Get.back(),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();

    print(status);

    switch (status) {
      case PermissionStatus.granted:
        return true;

      case PermissionStatus.denied:
        BotToast.showText(text: "Camera permission denied");
        return false;

      case PermissionStatus.permanentlyDenied:
        await openAppSettings();
        return false;

      case PermissionStatus.restricted:
        return false;

      case PermissionStatus.limited:
        return true;

      case PermissionStatus.provisional:
        return true;
    }
  }

  Future<void> changeProfilePicture(int userId, ImageSource source) async {
    final XFile? img = await ImagePicker().pickImage(source: source);
    if (img == null) return;

    selectedImage.value = File(img.path); //  instant preview

    loader(true);

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        img.path,
        filename: img.path.split('/').last,
      ),
    });

    var response = await ApiService.post(
      formData,
      '',
      fullUrl: "https://www.nexustechnologys.com/api/customers/profile-image/${TokenManager.userId}",
      //fullUrl: "http://158.220.92.206:5000/api/customers/profile-image/${TokenManager.userId}",
      multiPart: true,
      auth: true,
    );

    if (response!.statusCode == 200) {
      BotToast.showText(text: "Profile picture updated");
      await getuserProfile(); // server se fresh image
    } else {
      BotToast.showText(text: "Upload failed");
    }
    loader(false);
  }


  ///=========================== =================================== ===============================   Delete acc
  Future<void> deleteAccount(int userId) async {
    var response = await ApiService.delete(
      "auth/delete-account/${TokenManager.userId}", // endpoint
      auth: true,
    );

    if (response!.statusCode == 200) {
      BotToast.showText(text: "Account successfully deleted");

      // Clear tokens and storage
      TokenManager.clearAfterDelete();
      await GetStorage().erase();

      // Redirect to login screen
      Get.offAllNamed('/SigIn_Screen');
    }
  }
}




