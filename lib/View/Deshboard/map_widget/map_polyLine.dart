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
            maxZoom: 16.7,
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

            /// Polyline
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
///
            // Obx(() {
            //   List<LatLng> pointsToShow;
            //   if (c.driverToDropoffPolyline.isNotEmpty) {
            //     pointsToShow = c.driverToDropoffPolyline.toList();
            //   } else {
            //     pointsToShow = c.routePoints;
            //   }
            //
            //   if (pointsToShow.length < 2) {
            //     return const SizedBox();
            //   }
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
/// Purple polyline: Phase 1 + Phase 2 dono mein show ho
            Obx(() {
              // Phase 2 mein driverToDropoffPolyline use karo
              // Phase 1 mein routePoints use karo (pickup→drop static route)
              final List<LatLng> points = c.hasReachedPickup.value
                  ? c.driverToDropoffPolyline.toList()
                  : (c.routePoints.length >= 2 ? c.routePoints.toList() : []);

              if (points.length < 2) {
                return const SizedBox();
              }

              return PolylineLayer(
                polylines: [
                  Polyline(
                    points: points,
                    strokeWidth: 5,
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
              if (c.hasReachedPickup.value) {
                return const SizedBox();
              }

              final List<LatLng> points =
              c.driverToPickupPolyline.toList();

              if (points.length < 2) {
                return const SizedBox();
              }

              return PolylineLayer(
                polylines: [
                  Polyline(
                    points: points,
                    strokeWidth: 5,
                    color: Colors.orange,
                  ),
                ],
              );
            }),
            // Obx(() {
            //   if (c.hasReachedPickup.value || c.driverToPickupPolyline.length < 2) return const SizedBox();
            //
            //   return PolylineLayer(
            //     polylines: [
            //       Polyline(
            //         points: List<LatLng>.from(c.driverToPickupPolyline),
            //         strokeWidth: 5,
            //         color: Colors.orange,
            //       ),
            //     ],
            //   );
            // }),
///                          car wala obs
            // Obx(() {
            //   if (c.driverLat.value == 0.0 || c.driverLng.value == 0.0) return const SizedBox();
            //
            //   LatLng rawTarget = LatLng(c.driverLat.value, c.driverLng.value);
            //
            //   // 🔥 Phase 1 (Going to Pickup): use Orange route ONLY
            //   // 🔥 Phase 2 (Trip to Drop-off): use Purple route ONLY
            //   List<LatLng> activeRoute = [];
            //   if (!c.hasReachedPickup.value) {
            //     if (c.driverRoutePoints.isNotEmpty) {
            //       activeRoute = c.driverRoutePoints;
            //     } else if (c.driverToPickupPolyline.isNotEmpty) {
            //       activeRoute = c.driverToPickupPolyline.toList();
            //     }
            //   } else if (c.fullTripRoutePoints.isNotEmpty) {
            //     activeRoute = c.fullTripRoutePoints;
            //   } else if (c.routePoints.isNotEmpty) {
            //     activeRoute = c.routePoints;
            //   }
            //
            //   LatLng targetLatLng = rawTarget;
            //   if (activeRoute.isNotEmpty) {
            //     targetLatLng = _snapToPolyline(targetLatLng, activeRoute);
            //   }
            //
            //   return AnimatedCarMarker(
            //     driverLocation: targetLatLng,
            //     routePoints: activeRoute,
            //     mapController: mapController,
            //   );
            // }),

            Obx(() {
              // ==========================================================
              // DRIVER GPS VALIDATION
              // ==========================================================

              if (c.driverLat.value == 0.0 ||
                  c.driverLng.value == 0.0) {
                return const SizedBox();
              }

              final LatLng rawDriverPosition = LatLng(
                c.driverLat.value,
                c.driverLng.value,
              );

              // ==========================================================
              // ACTIVE ROUTE
              // ==========================================================

              List<LatLng> activeRoute = [];

              // ----------------------------------------------------------
              // PHASE 1: DRIVER -> PICKUP
              // ----------------------------------------------------------

              if (!c.hasReachedPickup.value) {
                if (c.driverRoutePoints.length >= 2) {
                  activeRoute =
                      c.driverRoutePoints.toList();
                } else if (c.driverToPickupPolyline.length >= 2) {
                  activeRoute =
                      c.driverToPickupPolyline.toList();
                }
              }

              // ----------------------------------------------------------
              // PHASE 2: PICKUP -> DROP
              // ----------------------------------------------------------

              else {
                if (c.fullTripRoutePoints.length >= 2) {
                  activeRoute =
                      c.fullTripRoutePoints.toList();
                } else if (c.routePoints.length >= 2) {
                  activeRoute =
                      c.routePoints.toList();
                }
              }

              // ==========================================================
              // SNAP DRIVER GPS TO ROAD
              // ==========================================================

              LatLng targetPosition =
                  rawDriverPosition;

              if (activeRoute.length >= 2) {
                targetPosition =
                    _snapToPolyline(
                      rawDriverPosition,
                      activeRoute,
                    );
              }

              // ==========================================================
              // ANIMATED CAR
              // ==========================================================

              return AnimatedCarMarker(
                driverLocation: targetPosition,
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
                        // 🚗 Car ki actual snapped position pe focus karo
                        LatLng rawTarget = LatLng(c.driverLat.value, c.driverLng.value);

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

                        LatLng carPos = rawTarget;
                        if (activeRoute.isNotEmpty) {
                          carPos = _snapToPolyline(rawTarget, activeRoute);
                        }

                        mapController.move(carPos, 16);
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

  const AnimatedCarMarker({
    Key? key,
    required this.driverLocation,
    required this.routePoints,
    required this.mapController,
  }) : super(key: key);

  @override
  State<AnimatedCarMarker> createState() => _AnimatedCarMarkerState();
}

class _AnimatedCarMarkerState extends State<AnimatedCarMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<LatLng> _positionAnimation;

  // ============================================================
  // 🔥 MAIN SETTING
  //
  // Car ki visual speed yahan set hogi.
  //
  // 8 m/s = 28.8 km/h
  // 9 m/s = 32.4 km/h
  // 10 m/s = 36.0 km/h
  //
  // Driver real life mein kitni bhi speed se chale,
  // map par car isi visual speed ke around move karegi.
  // ============================================================

  static const double visualSpeedMetersPerSecond = 18.0;

  // ============================================================
  // GPS update interval
  //
  // Tumhare backend se har 5 sec baad LatLng aa rahi hai.
  // ============================================================

  static const int gpsIntervalMs = 5000;

  // ============================================================
  // GPS tolerance
  //
  // GPS mein bohat chota difference aa sakta hai.
  // Itna difference movement nahi maana jayega.
  // ============================================================

  static const double gpsMovementToleranceMeters = 2.0;

  // ============================================================
  // State
  // ============================================================

  LatLng? _previousAnimatedPosition;

  LatLng? _lastGpsPosition;

  double _smoothedBearing = 0.0;

  bool _driverMoving = false;

  @override
  void initState() {
    super.initState();

    // ==========================================================
    // Animation controller
    // ==========================================================

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // ==========================================================
    // Initial position
    // ==========================================================

    _lastGpsPosition = widget.driverLocation;

    _positionAnimation = PolylineTween(
      [widget.driverLocation],
    ).animate(_controller);

    // ==========================================================
    // Every animation frame
    // ==========================================================

    _controller.addListener(() {
      final currentPos = _positionAnimation.value;

      if (Get.isRegistered<SwapController>()) {
        final ctrl = Get.find<SwapController>();

        // Current animated position controller mein save karo
        ctrl.lastAnimatedCarPos = currentPos;

        // Purple/Orange polyline ko car ke current position tak trim karo
        ctrl.trimDriverPolyline(currentPos);
      }
    });
  }

  // ============================================================
  // DID UPDATE WIDGET
  //
  // Jab API se new driver LatLng aati hai,
  // parent widget update hota hai aur ye method call hota hai.
  // ============================================================

  @override
  void didUpdateWidget(AnimatedCarMarker oldWidget) {
    super.didUpdateWidget(oldWidget);

    final LatLng newGpsLocation = widget.driverLocation;

    // ==========================================================
    // First check:
    // Kya new GPS actually different hai?
    // ==========================================================

    final LatLng? previousGps = _lastGpsPosition;

    if (previousGps != null) {
      final double gpsDistance = _distanceInMeters(
        previousGps,
        newGpsLocation,
      );

      debugPrint(
        "🚗 GPS UPDATE\n"
            "Previous: ${previousGps.latitude}, ${previousGps.longitude}\n"
            "New: ${newGpsLocation.latitude}, ${newGpsLocation.longitude}\n"
            "Distance: ${gpsDistance.toStringAsFixed(2)} meters",
      );

      // ========================================================
      // Driver same location par hai
      // ========================================================

      if (gpsDistance < gpsMovementToleranceMeters) {
        debugPrint(
          "🛑 DRIVER STOPPED / NO SIGNIFICANT MOVEMENT",
        );

        _driverMoving = false;

        // Animation ko current position par stop karo
        _controller.stop();

        // Last GPS update save karo
        _lastGpsPosition = newGpsLocation;

        return;
      }

      // ========================================================
      // Driver moved
      // ========================================================

      _driverMoving = true;

      debugPrint(
        "🚗 DRIVER MOVING → "
            "${gpsDistance.toStringAsFixed(2)} meters",
      );
    }

    // ==========================================================
    // Last GPS position update
    // ==========================================================

    _lastGpsPosition = newGpsLocation;

    // ==========================================================
    // IMPORTANT:
    //
    // Animation ke beech mein agar new GPS aa gayi hai,
    // to RAW previous GPS se start nahi karna.
    //
    // Current animated car position se continue karna hai.
    // ==========================================================

    LatLng startPosition;

    if (_controller.isAnimating) {
      startPosition = _positionAnimation.value;
    } else {
      startPosition = _positionAnimation.value;

      // Agar animation stopped thi aur valid previous position hai
      if (startPosition.latitude == 0.0 &&
          startPosition.longitude == 0.0) {
        startPosition = oldWidget.driverLocation;
      }
    }

    // ==========================================================
    // Route par current position snap karo
    // ==========================================================

    if (widget.routePoints.length >= 2) {
      startPosition = _snapToPolyline(
        startPosition,
        widget.routePoints,
      );
    }

    // ==========================================================
    // New GPS target bhi route par snap hoga
    // ==========================================================

    LatLng targetPosition = newGpsLocation;

    if (widget.routePoints.length >= 2) {
      targetPosition = _snapToPolyline(
        newGpsLocation,
        widget.routePoints,
      );
    }

    // ==========================================================
    // Current animated position → new GPS position
    // ==========================================================

    final List<LatLng> path = _getPolylinePath(
      startPosition,
      targetPosition,
      widget.routePoints,
    );

    if (path.length < 2) {
      debugPrint(
        "⚠️ Animation path invalid",
      );
      return;
    }

    final PolylineTween tween = PolylineTween(path);

    // ==========================================================
    // Calculate actual distance in meters
    // ==========================================================

    final double distanceMeters =
    _calculatePathDistanceMeters(path);

    if (distanceMeters <= 0.5) {
      return;
    }

    // ==========================================================
    // 🔥 FIXED VISUAL SPEED
    //
    // Duration = Distance / Fixed Speed
    //
    // Example:
    //
    // 40 meters / 8 m/s = 5 sec
    // 80 meters / 8 m/s = 10 sec
    // 120 meters / 8 m/s = 15 sec
    //
    // Is tarah distance change hone ke bawajood
    // visual speed same rahegi.
    // ==========================================================

    int durationMs =
    ((distanceMeters / visualSpeedMetersPerSecond) * 1000)
        .round();

    // ==========================================================
    // IMPORTANT:
    //
    // Agar target bohat close ho to animation 5 sec se kam ho sakti
    // hai. Lekin hum minimum 5 sec rakh rahe hain taa-ke
    // 5-second GPS polling ke darmiyan car jaldi target par
    // pohanch kar stop na kare.
    //
    // Agar tumhari GPS locations normally kaafi door hoti hain,
    // to actual calculated duration use hoga.
    // ==========================================================

    durationMs = math.max(
      durationMs,
      gpsIntervalMs + 300,
    );

    // Maximum duration ko limit nahi kar rahe.
    //
    // Pehle tumhare code mein:
    //
    // clamp(300, 4000)
    //
    // tha.
    //
    // Wo remove kiya gaya hai because large distance ko
    // unnecessarily fast nahi karna.
    // ==========================================================

    _controller.duration = Duration(
      milliseconds: durationMs,
    );

    debugPrint(
      "🎬 CAR ANIMATION\n"
          "Distance: ${distanceMeters.toStringAsFixed(2)} m\n"
          "Visual Speed: $visualSpeedMetersPerSecond m/s\n"
          "Duration: ${durationMs} ms",
    );

    // ==========================================================
    // New animation
    //
    // Current animated position se start hogi.
    // ==========================================================

    _positionAnimation = tween.animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    // ==========================================================
    // Continue animation
    // ==========================================================

    _controller.forward(from: 0.0);
  }

  // ============================================================
  // CHECK DRIVER MOVEMENT
  // ============================================================

  bool _isDriverMoving(
      LatLng oldPosition,
      LatLng newPosition,
      ) {
    final distance = _distanceInMeters(
      oldPosition,
      newPosition,
    );

    return distance >= gpsMovementToleranceMeters;
  }

  // ============================================================
  // DISTANCE IN METERS
  // Haversine formula
  // ============================================================

  double _distanceInMeters(
      LatLng a,
      LatLng b,
      ) {
    const double earthRadius = 6371000.0;

    final double lat1 =
        a.latitude * math.pi / 180.0;

    final double lat2 =
        b.latitude * math.pi / 180.0;

    final double deltaLat =
        (b.latitude - a.latitude) *
            math.pi /
            180.0;

    final double deltaLng =
        (b.longitude - a.longitude) *
            math.pi /
            180.0;

    final double h =
        math.sin(deltaLat / 2) *
            math.sin(deltaLat / 2) +
            math.cos(lat1) *
                math.cos(lat2) *
                math.sin(deltaLng / 2) *
                math.sin(deltaLng / 2);

    final double c =
        2 *
            math.atan2(
              math.sqrt(h),
              math.sqrt(1 - h),
            );

    return earthRadius * c;
  }

  // ============================================================
  // TOTAL PATH DISTANCE IN METERS
  // ============================================================

  double _calculatePathDistanceMeters(
      List<LatLng> path,
      ) {
    if (path.length < 2) {
      return 0.0;
    }

    double totalDistance = 0.0;

    for (int i = 0; i < path.length - 1; i++) {
      totalDistance += _distanceInMeters(
        path[i],
        path[i + 1],
      );
    }

    return totalDistance;
  }

  // ============================================================
  // BEARING
  // ============================================================

  double _calculateBearing(
      LatLng start,
      LatLng end,
      ) {
    final double startLat =
        start.latitude * math.pi / 180.0;

    final double startLng =
        start.longitude * math.pi / 180.0;

    final double endLat =
        end.latitude * math.pi / 180.0;

    final double endLng =
        end.longitude * math.pi / 180.0;

    final double dLng =
        endLng - startLng;

    final double y =
        math.sin(dLng) *
            math.cos(endLat);

    final double x =
        math.cos(startLat) *
            math.sin(endLat) -
            math.sin(startLat) *
                math.cos(endLat) *
                math.cos(dLng);

    final double bearing =
        math.atan2(y, x) *
            180.0 /
            math.pi;

    return (bearing + 360.0) % 360.0;
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final LatLng currentPosition =
            _positionAnimation.value;

        // ======================================================
        // SMOOTH BEARING
        // ======================================================

        if (_previousAnimatedPosition != null) {
          final double latDiff =
              currentPosition.latitude -
                  _previousAnimatedPosition!.latitude;

          final double lngDiff =
              currentPosition.longitude -
                  _previousAnimatedPosition!.longitude;

          final double movement =
              latDiff * latDiff +
                  lngDiff * lngDiff;

          if (movement > 0.000000000001) {
            final double targetBearing =
            _calculateBearing(
              _previousAnimatedPosition!,
              currentPosition,
            );

            double delta =
                (targetBearing - _smoothedBearing) %
                    360.0;

            if (delta > 180.0) {
              delta -= 360.0;
            } else if (delta < -180.0) {
              delta += 360.0;
            }

            // =================================================
            // Smooth turning
            // =================================================

            _smoothedBearing =
                (_smoothedBearing +
                    delta * 0.15) %
                    360.0;
          }
        }

        _previousAnimatedPosition =
            currentPosition;

        // ======================================================
        // CAR MARKER
        // ======================================================

        return MarkerLayer(
          markers: [
            Marker(
              point: currentPosition,
              width: 40,
              height: 40,
              child: Transform.rotate(
                angle:
                _smoothedBearing *
                    math.pi /
                    180.0,
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


// ============================================================================
// POLYLINE TWEEN
// ============================================================================

class PolylineTween extends Tween<LatLng> {
  final List<LatLng> path;
  final List<double> distances;
  final double totalDistance;

  PolylineTween(this.path)
      : distances = [],
        totalDistance =
        _calculatePathDistances(path),
        super(
        begin: path.isNotEmpty
            ? path.first
            : const LatLng(0, 0),
        end: path.isNotEmpty
            ? path.last
            : const LatLng(0, 0),
      ) {
    if (path.isNotEmpty) {
      double currentDistance = 0.0;

      distances.add(0.0);

      for (int i = 0;
      i < path.length - 1;
      i++) {
        currentDistance +=
            _calculateDistance(
              path[i],
              path[i + 1],
            );

        distances.add(currentDistance);
      }
    }
  }

  static double _calculatePathDistances(
      List<LatLng> points,
      ) {
    if (points.length < 2) {
      return 0.0;
    }

    double total = 0.0;

    for (int i = 0;
    i < points.length - 1;
    i++) {
      total += _calculateDistance(
        points[i],
        points[i + 1],
      );
    }

    return total;
  }

  static double _calculateDistance(
      LatLng p1,
      LatLng p2,
      ) {
    final double dLat =
        p1.latitude - p2.latitude;

    final double dLng =
        p1.longitude - p2.longitude;

    return math.sqrt(
      dLat * dLat +
          dLng * dLng,
    );
  }

  @override
  LatLng lerp(double t) {
    if (path.isEmpty) {
      return end!;
    }

    if (totalDistance == 0.0) {
      return end!;
    }

    if (t <= 0.0) {
      return path.first;
    }

    if (t >= 1.0) {
      return path.last;
    }

    final double targetDistance =
        totalDistance * t;

    for (int i = 0;
    i < path.length - 1;
    i++) {
      if (targetDistance <=
          distances[i + 1]) {
        final double segmentDistance =
            distances[i + 1] -
                distances[i];

        final double segmentT =
        segmentDistance == 0.0
            ? 0.0
            : (targetDistance -
            distances[i]) /
            segmentDistance;

        return LatLng(
          path[i].latitude +
              (path[i + 1].latitude -
                  path[i].latitude) *
                  segmentT,
          path[i].longitude +
              (path[i + 1].longitude -
                  path[i].longitude) *
                  segmentT,
        );
      }
    }

    return path.last;
  }
}


// ============================================================================
// GET POLYLINE PATH
// ============================================================================

List<LatLng> _getPolylinePath(
    LatLng start,
    LatLng end,
    List<LatLng> polyline,
    ) {
  // ==========================================================
  // No route
  // ==========================================================

  if (polyline.isEmpty) {
    return [
      start,
      end,
    ];
  }

  // ==========================================================
  // One route point
  // ==========================================================

  if (polyline.length == 1) {
    return [
      start,
      polyline.first,
      end,
    ];
  }

  // ==========================================================
  // Find nearest route segments
  // ==========================================================

  final int startIndex =
  _getSegmentIndex(
    start,
    polyline,
  );

  final int endIndex =
  _getSegmentIndex(
    end,
    polyline,
  );

  // ==========================================================
  // Snap start/end to route
  // ==========================================================

  final LatLng snappedStart =
  _snapToPolyline(
    start,
    polyline,
  );

  final LatLng snappedEnd =
  _snapToPolyline(
    end,
    polyline,
  );

  final List<LatLng> path = [
    snappedStart,
  ];

  // ==========================================================
  // Forward direction
  // ==========================================================

  if (startIndex < endIndex) {
    for (
    int i = startIndex + 1;
    i <= endIndex;
    i++
    ) {
      path.add(
        polyline[i],
      );
    }
  }

  // ==========================================================
  // Reverse direction
  // ==========================================================

  else if (startIndex > endIndex) {
    for (
    int i = startIndex;
    i > endIndex;
    i--
    ) {
      path.add(
        polyline[i],
      );
    }
  }

  // ==========================================================
  // Same segment
  // ==========================================================

  path.add(
    snappedEnd,
  );

  return path;
}


// ============================================================================
// GET SEGMENT INDEX
// ============================================================================

int _getSegmentIndex(
    LatLng point,
    List<LatLng> polyline,
    ) {
  if (polyline.length < 2) {
    return 0;
  }

  double minDistance =
      double.infinity;

  int closestSegment = 0;

  for (
  int i = 0;
  i < polyline.length - 1;
  i++
  ) {
    final LatLng projected =
    _projectPointOnSegment(
      point,
      polyline[i],
      polyline[i + 1],
    );

    final double distance =
    _calculateDistanceSquared(
      point,
      projected,
    );

    if (distance < minDistance) {
      minDistance = distance;
      closestSegment = i;
    }
  }

  return closestSegment;
}


// ============================================================================
// SNAP POINT TO POLYLINE
// ============================================================================

LatLng _snapToPolyline(
    LatLng point,
    List<LatLng> polyline,
    ) {
  if (polyline.isEmpty) {
    return point;
  }

  if (polyline.length == 1) {
    return polyline.first;
  }

  double minDistance =
      double.infinity;

  LatLng closestPoint =
      polyline.first;

  for (
  int i = 0;
  i < polyline.length - 1;
  i++
  ) {
    final LatLng start =
    polyline[i];

    final LatLng end =
    polyline[i + 1];

    final LatLng projected =
    _projectPointOnSegment(
      point,
      start,
      end,
    );

    final double distance =
    _calculateDistanceSquared(
      point,
      projected,
    );

    if (distance < minDistance) {
      minDistance = distance;
      closestPoint = projected;
    }
  }

  return closestPoint;
}


// ============================================================================
// PROJECT POINT ON SEGMENT
// ============================================================================

LatLng _projectPointOnSegment(
    LatLng p,
    LatLng v,
    LatLng w,
    ) {
  final double l2 =
  _calculateDistanceSquared(
    v,
    w,
  );

  if (l2 == 0.0) {
    return v;
  }

  final double t =
      ((p.latitude - v.latitude) *
          (w.latitude -
              v.latitude) +
          (p.longitude - v.longitude) *
              (w.longitude -
                  v.longitude)) /
          l2;

  final double tClamped =
  math.max(
    0.0,
    math.min(
      1.0,
      t,
    ),
  );

  return LatLng(
    v.latitude +
        tClamped *
            (w.latitude -
                v.latitude),
    v.longitude +
        tClamped *
            (w.longitude -
                v.longitude),
  );
}


// ============================================================================
// DISTANCE SQUARED
// ============================================================================

double _calculateDistanceSquared(
    LatLng p1,
    LatLng p2,
    ) {
  final double dLat =
      p1.latitude -
          p2.latitude;

  final double dLng =
      p1.longitude -
          p2.longitude;

  return dLat * dLat +
      dLng * dLng;
}


//////////////////////////////////////////////////////////////////////////////////////////////

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
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     _controller.addListener(() {
//       final currentPos = _positionAnimation.value;
//       if (Get.isRegistered<SwapController>()) {
//         final ctrl = Get.find<SwapController>();
//         // Update last animated position so GPS-level trim doesn't jump ahead
//         ctrl.lastAnimatedCarPos = currentPos;
//         // Trim polyline to match animated car position every frame
//         ctrl.trimDriverPolyline(currentPos);
//       }
//     });
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
//       // Start from current animated position (not the raw GPS target)
//       LatLng startPos = _positionAnimation.value;
//
//       if (widget.routePoints.isNotEmpty) {
//         startPos = _snapToPolyline(startPos, widget.routePoints);
//       }
//
//       List<LatLng> path = _getPolylinePath(startPos, widget.driverLocation, widget.routePoints);
//
//       PolylineTween tween = PolylineTween(path);
//
//       int durationMs = (tween.totalDistance * 2000000).toInt();
//       durationMs = durationMs.clamp(300, 4000);
//
//       _controller.duration = Duration(milliseconds: durationMs);
//
//       _positionAnimation = tween.animate(CurvedAnimation(
//         parent: _controller,
//         curve: Curves.linear,
//       ));
//
//       // Always start the animation — this triggers the addListener which calls trimDriverPolyline
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
//             double targetBearing = _calculateBearing(_previousAnimatedPosition!, currentPos);
//             double delta = (targetBearing - _smoothedBearing) % 360.0;
//             if (delta > 180.0) delta -= 360.0;
//             else if (delta < -180.0) delta += 360.0;
//
//             _smoothedBearing = (_smoothedBearing + delta * 0.15) % 360.0;
//           }
//         } else {
//           _smoothedBearing = 0.0;
//         }
//
//         _previousAnimatedPosition = currentPos;
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
//       ) {
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
//   if (polyline.length == 1) return [start, polyline.first, end];
//
//   int startIndex = _getSegmentIndex(start, polyline);
//   int endIndex = _getSegmentIndex(end, polyline);
//
//   LatLng snappedStart = _snapToPolyline(start, polyline);
//   LatLng snappedEnd = _snapToPolyline(end, polyline);
//
//   List<LatLng> path = [snappedStart];
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
//   path.add(snappedEnd);
//   return path;
// }
//
// int _getSegmentIndex(LatLng point, List<LatLng> polyline) {
//   if (polyline.length < 2) return 0;
//   double minDistance = double.infinity;
//   int closestSegment = 0;
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
//   return closestSegment;
// }
//
// LatLng _snapToPolyline(LatLng point, List<LatLng> polyline) {
//   if (polyline.isEmpty) return point;
//   if (polyline.length == 1) return polyline.first;
//
//   double minDistance = double.infinity;
//   LatLng closestPoint = polyline.first;
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
//   return closestPoint;
// }
//
// LatLng _projectPointOnSegment(LatLng p, LatLng v, LatLng w) {
//   final l2 = _calculateDistanceSquared(v, w);
//   if (l2 == 0.0) return v;
//
//   final t = ((p.latitude - v.latitude) * (w.latitude - v.latitude) +
//       (p.longitude - v.longitude) * (w.longitude - v.longitude)) / l2;
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