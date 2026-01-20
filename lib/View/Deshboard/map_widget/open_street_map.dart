import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'map_controller.dart';
import 'map_polyLine.dart'; // next screen

class PickupLocationScreen extends StatelessWidget {
  PickupLocationScreen({super.key});

  final c = Get.put(PickLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (c.selectedLocation.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            /// MAP
            FlutterMap(
              mapController: c.mapController,
              options: MapOptions(
                initialCenter: c.selectedLocation.value!,
                initialZoom: 14,
                onPositionChanged: c.onMapMove,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                  "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.customer',
                ),
              ],
            ),

            /// CENTER ADDRESS + PIN
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        c.address.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  )),
                  const SizedBox(height: 10),
                  const Icon(
                    Icons.location_pin,
                    size: 50,
                    color: Colors.red,
                  ),
                ],
              ),
            ),

            /// CONFIRM PICKUP BUTTON
            // Positioned(
            //   bottom: 30,
            //   left: 20,
            //   right: 20,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       if (c.selectedLocation.value == null) return;
            //
            //       Get.to(
            //             () => DropLocationScreen(
            //           pickupLatLng: c.selectedLocation.value!,
            //           pickupAddress: c.address.value,
            //         ),
            //       );
            //     },
            //     child: const Text("Confirm Pickup Location"),
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}


























// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
//
// import 'map_controller.dart';
//
//
// class OpenStreetMapView extends StatelessWidget {
//   OpenStreetMapView({super.key});
//  // final mapC = Get.put(MapLocationController());
//
//   final mapC = Get.isRegistered<MapLocationController>()
//       ? Get.find<MapLocationController>()
//       : Get.put(MapLocationController());
//
//   @override
//   Widget build(BuildContext context) {
//     return  Obx(() {
//       if (mapC.currentPosition.value == null) {
//         return const Center(child: CircularProgressIndicator());
//       }
//
//
//       return FlutterMap(
//         mapController: mapC.mapController,
//         options: MapOptions(
//           initialCenter: mapC.currentPosition.value!,
//           initialZoom: 13,
//           onPositionChanged: mapC.onMapMove,
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//             userAgentPackageName: 'com.example.customer',
//             //urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'
//           ),
//
//           // Center Marker + Address
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 220,
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Obx(() => Text(
//                     mapC.currentAddress.value,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 10),
//                   )),
//                 ),
//                 const Icon(Icons.location_on, color: Colors.red, size: 50),
//               ],
//             ),
//           ),
//
//           // My Location Button
//           Positioned(
//             right: 15,
//             top: 50,
//             child: FloatingActionButton(
//               onPressed: mapC.moveToCurrent,
//               child: const Icon(Icons.my_location),
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
