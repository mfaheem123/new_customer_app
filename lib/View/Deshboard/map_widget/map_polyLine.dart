import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
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

                ///                                                                   VIA 2
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

            Obx(() {
              if (c.driverLat.value == 0.0) return const SizedBox();

              LatLng targetLatLng = LatLng(c.driverLat.value, c.driverLng.value);

              List<LatLng> activeRoute = [];
              if (c.driverRoutePoints.isNotEmpty) {
                activeRoute.addAll(c.driverRoutePoints);
              }
              if (c.routePoints.isNotEmpty) {
                activeRoute.addAll(c.routePoints);
              }

              if (activeRoute.isNotEmpty) {
                targetLatLng = _snapToPolyline(targetLatLng, activeRoute);
              }

              return AnimatedCarMarker(
                driverLocation: targetLatLng,
                routePoints: activeRoute,
                mapController: mapController,
              );
            }),

            ///                                                       DISTANCE LABEL ON TOP RIGHT
            if (c.routeCenterPoint != null)
              Positioned(
                top: 15,
                right: 15,
                child: Container(
                  width: 100,
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
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

            Positioned(
              bottom: 20,
              right: 15,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.blueGrey,
                onPressed: () {
                  if (c.driverLat.value != 0.0 &&
                      c.driverLng.value != 0.0) {

                    mapController.move(
                      LatLng(c.driverLat.value, c.driverLng.value),
                      16,
                    );
                  } else {
                    mapController.fitCamera(
                      CameraFit.bounds(
                        bounds: LatLngBounds.fromPoints([
                          pickupLatLng,
                          dropLatLng,
                        ]),
                        padding: const EdgeInsets.all(70),
                      ),
                    );
                  }
                },
                // onPressed: () {
                //   final points = <LatLng>[
                //     pickupLatLng,
                //     dropLatLng,
                //     ...c.routePoints,
                //   ];
                //
                //   mapController.fitCamera(
                //     CameraFit.bounds(
                //       bounds: LatLngBounds.fromPoints(points),
                //       padding: const EdgeInsets.all(70),
                //     ),
                //   );
                // },
                child: const Icon(
                  Icons.center_focus_strong_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AnimatedCarMarker extends StatefulWidget {
  final LatLng driverLocation;
  final List<LatLng> routePoints;
  final MapController mapController;
  const AnimatedCarMarker({Key? key, required this.driverLocation, required this.routePoints, required this.mapController}) : super(key: key);

  @override
  State<AnimatedCarMarker> createState() => _AnimatedCarMarkerState();
}

class _AnimatedCarMarkerState extends State<AnimatedCarMarker> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<LatLng> _positionAnimation;

  LatLng? _previousAnimatedPosition;
  double _smoothedBearing = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _positionAnimation = PolylineTween([widget.driverLocation]).animate(_controller);
  }

  @override
  void didUpdateWidget(AnimatedCarMarker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.driverLocation != widget.driverLocation) {
      if (oldWidget.driverLocation.latitude == widget.driverLocation.latitude &&
          oldWidget.driverLocation.longitude == widget.driverLocation.longitude) {
        return;
      }

      List<LatLng> path = _getPolylinePath(_positionAnimation.value, widget.driverLocation, widget.routePoints);

      PolylineTween tween = PolylineTween(path);

      // Calculate dynamic duration based on distance
      // A factor of 2000000 roughly equals 2 seconds for a 100-meter movement
      int durationMs = (tween.totalDistance * 2000000).toInt();
      durationMs = durationMs.clamp(300, 4000); // Clamp between 300ms and 4s

      _controller.duration = Duration(milliseconds: durationMs);

      _positionAnimation = tween.animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ));

      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _calculateBearing(LatLng start, LatLng end) {
    final double startLat = start.latitude * math.pi / 180.0;
    final double startLng = start.longitude * math.pi / 180.0;
    final double endLat = end.latitude * math.pi / 180.0;
    final double endLng = end.longitude * math.pi / 180.0;

    final double dLng = endLng - startLng;

    final double y = math.sin(dLng) * math.cos(endLat);
    final double x = math.cos(startLat) * math.sin(endLat) -
        math.sin(startLat) * math.cos(endLat) * math.cos(dLng);

    final double bearing = math.atan2(y, x) * 180.0 / math.pi;
    return (bearing + 360.0) % 360.0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        LatLng currentPos = _positionAnimation.value;

        if (_previousAnimatedPosition != null) {
          final latDiff = currentPos.latitude - _previousAnimatedPosition!.latitude;
          final lngDiff = currentPos.longitude - _previousAnimatedPosition!.longitude;
          final dist = latDiff * latDiff + lngDiff * lngDiff;

          if (dist > 0.0) {
            double targetBearing = _calculateBearing(_previousAnimatedPosition!, currentPos);

            const double imageRotationOffset = 0.0;
            targetBearing = (targetBearing + imageRotationOffset) % 360.0;

            double delta = (targetBearing - _smoothedBearing) % 360.0;
            if (delta > 180.0) delta -= 360.0;
            else if (delta < -180.0) delta += 360.0;

            // Turn speed factor (0.15 gives a quick but smooth steer)
            _smoothedBearing = (_smoothedBearing + delta * 0.15) % 360.0;
          }
        } else {
          _smoothedBearing = 0.0;
        }

        _previousAnimatedPosition = currentPos;

        // 🔥 Map camera follows the driver
        WidgetsBinding.instance.addPostFrameCallback((_) {
          try {
            widget.mapController.move(currentPos, widget.mapController.camera.zoom);
          } catch (_) {}
        });

        return MarkerLayer(
          markers: [
            Marker(
              point: currentPos,
              width: 40,
              height: 40,
              child: Transform.rotate(
                angle: _smoothedBearing * math.pi / 180.0,
                child: Image.asset(
                  'assets/images/car_map.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


class PolylineTween extends Tween<LatLng> {
  final List<LatLng> path;
  final List<double> distances;
  final double totalDistance;

  PolylineTween(this.path)
      : distances = [],
        totalDistance = _calculatePathDistances(path),
        super(
          begin: path.isNotEmpty ? path.first : const LatLng(0, 0),
          end: path.isNotEmpty ? path.last : const LatLng(0, 0)
      ) {
    if (path.isNotEmpty) {
      double currentDist = 0.0;
      distances.add(0.0);
      for (int i = 0; i < path.length - 1; i++) {
        currentDist += _calculateDistance(path[i], path[i + 1]);
        distances.add(currentDist);
      }
    }
  }

  static double _calculatePathDistances(List<LatLng> p) {
    if (p.isEmpty) return 0.0;
    double total = 0.0;
    for (int i = 0; i < p.length - 1; i++) {
      total += _calculateDistance(p[i], p[i + 1]);
    }
    return total;
  }

  static double _calculateDistance(LatLng p1, LatLng p2) {
    final dLat = p1.latitude - p2.latitude;
    final dLng = p1.longitude - p2.longitude;
    return math.sqrt(dLat * dLat + dLng * dLng);
  }

  @override
  LatLng lerp(double t) {
    if (path.isEmpty) return end!;
    if (totalDistance == 0.0) return end!;
    if (t <= 0.0) return path.first;
    if (t >= 1.0) return path.last;

    double targetDistance = totalDistance * t;

    for (int i = 0; i < path.length - 1; i++) {
      if (targetDistance <= distances[i + 1]) {
        double segmentDistance = distances[i + 1] - distances[i];
        double segmentT = (segmentDistance == 0)
            ? 0.0
            : (targetDistance - distances[i]) / segmentDistance;

        return LatLng(
          path[i].latitude + (path[i + 1].latitude - path[i].latitude) * segmentT,
          path[i].longitude + (path[i + 1].longitude - path[i].longitude) * segmentT,
        );
      }
    }
    return path.last;
  }
}

List<LatLng> _getPolylinePath(LatLng start, LatLng end, List<LatLng> polyline) {
  if (polyline.isEmpty) return [start, end];

  int startIndex = _getSegmentIndex(start, polyline);
  int endIndex = _getSegmentIndex(end, polyline);

  if (startIndex == -1 || endIndex == -1) {
    return [start, end];
  }

  List<LatLng> path = [start];

  if (startIndex < endIndex) {
    for (int i = startIndex + 1; i <= endIndex; i++) {
      path.add(polyline[i]);
    }
  } else if (startIndex > endIndex) {
    for (int i = startIndex; i > endIndex; i--) {
      path.add(polyline[i]);
    }
  }

  path.add(end);
  return path;
}

int _getSegmentIndex(LatLng point, List<LatLng> polyline) {
  double minDistance = double.infinity;
  int closestSegment = -1;

  for (int i = 0; i < polyline.length - 1; i++) {
    final projected = _projectPointOnSegment(point, polyline[i], polyline[i + 1]);
    final dist = _calculateDistanceSquared(point, projected);
    if (dist < minDistance) {
      minDistance = dist;
      closestSegment = i;
    }
  }

  // If driver is more than ~100m (0.000001 deg^2) away, don't route along polyline
  if (minDistance > 0.000001) {
    return -1;
  }

  return closestSegment;
}

LatLng _snapToPolyline(LatLng point, List<LatLng> polyline) {
  if (polyline.isEmpty) return point;
  if (polyline.length == 1) return polyline.first;

  double minDistance = double.infinity;
  LatLng closestPoint = point;

  for (int i = 0; i < polyline.length - 1; i++) {
    final start = polyline[i];
    final end = polyline[i + 1];

    final projected = _projectPointOnSegment(point, start, end);
    final distance = _calculateDistanceSquared(point, projected);

    if (distance < minDistance) {
      minDistance = distance;
      closestPoint = projected;
    }
  }

  // If driver is more than ~100m (0.000001 deg^2) away, don't snap
  if (minDistance > 0.000001) {
    return point;
  }

  return closestPoint;
}

LatLng _projectPointOnSegment(LatLng p, LatLng v, LatLng w) {
  final l2 = _calculateDistanceSquared(v, w);
  if (l2 == 0.0) return v;

  final t = ((p.latitude - v.latitude) * (w.latitude - v.latitude) +
      (p.longitude - v.longitude) * (w.longitude - v.longitude)) / l2;

  final tClamped = math.max(0.0, math.min(1.0, t));

  return LatLng(
    v.latitude + tClamped * (w.latitude - v.latitude),
    v.longitude + tClamped * (w.longitude - v.longitude),
  );
}

double _calculateDistanceSquared(LatLng p1, LatLng p2) {
  final dLat = p1.latitude - p2.latitude;
  final dLng = p1.longitude - p2.longitude;
  return dLat * dLat + dLng * dLng;
}

















// import 'package:customer/View/textstyle/apptextstyle.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'dart:math' as math;
// import 'package:latlong2/latlong.dart';
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
//   // final SwapController c = Get.put(SwapController());
//   final c = Get.isRegistered<SwapController>()
//       ? Get.find<SwapController>()
//       : Get.put(SwapController());
//
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
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               style: AppTextStyles.heading(),
//             ),
//           );
//         }
//
//         // final pickupLatLng =  LatLng(c.selectedPickUPLat, c.selectedPickUPLon);
//         // final dropLatLng =  LatLng(c.selectedDropLat, c.selectedDropLon);
//
//         // // Optional: approximate fit bounds
//         // if (c.routePoints.isNotEmpty) {
//         //   WidgetsBinding.instance.addPostFrameCallback((_) {
//         //     mapController.move(
//         //       LatLng(
//         //         (c.routePoints.first.latitude +
//         //             c.routePoints.last.latitude) /
//         //             2,
//         //         (c.routePoints.first.longitude +
//         //
//         //             c.routePoints.last.longitude) /
//         //             2,
//         //       ),
//         //       9, // zoom level, adjust as needed
//         //     );
//         //   });
//         // }
//
//         if (c.isMapReady && c.routePoints.isNotEmpty) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             final bounds = LatLngBounds.fromPoints(c.routePoints);
//
//             mapController.fitCamera(
//               CameraFit.bounds(
//                 bounds: bounds,
//                 padding: const EdgeInsets.all(60),
//               ),
//             );
//           });
//         }
//
//         final pickupLatLng = LatLng(c.selectedPickUPLat, c.selectedPickUPLon);
//         final dropLatLng = LatLng(c.selectedDropLat, c.selectedDropLon);
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
//
//         return FlutterMap(
//           mapController: mapController,
//           options: MapOptions(
//             initialCenter: LatLng(
//               (pickupLatLng.latitude + dropLatLng.latitude) / 2,
//               (pickupLatLng.longitude + dropLatLng.longitude) / 2,
//             ),
//             initialZoom: 8,
//
//             onMapReady: () {
//               c.isMapReady = true;
//
//               // 🔥 ONLY ONCE
//               if (!c.hasFittedMap && c.routePoints.isNotEmpty) {
//                 Future.delayed(Duration(milliseconds: 300), () {
//                   final points = [
//                     pickupLatLng,
//                     dropLatLng,
//                     ...c.routePoints,
//                   ];
//
//                   mapController.fitCamera(
//                     CameraFit.bounds(
//                       bounds: LatLngBounds.fromPoints(points),
//                       padding: const EdgeInsets.all(60),
//                     ),
//                   );
//
//                   c.hasFittedMap = true;
//                 });
//               }
//
//               c.update(["map"]);
//             },
//           ),
//
//
//           // mapController: mapController,
//           // options: MapOptions(
//           //   initialCenter: LatLng(
//           //     (pickupLatLng.latitude + dropLatLng.latitude) / 2,
//           //     (pickupLatLng.longitude + dropLatLng.longitude) / 2,
//           //   ),
//           //   initialZoom: 8,
//           //   //
//           //   onMapReady: () {
//           //     c.isMapReady = true;
//           //     c.update(["map"]);
//           //   },
//           //   //
//           // ),
//           children: [
//             TileLayer(
//               urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//               subdomains: const ['a', 'b', 'c'],
//               userAgentPackageName: 'com.example.customer',
//               maxZoom: 19,
//             ),
//
//             // Polyline
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
//
//
//                 ///=======================================================   Pick up Marker
//                 // Pickup
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
//                 ///                                                                      VIA 1
//                 if (c.showVia1.value && c.via1Lat != 0.0 && c.via1Lon != 0.0)
//                   Marker(
//                     point: LatLng(c.via1Lat, c.via1Lon),
//                     width: 80,
//                     height: 70,
//                     child: const Icon(
//                       Icons.location_pin,
//                       color: Colors.blue,
//                       size: 30,
//                     ),
//                   ),
//
//                 ///                                                                   VIA 2
//                 if (c.showVia2.value && c.via2Lat != 0.0 && c.via2Lon != 0.0)
//                   Marker(
//                     point: LatLng(c.via2Lat, c.via2Lon),
//                     width: 80,
//                     height: 70,
//                     child: const Icon(
//                       Icons.location_pin,
//                       color: Colors.blue,
//                       size: 30,
//                     ),
//                   ),
//
//                 ///                                                            Drop Off marker
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
//                 // ///=================================================    Driver tracker marker
//                 // ///
//                 // if (c.driverLat.value != 0.0 &&
//                 //     c.driverLng.value != 0.0)
//                 //   Marker(
//                 //     point: LatLng(
//                 //       c.driverLat.value,
//                 //       c.driverLng.value,
//                 //     ),
//                 //     width: 50,
//                 //     height: 50,
//                 //     child: const Icon(
//                 //       Icons.local_taxi,
//                 //       color: Colors.black,
//                 //       size: 40,
//                 //     ),
//                 //   ),
//               ],
//             ),
//
//             Obx(() {
//               if (c.driverLat.value == 0.0) return const SizedBox();
//
//               LatLng targetLatLng = LatLng(c.driverLat.value, c.driverLng.value);
//
//               List<LatLng> activeRoute = [];
//               if (c.driverRoutePoints.isNotEmpty) {
//                 activeRoute.addAll(c.driverRoutePoints);
//               }
//               if (c.routePoints.isNotEmpty) {
//                 activeRoute.addAll(c.routePoints);
//               }
//
//               if (activeRoute.isNotEmpty) {
//                  targetLatLng = _snapToPolyline(targetLatLng, activeRoute);
//               }
//
//               return AnimatedCarMarker(
//                 driverLocation: targetLatLng,
//                 routePoints: activeRoute,
//                 mapController: mapController,
//               );
//             }),
//
//             ///                                                       DISTANCE LABEL ON TOP RIGHT
//             if (c.routeCenterPoint != null)
//               Positioned(
//                 top: 15,
//                 right: 15,
//                 child: Container(
//                   width: 100,
//                   height: 50,
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: const [
//                       BoxShadow(color: Colors.black26, blurRadius: 4),
//                     ],
//                   ),
//                   child: Text(
//                     "${c.totalRouteDistanceMiles.toStringAsFixed(2)} miles "
//                     "\n ${c.estimatedTimeText}",
//                     textAlign: TextAlign.center,
//                     style: AppTextStyles.small(size: 10),
//                   ),
//                 ),
//               ),
//
//             Positioned(
//               bottom: 20,
//               right: 15,
//               child: FloatingActionButton(
//                 mini: true,
//                 backgroundColor: Colors.blueGrey,
//                 onPressed: () {
//                   if (c.driverLat.value != 0.0 &&
//                       c.driverLng.value != 0.0) {
//
//                     mapController.move(
//                       LatLng(c.driverLat.value, c.driverLng.value),
//                       18,
//                     );
//                   } else {
//                     mapController.fitCamera(
//                       CameraFit.bounds(
//                         bounds: LatLngBounds.fromPoints([
//                           pickupLatLng,
//                           dropLatLng,
//                         ]),
//                         padding: const EdgeInsets.all(70),
//                       ),
//                     );
//                   }
//                 },
//                 // onPressed: () {
//                 //   final points = <LatLng>[
//                 //     pickupLatLng,
//                 //     dropLatLng,
//                 //     ...c.routePoints,
//                 //   ];
//                 //
//                 //   mapController.fitCamera(
//                 //     CameraFit.bounds(
//                 //       bounds: LatLngBounds.fromPoints(points),
//                 //       padding: const EdgeInsets.all(70),
//                 //     ),
//                 //   );
//                 // },
//                 child: const Icon(
//                   Icons.center_focus_strong_rounded,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class AnimatedCarMarker extends StatefulWidget {
//   final LatLng driverLocation;
//   final List<LatLng> routePoints;
//   final MapController mapController;
//   const AnimatedCarMarker({Key? key, required this.driverLocation, required this.routePoints, required this.mapController}) : super(key: key);
//
//   @override
//   State<AnimatedCarMarker> createState() => _AnimatedCarMarkerState();
// }
//
// class _AnimatedCarMarkerState extends State<AnimatedCarMarker> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<LatLng> _positionAnimation;
//
//   LatLng? _previousAnimatedPosition;
//   double _smoothedBearing = 0.0;
//   int _animFrameCount = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     _positionAnimation = PolylineTween([widget.driverLocation]).animate(_controller);
//   }
//
//   @override
//   void didUpdateWidget(AnimatedCarMarker oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.driverLocation != widget.driverLocation) {
//       if (oldWidget.driverLocation.latitude == widget.driverLocation.latitude &&
//           oldWidget.driverLocation.longitude == widget.driverLocation.longitude) {
//         return;
//       }
//
//       List<LatLng> path = _getPolylinePath(_positionAnimation.value, widget.driverLocation, widget.routePoints);
//
//       PolylineTween tween = PolylineTween(path);
//
//       // Calculate dynamic duration based on distance
//       // Longer duration = smoother movement between API updates
//       int durationMs = (tween.totalDistance * 3000000).toInt();
//       durationMs = durationMs.clamp(500, 5000); // Clamp between 500ms and 5s
//
//       _controller.duration = Duration(milliseconds: durationMs);
//
//       _positionAnimation = tween.animate(CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ));
//
//       _controller.forward(from: 0.0);
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   double _calculateBearing(LatLng start, LatLng end) {
//     final double startLat = start.latitude * math.pi / 180.0;
//     final double startLng = start.longitude * math.pi / 180.0;
//     final double endLat = end.latitude * math.pi / 180.0;
//     final double endLng = end.longitude * math.pi / 180.0;
//
//     final double dLng = endLng - startLng;
//
//     final double y = math.sin(dLng) * math.cos(endLat);
//     final double x = math.cos(startLat) * math.sin(endLat) -
//         math.sin(startLat) * math.cos(endLat) * math.cos(dLng);
//
//     final double bearing = math.atan2(y, x) * 180.0 / math.pi;
//     return (bearing + 360.0) % 360.0;
//   }
//
//   /// 🔥 Google Maps style — get bearing from the actual road segment car is on
//   double _getSegmentBearing(LatLng pos, List<LatLng> polyline) {
//     if (polyline.length < 2) return _smoothedBearing;
//
//     double minDist = double.infinity;
//     int bestSegment = 0;
//
//     // Find closest SEGMENT using projection (not just closest point)
//     for (int i = 0; i < polyline.length - 1; i++) {
//       final projected = _projectPointOnSegment(pos, polyline[i], polyline[i + 1]);
//       final dist = _calculateDistanceSquared(pos, projected);
//       if (dist < minDist) {
//         minDist = dist;
//         bestSegment = i;
//       }
//     }
//
//     return _calculateBearing(polyline[bestSegment], polyline[bestSegment + 1]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         LatLng currentPos = _positionAnimation.value;
//
//         if (_previousAnimatedPosition != null) {
//           final latDiff = currentPos.latitude - _previousAnimatedPosition!.latitude;
//           final lngDiff = currentPos.longitude - _previousAnimatedPosition!.longitude;
//           final dist = latDiff * latDiff + lngDiff * lngDiff;
//
//           if (dist > 0.0) {
//             // 🔥 Car face = road segment direction (instant, no lag)
//             if (widget.routePoints.length >= 2) {
//               _smoothedBearing = _getSegmentBearing(currentPos, widget.routePoints);
//             } else {
//               _smoothedBearing = _calculateBearing(_previousAnimatedPosition!, currentPos);
//             }
//           }
//         } else {
//           _smoothedBearing = 0.0;
//         }
//
//         _previousAnimatedPosition = currentPos;
//
//         // 🔥 Navigation mode — map follows smoothly (only every 10th frame to avoid jitter)
//         if (_controller.isAnimating && (_animFrameCount++ % 10 == 0)) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             try {
//               widget.mapController.moveAndRotate(
//                 currentPos,
//                 widget.mapController.camera.zoom,
//                 -_smoothedBearing,
//               );
//             } catch (_) {}
//           });
//         }
//
//         return MarkerLayer(
//           markers: [
//             Marker(
//               point: currentPos,
//               width: 40,
//               height: 40,
//               child: Transform.rotate(
//                 angle: _smoothedBearing * math.pi / 180.0,
//                 child: Image.asset(
//                   'assets/images/car_map.png',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
//
// class PolylineTween extends Tween<LatLng> {
//   final List<LatLng> path;
//   final List<double> distances;
//   final double totalDistance;
//
//   PolylineTween(this.path)
//       : distances = [],
//         totalDistance = _calculatePathDistances(path),
//         super(
//           begin: path.isNotEmpty ? path.first : const LatLng(0, 0),
//           end: path.isNotEmpty ? path.last : const LatLng(0, 0)
//         ) {
//     if (path.isNotEmpty) {
//       double currentDist = 0.0;
//       distances.add(0.0);
//       for (int i = 0; i < path.length - 1; i++) {
//         currentDist += _calculateDistance(path[i], path[i + 1]);
//         distances.add(currentDist);
//       }
//     }
//   }
//
//   static double _calculatePathDistances(List<LatLng> p) {
//     if (p.isEmpty) return 0.0;
//     double total = 0.0;
//     for (int i = 0; i < p.length - 1; i++) {
//       total += _calculateDistance(p[i], p[i + 1]);
//     }
//     return total;
//   }
//
//   static double _calculateDistance(LatLng p1, LatLng p2) {
//     final dLat = p1.latitude - p2.latitude;
//     final dLng = p1.longitude - p2.longitude;
//     return math.sqrt(dLat * dLat + dLng * dLng);
//   }
//
//   @override
//   LatLng lerp(double t) {
//     if (path.isEmpty) return end!;
//     if (totalDistance == 0.0) return end!;
//     if (t <= 0.0) return path.first;
//     if (t >= 1.0) return path.last;
//
//     double targetDistance = totalDistance * t;
//
//     for (int i = 0; i < path.length - 1; i++) {
//       if (targetDistance <= distances[i + 1]) {
//         double segmentDistance = distances[i + 1] - distances[i];
//         double segmentT = (segmentDistance == 0)
//             ? 0.0
//             : (targetDistance - distances[i]) / segmentDistance;
//
//         return LatLng(
//           path[i].latitude + (path[i + 1].latitude - path[i].latitude) * segmentT,
//           path[i].longitude + (path[i + 1].longitude - path[i].longitude) * segmentT,
//         );
//       }
//     }
//     return path.last;
//   }
// }
//
// List<LatLng> _getPolylinePath(LatLng start, LatLng end, List<LatLng> polyline) {
//   if (polyline.isEmpty) return [start, end];
//
//   int startIndex = _getSegmentIndex(start, polyline);
//   int endIndex = _getSegmentIndex(end, polyline);
//
//   if (startIndex == -1 || endIndex == -1) {
//     return [start, end];
//   }
//
//   List<LatLng> path = [start];
//
//   if (startIndex < endIndex) {
//     for (int i = startIndex + 1; i <= endIndex; i++) {
//       path.add(polyline[i]);
//     }
//   } else if (startIndex > endIndex) {
//     for (int i = startIndex; i > endIndex; i--) {
//       path.add(polyline[i]);
//     }
//   }
//
//   path.add(end);
//   return path;
// }
//
// int _getSegmentIndex(LatLng point, List<LatLng> polyline) {
//   double minDistance = double.infinity;
//   int closestSegment = -1;
//
//   for (int i = 0; i < polyline.length - 1; i++) {
//     final projected = _projectPointOnSegment(point, polyline[i], polyline[i + 1]);
//     final dist = _calculateDistanceSquared(point, projected);
//     if (dist < minDistance) {
//       minDistance = dist;
//       closestSegment = i;
//     }
//   }
//
//   // If driver is more than ~500m away, don't route along polyline
//   if (minDistance > 0.00005) {
//     return -1;
//   }
//
//   return closestSegment;
// }
//
// LatLng _snapToPolyline(LatLng point, List<LatLng> polyline) {
//   if (polyline.isEmpty) return point;
//   if (polyline.length == 1) return polyline.first;
//
//   double minDistance = double.infinity;
//   LatLng closestPoint = point;
//
//   for (int i = 0; i < polyline.length - 1; i++) {
//     final start = polyline[i];
//     final end = polyline[i + 1];
//
//     final projected = _projectPointOnSegment(point, start, end);
//     final distance = _calculateDistanceSquared(point, projected);
//
//     if (distance < minDistance) {
//       minDistance = distance;
//       closestPoint = projected;
//     }
//   }
//
//   // If driver is more than ~500m away, don't snap
//   if (minDistance > 0.00005) {
//     return point;
//   }
//
//   return closestPoint;
// }
//
// LatLng _projectPointOnSegment(LatLng p, LatLng v, LatLng w) {
//   final l2 = _calculateDistanceSquared(v, w);
//   if (l2 == 0.0) return v;
//
//   final t = ((p.latitude - v.latitude) * (w.latitude - v.latitude) +
//              (p.longitude - v.longitude) * (w.longitude - v.longitude)) / l2;
//
//   final tClamped = math.max(0.0, math.min(1.0, t));
//
//   return LatLng(
//     v.latitude + tClamped * (w.latitude - v.latitude),
//     v.longitude + tClamped * (w.longitude - v.longitude),
//   );
// }
//
// double _calculateDistanceSquared(LatLng p1, LatLng p2) {
//   final dLat = p1.latitude - p2.latitude;
//   final dLng = p1.longitude - p2.longitude;
//   return dLat * dLat + dLng * dLng;
// }
//
