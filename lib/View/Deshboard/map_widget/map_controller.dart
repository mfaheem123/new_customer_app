import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapLocationController extends GetxController {
  Rxn<LatLng> currentPosition = Rxn<LatLng>();
  RxString currentAddress = "Fetching location...".obs;
  RxBool isLoading = false.obs;

  MapController mapController = MapController();

  @override
  void onInit() {
    super.onInit();
   getUserLocation();
  }
  Future<void> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));

    LatLng latLng = LatLng(pos.latitude, pos.longitude);

    currentPosition.value = latLng;
    updateAddress(latLng);   // ❌ NO map move here
  }


  // Future<void> getUserLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) return;
  //
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) return;
  //   }
  //   if (permission == LocationPermission.deniedForever) return;
  //
  //   Position pos = await Geolocator.getCurrentPosition(
  //     locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
  //   );
  //
  //   LatLng latLng = LatLng(pos.latitude, pos.longitude);
  //   currentPosition.value = latLng;
  //   updateAddress(latLng);
  //   mapController.move(latLng, 15);
  // }

  Future<void> updateAddress(LatLng position) async {
    try {
      isLoading.value = true;
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        currentAddress.value =
            "${p.name}, "
            // "${p.street},"
            " ${p.subLocality},"
            " ${p.locality},"
            " ${p.country}";
      }
    } catch (e) {
      currentAddress.value = "Address not found";
    } finally {
      isLoading.value = false;
    }
  }

  void onMapMove(position, bool hasGesture) {
    if (hasGesture && position.center != null) {
      currentPosition.value = position.center;
      updateAddress(position.center);
    }
  }

  void moveToCurrent() {
    if (currentPosition.value != null) {
      mapController.move(currentPosition.value!, 17);
    }
  }
}
