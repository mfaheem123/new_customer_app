import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:customer/View/profile/model/get_profile_model.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> getuserProfile() async {
    loading.value = true;
    update();

    try {
      var response = await ApiService.get(
        "auth/customer-profile/${TokenManager.userId}",
        auth: true,
      );

      if (response != null && response.statusCode == 200) {
        profileData = GetProfileModel.fromJson(response.data);
      } else {
        profileData = null;
      }
    } catch (e) {
      profileData = null;
    }

    loading.value = false;
    update();
  }

  // Future<void> getuserProfile() async {
  //   loading.value = true;
  //   update();
  //   var response = await ApiService.get(
  //     "auth/customer-profile/${TokenManager.userId}",
  //     auth: true,
  //   );
  //
  //   if (response!.statusCode == 200) {
  //     profileData= GetProfileModel.fromJson(response.data);
  //   } else {
  //     profileData = null;
  //   }
  //
  //   loading.value = false;
  //   update();
  // }

  /// ================================= ========================= ==================================== ================== profile image Update


  Rx<File?> selectedImage = Rx<File?>(null);
  RxBool loader = false.obs;

  Future<void> changeProfilePicture(int userId) async {
    final XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img == null) return;

    selectedImage.value = File(img.path); // 👈 instant preview

    loader(true);

    FormData formData = FormData.fromMap({
      "profile_picture": await MultipartFile.fromFile(
        img.path,
        filename: img.path.split('/').last,
      ),
    });

    var response = await ApiService.put(
      formData,
      '',
      fullUrl: "http://192.168.18.16:5000/api/auth/upload-profile-image/${TokenManager.userId}",
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




