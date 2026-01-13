// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   Location location = Location();
//   LatLng currentLocation = LatLng(24.8607, 67.0011); // Default Karachi
//
//   @override
//   void initState() {
//     super.initState();
//     getCurrentLocation();
//   }
//
//   void getCurrentLocation() async {
//     bool serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) await location.requestService();
//
//     PermissionStatus permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//     }
//
//     LocationData locData = await location.getLocation();
//
//     setState(() {
//       currentLocation = LatLng(locData.latitude!, locData.longitude!);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FlutterMap(
//         options: MapOptions(
//           center: currentLocation,
//           zoom: 15,
//           interactiveFlags: InteractiveFlag.all,
//           plugins: [
//             LocationMarkerPlugin(),
//           ],
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: ['a', 'b', 'c'],
//           ),
//           CurrentLocationLayer(
//             plugin: const LocationMarkerPlugin(),
//             style: const LocationMarkerStyle(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
// // import 'package:get/get.dart';
// //
// // import 'map_controller.dart';
// //
// //
// // class ReusablePickupMap extends StatelessWidget {
// //   final double height;
// //   final double width;
// //
// //   ReusablePickupMap({
// //     super.key,
// //     this.height = 300,
// //     this.width = double.infinity,
// //   });
// //
// //   final PickUpController controller = Get.put(PickUpController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       height: height,
// //       width: width,
// //       child: Stack(
// //         children: [
// //           osm.OSMFlutter(
// //             controller: controller.mapController,
// //             trackMyPosition: false,
// //             showZoomController: true,
// //             userLocationMarker: osm.UserLocationMaker(
// //               personMarker: const osm.MarkerIcon(
// //                 icon: Icon(Icons.my_location, color: Colors.blue, size: 48),
// //               ),
// //               directionArrowMarker: const osm.MarkerIcon(
// //                 icon: Icon(Icons.navigation, color: Colors.blue, size: 48),
// //               ),
// //             ),
// //             onMapIsReady: (isReady) {
// //               if (isReady) {
// //                 controller.onMapMoved();
// //               }
// //             },
// //
// //           ),
// //
// //           // Fixed center marker
// //           const Center(
// //             child: Icon(Icons.location_pin, size: 50, color: Colors.red),
// //           ),
// //
// //           // Selected coordinates display
// //           Positioned(
// //             bottom: 10,
// //             left: 10,
// //             right: 10,
// //             child: Obx(() {
// //               return Container(
// //                 padding: const EdgeInsets.all(8),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white70,
// //                   borderRadius: BorderRadius.circular(8),
// //                   boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
// //                 ),
// //                 child: Text(
// //                   "Lat: ${controller.selectedLocation.value.latitude.toStringAsFixed(6)}, "
// //                       "Lng: ${controller.selectedLocation.value.longitude.toStringAsFixed(6)}",
// //                   style: const TextStyle(fontSize: 14),
// //                 ),
// //               );
// //             }),
// //           ),
// //
// //           // Floating button for user location
// //           Positioned(
// //             top: 10,
// //             right: 10,
// //             child: FloatingActionButton(
// //               mini: true,
// //               onPressed: () => controller.goToUserLocation(),
// //               child: const Icon(Icons.my_location),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
