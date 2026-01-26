import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../../Controller/Home/home-controller.dart';
import '../../Widgets/color.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final SwapController c = Get.put(SwapController());

  final MapController mapController = MapController();





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Pickup → Drop Map")),

      body: Column(
        children: [
          // ======= Map =======
          Expanded(
            child: GetBuilder<SwapController>(
              builder: (c) {
                if (c.selectedPickUPLat == 0.0 ||
                    c.selectedPickUPLon == 0.0 ||
                    c.selectedDropLat == 0.0 ||
                    c.selectedDropLon == 0.0) {
                  return const Center(
                    child: Text("Select Pickup and Drop to view map"),
                  );
                }

                final pickupLatLng =  LatLng(c.selectedPickUPLat, c.selectedPickUPLon);
                final dropLatLng =  LatLng(c.selectedDropLat, c.selectedDropLon);
                //
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



                return FlutterMap(

                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: LatLng(
                        (pickupLatLng.latitude + dropLatLng.latitude) / 2,
                        (pickupLatLng.longitude + dropLatLng.longitude) / 2),
                    initialZoom: 13,
                    //
                    onMapReady: () {
                      c.isMapReady = true;
                      c.update(); // rebuild GetBuilder
                    },
                    //
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'com.example.customer',
                      maxZoom: 19,
                    ),

                    // TileLayer(
                    //   urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    //   userAgentPackageName: 'com.example.customer',
                    // ),

                    // Polyline
                    if (c.routePoints.isNotEmpty)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: c.routePoints,
                            strokeWidth: 4,
                            color: Colors.blue,
                          ),
                        ],
                      ),

                    // Markers
                    MarkerLayer(
                      markers: [
                        // Pickup
                        Marker(
                          point: pickupLatLng,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_on, color: Colors.green, size: 40,
                          ),
                        ),

                        // VIA 1
                        if (c.showVia1.value && c.via1Lat != 0.0  && c.via1Lon != 0.0)
                          Marker(
                            point: LatLng(c.via1Lat, c.via1Lon),
                            width: 80,
                            height: 70,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Card(
                                  color: Colors.black,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    child: Text(
                                      "Via 1",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 0.5),
                                const Icon(Icons.location_pin, color: Colors.blue, size:30),
                              ],
                            ),
                          ),
                        // VIA 2
                        if (c.showVia2.value && c.via2Lat != 0.0)
                          Marker(
                            point: LatLng(c.via2Lat, c.via2Lon),
                            width: 80,
                            height: 70,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Card(
                                  color: Colors.black,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    child: Text(
                                      "Via 2",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 0.5),
                                const Icon(Icons.location_pin, color: Colors.blue, size: 30),
                              ],
                            ),
                          ),

                        // // VIA 1
                        // if (c.via1Lat != 0.0)
                        //   Marker(
                        //     point: LatLng(c.via1Lat, c.via1Lon),
                        //     width: 80,
                        //     height: 70,
                        //     child: Column(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         Card(
                        //           color: Colors.black,
                        //           elevation: 3,
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(6),
                        //           ),
                        //           child: const Padding(
                        //             padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        //             child: Text(
                        //               "Via 1",
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 11,
                        //                 fontWeight: FontWeight.w600,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         const SizedBox(height: 0.5),
                        //         const Icon(Icons.location_pin, color: Colors.blue, size:30),
                        //       ],
                        //     ),
                        //   ),
                        //
                        //
                        // // VIA 2
                        // if (c.via2Lat != 0.0)
                        //   Marker(
                        //     point: LatLng(c.via2Lat, c.via2Lon),
                        //     width: 80,
                        //     height: 70,
                        //     child: Column(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         Card(
                        //           color: Colors.black,
                        //           elevation: 3,
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(6),
                        //           ),
                        //           child: const Padding(
                        //             padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        //             child: Text(
                        //               "Via 2",
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 11,
                        //                 fontWeight: FontWeight.w600,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         const SizedBox(height: 0.5),
                        //         const Icon(Icons.location_pin, color: Colors.blue, size: 30),
                        //       ],
                        //     ),
                        //   ),


                        // Drop
                        Marker(
                          point: dropLatLng,
                          width: 40,
                          height: 40,
                          child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                        ),
                      ],
                    ),


                    // MarkerLayer(
                    //   markers: [
                    //     Marker(
                    //       point: pickupLatLng,
                    //       width: 40,
                    //       height: 40,
                    //       child: const Icon(
                    //         Icons.location_on,
                    //         color: Colors.green,
                    //         size: 40,
                    //       ),
                    //     ),
                    //     Marker(
                    //       point: dropLatLng,
                    //       width: 40,
                    //       height: 40,
                    //       child: const Icon(
                    //         Icons.location_on,
                    //         color: Colors.red,
                    //         size: 40,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                );
              },
            ),
          ),
        ],
      ),

      // Bottom info bar
      // bottomNavigationBar: GetBuilder<SwapController>(
      //   builder: (c) {
      //     return Padding(
      //       padding: const EdgeInsets.all(8),
      //       child: Card(
      //         child: Padding(
      //           padding: const EdgeInsets.all(12),
      //           child: Text(
      //             "${c.pickUp.text} → ${c.dropOff.text}",
      //             textAlign: TextAlign.center,
      //             style: const TextStyle(
      //               fontWeight: FontWeight.bold,
      //               fontSize: 16,
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}










