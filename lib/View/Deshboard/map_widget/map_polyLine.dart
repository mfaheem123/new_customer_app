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

        final pickupLatLng = LatLng(c.selectedPickUPLat, c.selectedPickUPLon);
        final dropLatLng = LatLng(c.selectedDropLat, c.selectedDropLon);

        /// 🔥 AUTO FIT PICKUP + DROP + ROUTE ONCE ON INIT
        if (c.isMapReady && !c.hasFittedMap && c.routePoints.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final List<LatLng> points = [
              pickupLatLng,
              dropLatLng,
              ...c.routePoints,
            ];

            final bounds = LatLngBounds.fromPoints(points);

            mapController.fitCamera(
              CameraFit.bounds(
                bounds: bounds,
                padding: const EdgeInsets.all(60),
              ),
            );
            c.hasFittedMap = true;
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

              if (!c.hasFittedMap && c.routePoints.isNotEmpty) {
                Future.delayed(const Duration(milliseconds: 300), () {
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
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.customer',
              maxZoom: 19,
            ),

            // Polyline
            // Obx(() {
            //   List<LatLng> pointsToShow;
            //   if (c.driverToDropoffPolyline.isNotEmpty) {
            //     pointsToShow = c.driverToDropoffPolyline.toList();
            //   } else {
            //     pointsToShow = c.routePoints;
            //   }
            //
            //   if (pointsToShow.isEmpty) return const SizedBox();
            //
            //   return PolylineLayer(
            //     polylines: [
            //       Polyline(
            //         points: pointsToShow,
            //         strokeWidth: 4,
            //         color: Colors.deepPurpleAccent,
            //       ),
            //     ],
            //   );
            // }),

            Obx(() {
              List<LatLng> pointsToShow;
              if (c.driverToDropoffPolyline.isNotEmpty) {
                pointsToShow = c.driverToDropoffPolyline.toList();
              } else {
                pointsToShow = c.routePoints;
              }

              if (pointsToShow.length < 2) {
                return const SizedBox();
              }

              return PolylineLayer(
                polylines: [
                  Polyline(
                    points: pointsToShow,
                    strokeWidth: 4,
                    color: Colors.deepPurpleAccent,
                  ),
                ],
              );
            }),

            MarkerLayer(
              markers: [
                ///=======================================================   Pick up Marker
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
              ],
            ),

            /// 🔥 DRIVER → PICKUP POLYLINE (Orange, progressive removal)
            Obx(() {
              if (c.hasReachedPickup.value || c.driverToPickupPolyline.length < 2) return const SizedBox();

              return PolylineLayer(
                polylines: [
                  Polyline(
                    points: List<LatLng>.from(c.driverToPickupPolyline),
                    strokeWidth: 5,
                    color: Colors.orange,
                  ),
                ],
              );
            }),

            Obx(() {
              if (c.driverLat.value == 0.0 || c.driverLng.value == 0.0) return const SizedBox();

              LatLng rawTarget = LatLng(c.driverLat.value, c.driverLng.value);

              // 🔥 Phase 1 (Going to Pickup): use Orange route ONLY
              // 🔥 Phase 2 (Trip to Drop-off): use Purple route ONLY
              List<LatLng> activeRoute = [];
              if (!c.hasReachedPickup.value) {
                if (c.driverRoutePoints.isNotEmpty) {
                  activeRoute = c.driverRoutePoints;
                } else if (c.driverToPickupPolyline.isNotEmpty) {
                  activeRoute = c.driverToPickupPolyline.toList();
                }
              } else if (c.fullTripRoutePoints.isNotEmpty) {
                activeRoute = c.fullTripRoutePoints;
              } else if (c.routePoints.isNotEmpty) {
                activeRoute = c.routePoints;
              }

              LatLng targetLatLng = rawTarget;
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
                    "${c.totalRouteDistanceMiles.toStringAsFixed(2)} miles \n${c.estimatedTimeText}",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.small(size: 10),
                  ),
                ),
              ),

            Positioned(
              bottom: 20,
              right: 15,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🚗 Center on Driver Button
                  if (c.driverLat.value != 0.0 && c.driverLng.value != 0.0)
                    FloatingActionButton(
                      heroTag: "btn_driver_center",
                      mini: true,
                      backgroundColor: Colors.white,
                      elevation: 3,
                      onPressed: () {
                        mapController.move(
                          LatLng(c.driverLat.value, c.driverLng.value),
                          17,
                        );
                      },
                      child: const Icon(
                        Icons.navigation_rounded,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ),
                  if (c.driverLat.value != 0.0 && c.driverLng.value != 0.0)
                    const SizedBox(height: 8),
                  // 🗺️ Fit Route Bounds Button
                  FloatingActionButton(
                    heroTag: "btn_fit_route",
                    mini: true,
                    backgroundColor: Colors.white,
                    elevation: 3,
                    onPressed: () {
                      final List<LatLng> points = [pickupLatLng, dropLatLng];
                      if (c.routePoints.isNotEmpty) {
                        points.addAll(c.routePoints);
                      }
                      if (c.driverLat.value != 0.0 && c.driverLng.value != 0.0) {
                        points.add(LatLng(c.driverLat.value, c.driverLng.value));
                      }
                      mapController.fitCamera(
                        CameraFit.bounds(
                          bounds: LatLngBounds.fromPoints(points),
                          padding: const EdgeInsets.all(60),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.center_focus_strong_rounded,
                      color: Colors.black87,
                      size: 20,
                    ),
                  ),
                ],
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

    _controller.addListener(() {
      final currentPos = _positionAnimation.value;
      if (Get.isRegistered<SwapController>()) {
        final ctrl = Get.find<SwapController>();
        // Update last animated position so GPS-level trim doesn't jump ahead
        ctrl.lastAnimatedCarPos = currentPos;
        // Trim polyline to match animated car position every frame
        ctrl.trimDriverPolyline(currentPos);
      }
    });

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

      // Start from current animated position (not the raw GPS target)
      LatLng startPos = _positionAnimation.value;

      if (widget.routePoints.isNotEmpty) {
        startPos = _snapToPolyline(startPos, widget.routePoints);
      }

      List<LatLng> path = _getPolylinePath(startPos, widget.driverLocation, widget.routePoints);

      PolylineTween tween = PolylineTween(path);

      int durationMs = (tween.totalDistance * 2000000).toInt();
      durationMs = durationMs.clamp(300, 4000);

      _controller.duration = Duration(milliseconds: durationMs);

      _positionAnimation = tween.animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ));

      // Always start the animation — this triggers the addListener which calls trimDriverPolyline
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
            double delta = (targetBearing - _smoothedBearing) % 360.0;
            if (delta > 180.0) delta -= 360.0;
            else if (delta < -180.0) delta += 360.0;

            _smoothedBearing = (_smoothedBearing + delta * 0.15) % 360.0;
          }
        } else {
          _smoothedBearing = 0.0;
        }

        _previousAnimatedPosition = currentPos;

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
  if (polyline.length == 1) return [start, polyline.first, end];

  int startIndex = _getSegmentIndex(start, polyline);
  int endIndex = _getSegmentIndex(end, polyline);

  LatLng snappedStart = _snapToPolyline(start, polyline);
  LatLng snappedEnd = _snapToPolyline(end, polyline);

  List<LatLng> path = [snappedStart];

  if (startIndex < endIndex) {
    for (int i = startIndex + 1; i <= endIndex; i++) {
      path.add(polyline[i]);
    }
  } else if (startIndex > endIndex) {
    for (int i = startIndex; i > endIndex; i--) {
      path.add(polyline[i]);
    }
  }

  path.add(snappedEnd);
  return path;
}

int _getSegmentIndex(LatLng point, List<LatLng> polyline) {
  if (polyline.length < 2) return 0;
  double minDistance = double.infinity;
  int closestSegment = 0;

  for (int i = 0; i < polyline.length - 1; i++) {
    final projected = _projectPointOnSegment(point, polyline[i], polyline[i + 1]);
    final dist = _calculateDistanceSquared(point, projected);
    if (dist < minDistance) {
      minDistance = dist;
      closestSegment = i;
    }
  }

  return closestSegment;
}

LatLng _snapToPolyline(LatLng point, List<LatLng> polyline) {
  if (polyline.isEmpty) return point;
  if (polyline.length == 1) return polyline.first;

  double minDistance = double.infinity;
  LatLng closestPoint = polyline.first;

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