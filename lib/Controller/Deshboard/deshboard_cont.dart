import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../View/Deshboard/map_widget/map_controller.dart';
import '../../View/profile/controller/profile_controller.dart';
import '../../api_servies/api_servies.dart';
import '../../api_servies/session.dart';
import '../Home/model/pickuplocationmodel.dart';

class DeshBoardAddHome_Controller extends GetxController {

  Future<void> sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'example@gmail.com',
      queryParameters: {
        'subject': 'Ride Inquiry',
        'body': 'Hello, I need help regarding my ride',
      },
    );

    try {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication, // 👈 IMPORTANT
      );
    } catch (e) {
      print("Email launch error: $e");
      Get.snackbar("Error", "No email app found");
    }
  }

  final profileController = Get.isRegistered<profileModelController>()
      ? Get.find<profileModelController>()
      :  Get.put(profileModelController());

  final mapC = Get.isRegistered<PickLocationController>()
      ? Get.find<PickLocationController>()
      : Get.put(PickLocationController());

  @override
  void onInit() {
    super.onInit();
    profileController.getuserProfile();
  }



  final RxnInt editingIndex = RxnInt();



  /// Map visibility
  RxBool showMap = false.obs;


  @override
  void onReady() {
    super.onReady();

    /// Safe delayed mount
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!isClosed) {
        showMap.value = true;
      }
    });
  }


  // TextField
  final TextEditingController HomeController = TextEditingController();
  final TextEditingController WorkAdressController = TextEditingController();



 ///=====================================  ===========  =============================================== add Home address


  void editItem() {
   // //HomeController.text =gethomeaddress ?? homeAddress.value;
  HomeController.text =profileController.profileData!.customer!.address1!;
    editingIndex.value = 0;
  }

  void clearfield(){
    HomeController.clear();
  }

  /// ========================================================================================================   Add home api


  Future<void> AddhomeApi() async {

    if (HomeController.text.isEmpty) {
      BotToast.showText(text: "Please enter address");
      return;
    }

    var data = {
      "address1": HomeController.text,
       "address1_latitude": selectedLat.value,
       "address1_longitude":selectedLng.value
    };

    var response = await ApiService.post(
      data,
      "customers/edit/${TokenManager.userId}",
      auth: true,
    );

    if (response!.statusCode == 200) {

      profileController.profileData!.customer!.address1 = HomeController.text;

      profileController.update();   // 🔥 THIS refreshes GetBuilder UI

      BotToast.showText(text: "Address Updated Successfully");
      clearfield();

    }
  }

  /// =====================================================================================================      delete api

  Future<void> deleteHomeApi() async {

    var data = {
      "address1": " ",
      "address1_latitude": selectedLat.value,
      "address1_longitude":selectedLng.value

    };

    var response = await ApiService.post(
      data,
      "customers/edit/${TokenManager.userId}",
      auth: true,
    );

    if (response!.statusCode == 200) {

     profileController.profileData!.customer!.address1 = "";

     //profileController.update([?profileController.profileData!.customer!.address1]);   //  THIS refreshes GetBuilder UI

     profileController.update();

      BotToast.showText(text: "Address Delete Successfully");
      clearWorkField();

    }
  }


  ///   ///============================= ======================== ================ ============  Add home location search

  RxBool homeSearchloading = false.obs;
  RxList<Result> homeSearchList = <Result>[].obs;
  RxDouble selectedLat = 0.0.obs;
  RxDouble selectedLng = 0.0.obs;

  RxString selectedLocationName = ''.obs;

  void selectHomeLocation(Result data) {
    selectedLat.value = data.lat ?? 0.0;
    selectedLng.value = data.lon ?? 0.0;
    selectedLocationName.value = data.name ?? '';
    print("${selectedLat}  ${selectedLng}");

    homeSearchList.clear(); // optional: search hide after select
  }

  Future<void> addhomeLocation(String text) async {
    if (text.isEmpty) {
      homeSearchList.clear();
      return;
    }


    homeSearchloading.value = true;


    var response = await ApiService.get(
      'services/search',
      // '',
      // fullUrl: 'http://192.168.110.4:5000/api/services/search?search=${HomeController.text.toUpperCase()}',
      auth: true,
      isProgressShow: false,
      queryParameters: {
        'search':HomeController.text
      }
    );

    if ( response!.statusCode == 200) {
      LocationModel model = LocationModel.fromJson(response.data);

      homeSearchList.value = model.result ?? [];
    }

    homeSearchloading.value = false;

  }


///======================================= ================================= =================================    add work  ================================  ============================


  void editWorkAddress() {
    WorkAdressController.text =profileController.profileData!.customer!.address2!;
    editingIndex.value = 0;
  }



  void clearWorkField() {
    WorkAdressController.clear();
  }



  Future<void> AddworkApi() async {

    if (WorkAdressController.text.isEmpty) {
      BotToast.showText(text: "Please enter address");
      return;
    }

    var data = {
      "address2": WorkAdressController.text,
    };

    var response = await ApiService.post(
      data,
      "customers/edit/${TokenManager.userId}",
      auth: true,
    );

    if (response!.statusCode == 200) {

     profileController.profileData!.customer!.address2 = WorkAdressController.text;

      profileController.update();   // 🔥 THIS refreshes GetBuilder UI

      BotToast.showText(text: "Address Updated Successfully");
      clearWorkField();

    }
  }


  Future<void> deleteWorkapi() async {

    var data = {
      "address2": " ",
    };

    var response = await ApiService.post(
      data,
      "customers/edit/${TokenManager.userId}",
      auth: true,
    );

    if (response!.statusCode == 200) {

     profileController.profileData!.customer!.address2 = "";

      profileController.update();   // 🔥 THIS refreshes GetBuilder UI

      BotToast.showText(text: "Address Delete Successfully");
      clearWorkField();

    }
  }


  ///   ///============================= ======================== ================ ============  Add work location search

  RxBool workSearchloading = false.obs;
  RxList<Result> workSearchList = <Result>[].obs;


  Future<void> addworkLocation(String text) async {
    if (text.isEmpty) {
      workSearchList.clear();
      return;
    }


    workSearchloading.value = true;

    var response = await ApiService.get(
      'services/search',
      // '',
      // fullUrl: 'http://192.168.110.4:5000/api/services/search?search=${WorkAdressController.text.toUpperCase()}',
      auth: true,
      isProgressShow: false,
      queryParameters: {
        'search':WorkAdressController.text
      }
    );

    if ( response!.statusCode == 200) {
      LocationModel model = LocationModel.fromJson(response.data);

      workSearchList.value = model.result ?? [];
    }

    workSearchloading.value = false;

  }


}
