import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../View/Deshboard/map_widget/map_controller.dart';
import '../../View/Widgets/loc_permission_wedgit.dart';



class LocationPermissionController extends GetxController
    with WidgetsBindingObserver {

  final mapC = Get.isRegistered<PickLocationController>()
      ? Get.find<PickLocationController>()
      : Get.put(PickLocationController());

  bool _dialogShowing = false;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkPermission();
    });
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await checkPermission();
    }
  }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //
  //   if(state==AppLifecycleState.resumed){
  //     checkPermission();
  //   }
  //
  // }

  Future<void> checkPermission() async {

    bool serviceEnabled =
    await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){

      if(!_dialogShowing){

        _dialogShowing=true;

        LocationPermissionDialog.show(
          onPressed: () async {
            if (Get.context != null) Navigator.of(Get.context!).pop();
            _dialogShowing = false;
            await Geolocator.openLocationSettings();
          },
        );

      }

      return;
    }

    LocationPermission permission =
    await Geolocator.checkPermission();

    if(permission==LocationPermission.denied){

      permission=await Geolocator.requestPermission();

    }

    if(permission==LocationPermission.deniedForever){

      if(!_dialogShowing){

        _dialogShowing=true;

        LocationPermissionDialog.show(
          onPressed: () async {
            if (Get.context != null) Navigator.of(Get.context!).pop();
            _dialogShowing = false;
            await Geolocator.openLocationSettings();

          },
        );

      }

      return;
    }

    if(Get.isDialogOpen??false){
      if (Get.context != null) Navigator.of(Get.context!).pop();
    }

    _dialogShowing=false;if (Get.isDialogOpen ?? false) {
      if (Get.context != null) Navigator.of(Get.context!).pop();
    }

    _dialogShowing = false;

    await mapC.getUserLocation();
  }

}