//
// import 'package:customer/View/textstyle/apptextstyle.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart';
//
// import '../../../Controller/Home/home-controller.dart';
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});
//
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   final c = Get.isRegistered<SwapController>()
//       ? Get.find<SwapController>()
//       : Get.put(SwapController());
//
//   final MapController mapController = MapController();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SwapController>(
//       id: "map",
//       builder: (c) {
//         if (c.selectedPickUPLat == 0.0 ||
//             c.selectedPickUPLon == 0.0 ||
//             c.selectedDropLat == 0.0 ||
//             c.selectedDropLon == 0.0) {
//           return Center(
//             child: Text(
//               "Select Pickup and Drop to view map",
//               style: AppTextStyles.heading(),
//             ),
//           );
//         }
//
//         final pickupLatLng =
//         LatLng(c.selectedPickUPLat, c.selectedPickUPLon);
//
//         final dropLatLng =
//         LatLng(c.selectedDropLat, c.selectedDropLon);
//
//
//         /// 🔥 AUTO FIT PICKUP + DROP + ROUTE
//         if (c.isMapReady) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             final List<LatLng> points = [];
//
//             points.add(pickupLatLng);
//             points.add(dropLatLng);
//
//             if (c.routePoints.isNotEmpty) {
//               points.addAll(c.routePoints);
//             }
//
//             final bounds = LatLngBounds.fromPoints(points);
//
//             mapController.fitCamera(
//               CameraFit.bounds(
//                 bounds: bounds,
//                 padding: const EdgeInsets.all(60),
//               ),
//             );
//             c.hasFittedMap = true; // 🔥 important
//           });
//         }
// //
//
//         return FlutterMap(
//           mapController: mapController,
//           options: MapOptions(
//             initialCenter: LatLng(
//               (pickupLatLng.latitude + dropLatLng.latitude) / 2,
//               (pickupLatLng.longitude + dropLatLng.longitude) / 2,
//             ),
//             initialZoom: 11,
//
//             onMapReady: () {
//               if (!c.hasFittedMap && c.routePoints.isNotEmpty) {
//                 Future.delayed(const Duration(milliseconds: 400), () {
//
//                   final allPoints = <LatLng>[
//                     pickupLatLng,
//                     dropLatLng,
//                     ...c.routePoints,
//                   ];
//
//                   final bounds = LatLngBounds.fromPoints(allPoints);
//
//                   // 👇 Smart padding based on screen (IMPORTANT)
//                   final size = MediaQuery.of(context).size;
//
//                   final horizontalPadding = size.width * 0.1;
//                   final verticalPadding = size.height * 0.20;
//
//                   mapController.fitCamera(
//                     CameraFit.bounds(
//                       bounds: bounds,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: horizontalPadding,
//                         vertical: verticalPadding,
//                       ),
//                     ),
//                   );
//
//                   c.hasFittedMap = true;
//                 });
//               }
//             },
//
//             // onMapReady: () {
//             //   if (!c.hasFittedMap && c.routePoints.isNotEmpty) {
//             //     Future.delayed(const Duration(milliseconds: 300), () {
//             //       final points = [
//             //         pickupLatLng,
//             //         dropLatLng,
//             //         ...c.routePoints,
//             //       ];
//             //
//             //       mapController.fitCamera(
//             //         CameraFit.bounds(
//             //           bounds: LatLngBounds.fromPoints(points),
//             //           padding: const EdgeInsets.all(60),
//             //         ),
//             //       );
//             //
//             //
//             //       c.hasFittedMap = true;
//             //     });
//             //   }
//             // },
//           ),
//
//           children: [
//             TileLayer(
//               urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//               userAgentPackageName: 'com.customer.app',
//               maxNativeZoom: 19,
//               maxZoom: 20,
//             ),
//
//             if (c.routePoints.isNotEmpty)
//               PolylineLayer(
//                 polylines: [
//                   Polyline(
//                     points: c.routePoints,
//                     strokeWidth: 4,
//                     color: Colors.deepPurpleAccent,
//                   ),
//                 ],
//               ),
//
//             MarkerLayer(
//               markers: [
//                 Marker(
//                   point: pickupLatLng,
//                   width: 40,
//                   height: 40,
//                   child: const Icon(
//                     Icons.location_on,
//                     color: Colors.green,
//                     size: 40,
//                   ),
//                 ),
//
//                 Marker(
//                   point: dropLatLng,
//                   width: 40,
//                   height: 40,
//                   child: const Icon(
//                     Icons.location_pin,
//                     color: Colors.red,
//                     size: 40,
//                   ),
//                 ),
//
//                 if (c.routeCenterPoint != null)
//                   Marker(
//                     point: c.routeCenterPoint!,
//                     width: 100,
//                     height: 50,
//                     child: Container(
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         "${c.totalRouteDistanceMiles.toStringAsFixed(2)} miles\n${c.estimatedTimeText}",
//                         textAlign: TextAlign.center,
//                         style: AppTextStyles.small(size: 10),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//
//             /// Driver marker only updates
//             // Obx(() {
//             //   if (c.driverLat.value == 0.0) {
//             //     return const SizedBox();
//             //   }
//             //
//             //   return MarkerLayer(
//             //     markers: [
//             //       Marker(
//             //         point: LatLng(
//             //           c.driverLat.value,
//             //           c.driverLng.value,
//             //         ),
//             //         width: 50,
//             //         height: 50,
//             //         child: const Icon(
//             //           Icons.local_taxi,
//             //           color: Colors.black,
//             //           size: 40,
//             //         ),
//             //       ),
//             //     ],
//             //   );
//             // }),
//           ],
//         );
//       },
//     );
//   }
// }
//
//




import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../../Controller/Home/home-controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // final SwapController c = Get.put(SwapController());
  final c = Get.isRegistered<SwapController>()
      ? Get.find<SwapController>()
      : Get.put(SwapController());


  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SwapController>(
      id: "map",
      builder: (c) {
        if (c.selectedPickUPLat == 0.0 ||
            c.selectedPickUPLon == 0.0 ||
            c.selectedDropLat == 0.0 ||
            c.selectedDropLon == 0.0) {
          return Center(
            child: Text(
              "Select Pickup and Drop to view map",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: AppTextStyles.heading(),
            ),
          );
        }

        // final pickupLatLng =  LatLng(c.selectedPickUPLat, c.selectedPickUPLon);
        // final dropLatLng =  LatLng(c.selectedDropLat, c.selectedDropLon);

        // // Optional: approximate fit bounds
        // if (c.routePoints.isNotEmpty) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     mapController.move(
        //       LatLng(
        //         (c.routePoints.first.latitude +
        //             c.routePoints.last.latitude) /
        //             2,
        //         (c.routePoints.first.longitude +
        //
        //             c.routePoints.last.longitude) /
        //             2,
        //       ),
        //       9, // zoom level, adjust as needed
        //     );
        //   });
        // }

        if (c.isMapReady && c.routePoints.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final bounds = LatLngBounds.fromPoints(c.routePoints);

            mapController.fitCamera(
              CameraFit.bounds(
                bounds: bounds,
                padding: const EdgeInsets.all(60),
              ),
            );
          });
        }

        final pickupLatLng = LatLng(c.selectedPickUPLat, c.selectedPickUPLon);
        final dropLatLng = LatLng(c.selectedDropLat, c.selectedDropLon);

        /// 🔥 AUTO FIT PICKUP + DROP + ROUTE
        if (c.isMapReady) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final List<LatLng> points = [];

            points.add(pickupLatLng);
            points.add(dropLatLng);

            if (c.routePoints.isNotEmpty) {
              points.addAll(c.routePoints);
            }

            final bounds = LatLngBounds.fromPoints(points);

            mapController.fitCamera(
              CameraFit.bounds(
                bounds: bounds,
                padding: const EdgeInsets.all(60),
              ),
            );
            c.hasFittedMap = true; // 🔥 important
          });
        }

        return FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: LatLng(
              (pickupLatLng.latitude + dropLatLng.latitude) / 2,
              (pickupLatLng.longitude + dropLatLng.longitude) / 2,
            ),
            initialZoom: 8,

            onMapReady: () {
              c.isMapReady = true;

              // 🔥 ONLY ONCE
              if (!c.hasFittedMap && c.routePoints.isNotEmpty) {
                Future.delayed(Duration(milliseconds: 300), () {
                  final points = [
                    pickupLatLng,
                    dropLatLng,
                    ...c.routePoints,
                  ];

                  mapController.fitCamera(
                    CameraFit.bounds(
                      bounds: LatLngBounds.fromPoints(points),
                      padding: const EdgeInsets.all(60),
                    ),
                  );

                  c.hasFittedMap = true;
                });
              }

              c.update(["map"]);
            },
          ),


          // mapController: mapController,
          // options: MapOptions(
          //   initialCenter: LatLng(
          //     (pickupLatLng.latitude + dropLatLng.latitude) / 2,
          //     (pickupLatLng.longitude + dropLatLng.longitude) / 2,
          //   ),
          //   initialZoom: 8,
          //   //
          //   onMapReady: () {
          //     c.isMapReady = true;
          //     c.update(["map"]);
          //   },
          //   //
          // ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.customer',
              maxZoom: 19,
            ),

            // Polyline
            if (c.routePoints.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: c.routePoints,
                    strokeWidth: 4,
                    color: Colors.deepPurpleAccent,
                  ),
                ],
              ),

            MarkerLayer(
              markers: [


                ///=======================================================   Pick up Marker
                // Pickup
                Marker(
                  point: pickupLatLng,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.green,
                    size: 40,
                  ),
                ),

                ///                                                                      VIA 1
                if (c.showVia1.value && c.via1Lat != 0.0 && c.via1Lon != 0.0)
                  Marker(
                    point: LatLng(c.via1Lat, c.via1Lon),
                    width: 80,
                    height: 70,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),

                ///                                                       DISTANCE LABEL ON POLYLINE
                if (c.routeCenterPoint != null)
                  Marker(
                    point: c.routeCenterPoint!,
                    width: 100,
                    height: 50,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 4),
                        ],
                      ),
                      child: Text(
                        "${c.totalRouteDistanceMiles.toStringAsFixed(2)} miles "
                        "\n ${c.estimatedTimeText}",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.small(size: 10),
                      ),
                    ),
                  ),

                ///                                                           VIA 2
                if (c.showVia2.value && c.via2Lat != 0.0 && c.via2Lon != 0.0)
                  Marker(
                    point: LatLng(c.via2Lat, c.via2Lon),
                    width: 80,
                    height: 70,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),

                ///                                                            Drop Off marker
                Marker(
                  point: dropLatLng,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),

                // ///=================================================    Driver tracker marker
                // ///
                // if (c.driverLat.value != 0.0 &&
                //     c.driverLng.value != 0.0)
                //   Marker(
                //     point: LatLng(
                //       c.driverLat.value,
                //       c.driverLng.value,
                //     ),
                //     width: 50,
                //     height: 50,
                //     child: const Icon(
                //       Icons.local_taxi,
                //       color: Colors.black,
                //       size: 40,
                //     ),
                //   ),
              ],
            ),

            ///
            Obx(() {
              if (c.driverLat.value == 0.0) return const SizedBox();

              return MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(c.driverLat.value, c.driverLng.value),
                    width: 50,
                    height: 50,
                    child: const Icon(
                      Icons.local_taxi,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ],
              );
            }),
          ],
        );
      },
    );
  }
}
