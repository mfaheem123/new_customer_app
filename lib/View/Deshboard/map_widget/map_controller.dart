// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class PickUpController extends GetxController {
//   final osm.MapController mapController = osm.MapController();
//
//   Rx<osm.GeoPoint> selectedLocation =
//       osm.GeoPoint(latitude: 24.8607, longitude: 67.0011).obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     requestPermission();
//     // Set initial position once map is ready
//     mapController.listenerMapIsReady.addListener(() async {
//       await mapController.goToLocation(
//         osm.GeoPoint(latitude: 24.8607, longitude: 67.0011),
//         zoomLevel: 15,
//       );
//     });
//   }
//
//   void requestPermission() async {
//     await Permission.location.request();
//   }
//
//   void onMapMoved() async {
//     osm.GeoPoint center = await mapController.centerMap;
//     selectedLocation.value = center;
//   }
//
//   Future<void> goToUserLocation() async {
//     await mapController.currentLocation();
//   }
// }
//
//
//
// // // permission_handler: ^11.3.0
// // // flutter_osm_plugin: ^1.3.8