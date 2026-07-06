import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class PickLocationController extends GetxController {
  /// selected center location
  Rxn<LatLng> selectedLocation = Rxn<LatLng>();

  /// address
  RxString address = "Move map to select location".obs;

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        print("GPS OFF");
        return;
      }

      LocationPermission permission =
      await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission  .denied) {
          print("Permission Denied");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print("Permission Denied Forever");
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      final latLng = LatLng(pos.latitude, pos.longitude);

      selectedLocation.value = latLng;

      await _updateAddress(latLng);

      update();

      print("Current Location : $latLng");
    } catch (e) {
      print("Location Error : $e");
    }
  }

  // Future<void> _getUserLocation() async {
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
  //   final pos = await Geolocator.getCurrentPosition(
  //     locationSettings:
  //     const LocationSettings(accuracy: LocationAccuracy.high),
  //   );
  //
  //   final latLng = LatLng(pos.latitude, pos.longitude);
  //   selectedLocation.value = latLng;
  //   _updateAddress(latLng);
  // }

  /// sirf DATA update
  void updateLocation(LatLng latLng) {
    selectedLocation.value = latLng;
    _updateAddress(latLng);
  }

  Future<void> _updateAddress(LatLng position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        address.value = "${p.name}, ${p.locality}, ${p.country}";
      }
    } catch (_) {
      address.value = "Address not found";
    }
  }
}
// class PickLocationController extends GetxController {
//   /// selected center location
//   Rxn<LatLng> selectedLocation = Rxn<LatLng>();
//
//   /// address
//   RxString address = "Move map to select location".obs;
//
//
//
//   MapController mapController = MapController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     _getUserLocation();
//   }
//
//   Future<void> _getUserLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) return;
//
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) return;
//     }
//     if (permission == LocationPermission.deniedForever) return;
//
//     final pos = await Geolocator.getCurrentPosition(
//       locationSettings:
//       const LocationSettings(accuracy: LocationAccuracy.high),
//     );
//
//     final latLng = LatLng(pos.latitude, pos.longitude);
//     selectedLocation.value = latLng;
//     _updateAddress(latLng);
//   }
//
//   /// map move → sirf location & address update
//   void onMapMove(position, bool hasGesture) {
//     if (position.center == null) return;
//
//     selectedLocation.value = position.center!;
//     _updateAddress(position.center!);
//   }
//
//
//   Future<void> _updateAddress(LatLng position) async {
//     try {
//       final placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//
//       if (placemarks.isNotEmpty) {
//         final p = placemarks.first;
//         address.value =
//         "${p.name}, ${p.locality}, ${p.country}";
//       }
//     } catch (_) {
//       address.value = "Address not found";
//     }
//   }
//
//
// }











