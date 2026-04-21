import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:customer/View/profile/model/get_profile_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../api_servies/api_servies.dart';
import '../../../api_servies/session.dart';
import 'package:dio/dio.dart';


class profileModelController extends GetxController {
  RxBool loading = true.obs; // Remove Rx, will call update()
  GetProfileModel? profileData;

  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   getuserProfile();
  // }

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

    if (response!.statusCode == 200) {
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
        padding: EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Get.back();
                changeProfilePicture(userId, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () {
                Get.back();
                changeProfilePicture(userId, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }


  Future<void> changeProfilePicture(int userId, ImageSource source) async {
    final XFile? img = await ImagePicker().pickImage(source: source);
    if (img == null) return;

    selectedImage.value = File(img.path); //  instant preview

    loader(true);

    FormData formData = FormData.fromMap({
      "profile_picture": await MultipartFile.fromFile(
        img.path,
        filename: img.path.split('/').last,
      ),
    });

    var response = await ApiService.post(
      formData,
      '',
      fullUrl: "http://158.220.92.206:5000/api/customers/profile-image/${TokenManager.userId}",
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




