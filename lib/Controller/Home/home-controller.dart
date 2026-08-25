import 'dart:async';
import 'dart:math' as math;
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../View/yourtrip/booking_history_model/bookingHistorymodel.dart';
import 'model/Airportl_ist_model.dart';
import '../../View/Deshboard/map_widget/map_controller.dart';

import '../../api_servies/api_servies.dart';
import 'model/pickuplocationmodel.dart';

class SwapController extends GetxController {
  // final mapWedgit =OpenStreetMapWidget();
  final mapC = Get.isRegistered<PickLocationController>()
      ? Get.find<PickLocationController>()
      : Get.put(PickLocationController());

  final pickupFocus = FocusNode();
  final via1Focus = FocusNode();
  final via2Focus = FocusNode();
  final dropFocus = FocusNode();

  @override
  void onClose() {
    pickupFocus.dispose();

    via1Focus.dispose();
    via2Focus.dispose();
    dropFocus.dispose();
    super.onClose();
  }

  final TextEditingController pickUp = TextEditingController();
  final TextEditingController dropOff = TextEditingController();
  final TextEditingController viaController1 = TextEditingController();
  final TextEditingController viaController2 = TextEditingController();
  final TextEditingController babyNoteController = TextEditingController();

  var babyNote = "";

  void babynoteText(context) {
    babyNote = babyNoteController.text;
    Navigator.of(context).pop();
    babyNoteController.clear();
    print(babyNote);
  }

  //===============================================   pick UP location

  void pickupCurrentLocation() async {
    final loc = mapC.selectedLocation.value;

    if (loc == null) {
      // 🔥 fallback fix
      await mapC.address; // if available
    }

    final updatedLoc = mapC.selectedLocation.value;

    if (updatedLoc == null) return;

    pickUp.text = mapC.address.value;

    await setPickup(updatedLoc.latitude, updatedLoc.longitude);
  }

  void resetRouteState() {
    selectedPickUPLat = 0;
    selectedPickUPLon = 0;
    selectedDropLat = 0;
    selectedDropLon = 0;

    routePoints.clear();
    fullTripRoutePoints.clear();
    driverToDropoffPolyline.clear();
    pickUp.clear();
    dropOff.clear();

    update(["map", "distance"]);
  }

  ///======================================================================================  listWidget working and api
  var selectedItem = (0).obs;
  RxInt selectedIndex = 0.obs;

  List<Map<String, dynamic>> iconItems = [
    {"name": "Home", "icon": Icons.home},
    {"name": "Bus", "icon": Icons.airplanemode_active_rounded},
    {"name": "Plane", "icon": Icons.directions_bus},
  ];

  /// 🔹 THIS list UI me show ho rahi hai
  List<String> busStops = [];

  /// 🔹 Airport API data
  List<Location> airportLocations = [];

  /// 🔹 Train static data
  List<String> trainStops = [
    // "Karachi Cantt Station",
    // "Lahore Railway Station",
    // "Islamabad Railway Station",
    // "Rawalpindi Railway Station",
    // "Faisalabad Station",
  ];

  RxBool airportLoading = false.obs;

  Future<void> fetchAirports() async {
    airportLoading.value = true;
    update();

    var response = await ApiService.get(
        "airports/get", //  base url ApiService me hoga
        auth: true,
        sendCompanyId: true
    );

    if (response!.statusCode == 200) {
      final data = AirportList.fromJson(response.data);

      airportLocations = data.locations ?? [];

      // UI list ke liye sirf names
      busStops = airportLocations.map((e) => e.name ?? "").toList();
    } else {
      airportLocations.clear();
      busStops.clear();
    }

    airportLoading.value = false;
    update();
  }

  ///
  void changeIndex(int index) {
    selectedIndex.value = index;

    if (index != 1) {
      // Airport se bahar gaye
      selectedPickUPLat = 0.0;
      selectedPickUPLon = 0.0;
    }

    if (index == 1) {
      if (airportLocations.isEmpty) {
        fetchAirports();
      } else {
        busStops = airportLocations.map((e) => e.name ?? "").toList();
      }
    } else if (index == 2) {
      busStops = trainStops;
    }

    update();
  }

  RxString activeField = "pickup".obs;

  /// field focus
  Future<void> selectLocationFromList(int index) async {
    String address = "";
    double lat = 0.0;
    double lng = 0.0;

    if (selectedIndex.value == 1) {
      final loc = airportLocations[index];
      address = loc.name ?? loc.address ?? "";
      lat = double.tryParse(loc.latitude ?? "0") ?? 0;
      lng = double.tryParse(loc.longitude ?? "0") ?? 0;
    } else if (selectedIndex.value == 2) {
      address = trainStops[index];
    } else {
      address = busStops[index];
    }

    if (pickupFocus.hasFocus) {
      pickUp.text = address;
      setPickup(lat, lng);
    } else if (via1Focus.hasFocus) {
      viaController1.text = address;
      setVia1(lat, lng);
    } else if (via2Focus.hasFocus) {
      viaController2.text = address;
      setVia2(lat, lng);
    } else if (dropFocus.hasFocus) {
      dropOff.text = address;
      setDrop(lat, lng);
    }

    fetchRoute();
    update(["map", "distance"]);

    // Keyboard hide
    await Future.delayed(const Duration(milliseconds: 100));
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
  ///
  // void selectLocationFromList(int index) {
  //   String address = "";
  //   double lat = 0.0;
  //   double lng = 0.0;
  //
  //   if (selectedIndex.value == 1) {
  //     final loc = airportLocations[index];
  //     address = loc.name ?? loc.address ?? "";
  //     lat = double.tryParse(loc.latitude ?? "0") ?? 0;
  //     lng = double.tryParse(loc.longitude ?? "0") ?? 0;
  //   } else if (selectedIndex.value == 2) {
  //     address = trainStops[index];
  //   } else {
  //     address = busStops[index];
  //   }
  //
  //   if (pickupFocus.hasFocus) {
  //     pickUp.text = address;
  //     setPickup(lat, lng);
  //   } else if (via1Focus.hasFocus) {
  //     viaController1.text = address;
  //     setVia1(lat, lng);
  //   } else if (via2Focus.hasFocus) {
  //     viaController2.text = address;
  //     setVia2(lat, lng);
  //   } else if (dropFocus.hasFocus) {
  //     dropOff.text = address;
  //     setDrop(lat, lng);
  //   }
  //
  //   fetchRoute();
  //   update(["map", "distance"]);
  // }


//////////////////////////////////////////////////////////////////////////////////////////////////
//   void selectLocationFromList(int index) {
//     String address = "";
//     double lat = 0.0;
//     double lng = 0.0;
//
//     /// ✈️ AIRPORT
//     if (selectedIndex.value == 1) {
//       final loc = airportLocations[index];
//       address = loc.name ?? loc.address ?? "";
//       lat = double.tryParse(loc.latitude ?? "0") ?? 0;
//       lng = double.tryParse(loc.longitude ?? "0") ?? 0;
//     }
//     /// 🚆 TRAIN (static — lat/lng nahi)
//     else if (selectedIndex.value == 2) {
//       address = trainStops[index];
//     }
//     /// 🏠 ADDRESS (home/work)
//     else {
//       address = busStops[index];
//     }
//
//     /// 🔥 FIELD TARGETING
//     switch (activeField.value) {
//       case "pickup":
//         pickUp.text = address;
//         selectedPickUPLat = lat;
//         selectedPickUPLon = lng;
//         print("🟢 PICKUP SET → $address | Lat: $lat | Lng: $lng");
//         break;
//
//       case "via1":
//         viaController1.text = address;
//         via1Lat = lat;
//         via1Lon = lng;
//         showVia1.value = true;
//         print("🟡 VIA 1 SET → $address | Lat: $lat | Lng: $lng");
//         break;
//
//       case "via2":
//         viaController2.text = address;
//         via2Lat = lat;
//         via2Lon = lng;
//         showVia2.value = true;
//         print("🟠 VIA 2 SET → $address | Lat: $lat | Lng: $lng");
//         break;
//
//       case "drop":
//         dropOff.text = address;
//         selectedDropLat = lat;
//         selectedDropLon = lng;
//         print("🔴 DROP SET → $address | Lat: $lat | Lng: $lng");
//         break;
//     }
//
//     fetchRoute();
//     update(["map", "distance"]);
//   }

  ///----------------------------------------------------------------------------------------  where to go

  // void swapField() {
  //   String temp = pickUp.text;
  //   pickUp.text = dropOff.text;
  //   dropOff.text = temp;
  // }
  void swapField() {
    // Swap the text
    String tempText = pickUp.text;
    pickUp.text = dropOff.text;
    dropOff.text = tempText;

    // Swap the coordinates
    double tempLat = selectedPickUPLat;
    double tempLon = selectedPickUPLon;

    selectedPickUPLat = selectedDropLat;
    selectedPickUPLon = selectedDropLon;

    selectedDropLat = tempLat;
    selectedDropLon = tempLon;

    // Swap via points visibility? (optional, depends if needed)
    // Usually via1 & via2 stay as they are

    // Recalculate route after swap
    fetchRoute();
    update(["map", "distance"]);
  }

  // Swap button show/hide logic
  bool get canShowSwap => !showVia1.value && !showVia2.value;

  // Show/hide fields
  var showVia1 = false.obs;
  var showVia2 = false.obs;

  // Add via field
  void addField() {
    if (!showVia1.value) {
      showVia1.value = true;
    } else if (!showVia2.value) {
      showVia2.value = true;
    }
  }

  void validateLocations() {
    if (pickUp.text.isEmpty && dropOff.text.isEmpty) {
      showAppSnackBar("Please select pickup and drop-off locations");
      return;
    }

    if (pickUp.text.isEmpty) {
      showAppSnackBar("Please select pickup location");
      return;
    }

    if (dropOff.text.isEmpty) {
      showAppSnackBar("Please select drop-off location");
      return;
    }

    /// 🔥 NEW: Lat/Lng validation
    if (selectedPickUPLat == 0.0 || selectedPickUPLon == 0.0) {
      showAppSnackBar("Please select valid pickup location ");
      return;
    }

    if (selectedDropLat == 0.0 || selectedDropLon == 0.0) {
      showAppSnackBar("Please select valid drop-off location ");
      return;
    }

    Get.toNamed('/RideInfoScreen');
  }

  void showAppSnackBar(String message) {
    BotToast.showCustomText(
      duration: const Duration(seconds: 2),
      toastBuilder: (_) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black54.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///   ///============================= ======================== ================ ============  Pick Up location search

  RxBool searchloading = false.obs;
  RxList<Result> searchList = <Result>[].obs;

  Future<void> pickupLocation(String text) async {
    if (text.isEmpty) {
      searchList.clear();
      return;
    }

    searchloading.value = true;
    var response = await ApiService.get(
      'services/search',
      //'',
      // fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${pickUp.text.toUpperCase()}',
      auth: true,
      isProgressShow: false,

      queryParameters: {'search': pickUp.text},
    );

    if (response!.statusCode == 200) {
      LocationModel model = LocationModel.fromJson(response.data);

      searchList.value = model.result ?? [];
    }

    searchloading.value = false;
  }

  ///   ///============================= ======================== ================ ============   drop off location search
  // DropOff related
  RxBool dropSearchLoading = false.obs;
  RxList<Result> dropSearchList = <Result>[].obs;

  Future<void> dropOffLocation(String text) async {
    // Agar text field empty ho toh list clear karo
    if (text.isEmpty) {
      dropSearchList.clear();
      return;
    }

    // Loader ON
    dropSearchLoading.value = true;

    // API call

    var response = await ApiService.get(
      'services/search',
      // '',
      // fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${dropOff.text.toUpperCase()}',
      auth: true,
      isProgressShow: false,

      queryParameters: {'search': dropOff.text},
    );

    if (response!.statusCode == 200) {
      LocationModel model = LocationModel.fromJson(response.data);

      // Result ko update karo
      dropSearchList.value = model.result ?? [];
    }

    // Loader OFF
    dropSearchLoading.value = false;
  }

  ///   ///============================= ======================== ================ ============   via 1 location search

  RxBool viaSearchloading1 = false.obs;
  RxList<Result> viaSearchList1 = <Result>[].obs;

  Future<void> viaLocation1(String text) async {
    if (text.isEmpty) {
      viaSearchList1.clear();
      return;
    }

    viaSearchloading1.value = true;

    var response = await ApiService.get(
      'services/search',
      // '',
      // fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${viaController1.text.toUpperCase()}',
      auth: true,
      isProgressShow: false,
      queryParameters: {'search': viaController1.text},
    );

    if (response!.statusCode == 200) {
      LocationModel model = LocationModel.fromJson(response.data);

      viaSearchList1.value = model.result ?? [];
    }

    viaSearchloading1.value = false;
  }

  ///   ///============================= ======================== ================ ============   via 2 location search

  RxBool viaSearchloading2 = false.obs;
  RxList<Result> viaSearchList2 = <Result>[].obs;

  Future<void> viaLocation2(String text) async {
    if (text.isEmpty) {
      viaSearchList2.clear();
      return;
    }

    viaSearchloading2.value = true;

    var response = await ApiService.get(
      'services/search',
      // '',
      // fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${viaController2.text.toUpperCase()}',
      auth: true,
      isProgressShow: false,
      queryParameters: {'search': viaController2.text},
    );

    if (response!.statusCode == 200) {
      LocationModel model = LocationModel.fromJson(response.data);

      viaSearchList2.value = model.result ?? [];
    }

    viaSearchloading2.value = false;
  }

  ///-========================================================== ==============================     map Working

  MapController? mapController;
  int _routeRequestId = 0;

  bool isMapReady = false;
  List<LatLng> routePoints = [];

  // pick Up lat lng
  double selectedPickUPLat = 0.0;
  double selectedPickUPLon = 0.0;

  // drop off  Up lat lng
  double selectedDropLat = 0.0;
  double selectedDropLon = 0.0;

  // VIA STOP 1
  double via1Lat = 0.0;
  double via1Lon = 0.0;

  // VIA STOP 2
  double via2Lat = 0.0;
  double via2Lon = 0.0;

  // void setPickup(double lat, double lon) {
  //   selectedPickUPLat = lat;
  //   selectedPickUPLon = lon;
  //   print("====================================${selectedPickUPLat }   , ${selectedPickUPLon }");
  //
  //   fetchRoute();
  //   update();
  // }
  Future<void> setPickup(double lat, double lon) async {
    selectedPickUPLat = lat;
    selectedPickUPLon = lon;
    print(
      "pickUp ================================================${selectedPickUPLat}   , ${selectedPickUPLon}",
    );
    await fetchRoute();
    update();
  }

  void setDrop(double lat, double lon) {
    selectedDropLat = lat;
    selectedDropLon = lon;
    print(
      "Dropoff================================================${selectedDropLat}   , ${selectedDropLon}",
    );
    fetchRoute();
    update();
  }

  void setVia1(double lat, double lon) {
    via1Lat = lat;
    via1Lon = lon;
    showVia1.value = true;
    fetchRoute();
    update(["map"]);
  }

  void setVia2(double lat, double lon) {
    via2Lat = lat;
    via2Lon = lon;
    showVia2.value = true;

    fetchRoute();
    update(["map"]);
  }

  RxBool isPickupEmpty = true.obs;
  void removePickUpField() {
    pickUp.clear();
    selectedPickUPLat = 0.0;
    selectedPickUPLon = 0.0;

    isPickupEmpty.value = true;

    fetchRoute();
    // update();
  }

  void removeDropOff() {
    dropOff.clear();
    selectedDropLat = 0.0;
    selectedDropLon = 0.0;

    fetchRoute();
    update(["map"]);
  }

  double totalRouteDistanceMiles = 0.0; // miles
  LatLng? routeCenterPoint;

  // estimate time working
  double estimatedTimeMinutes = 0.0; // minutes
  String estimatedTimeText = ""; // 2 hours 3 minutes

  String formatDuration(double totalMinutes) {
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes.round() % 60;

    String h = hours == 1 ? "hours" : "hours";
    String m = minutes == 1 ? "mins" : "mins";

    if (hours > 0) {
      return "$hours $h $minutes $m";
    } else {
      return "$minutes $m";
    }
  }

  // void calculateRouteCenter() {
  //   if (routePoints.isEmpty) {
  //     routeCenterPoint = null;
  //     update(["distance"]);
  //     return;
  //   }
  //
  //   routeCenterPoint = routePoints[routePoints.length ~/ 2];
  //   update(["distance"]);
  // }

  void removeVia1() {
    via1Lat = 0;
    via1Lon = 0;
    viaController1.clear();
    showVia1.value = false;
    fetchRoute();
    update(["map", "distance"]);
  }

  void removeVia2() {
    via2Lat = 0;
    via2Lon = 0;
    viaController2.clear();
    showVia2.value = false;
    fetchRoute();
    update(["map", "distance"]);
  }

  Future<void> fetchRoute() async {
    if (selectedPickUPLat == 0.0 ||
        selectedPickUPLon == 0.0 ||
        selectedDropLat == 0.0 ||
        selectedDropLon == 0.0)
      return;

    // Track latest API call
    final requestId = ++_routeRequestId;

    // Build GraphHopper URL with via points
    String url =
        'https://graphhopper.com/api/1/route?vehicle=car&points_encoded=false&key=f57e40a3-f4c9-41da-8f4d-25d26e0b2e56'
        '&point=$selectedPickUPLat,$selectedPickUPLon';

    if (via1Lat != 0.0 && via1Lon != 0.0) {
      url += '&point=$via1Lat,$via1Lon';
    }

    if (via2Lat != 0.0 && via2Lon != 0.0) {
      url += '&point=$via2Lat,$via2Lon';
    }

    url += '&point=$selectedDropLat,$selectedDropLon';

    try {
      final response = await Dio().get(url);

      // Ignore old responses
      if (requestId != _routeRequestId) return;

      if (response.statusCode == 200) {
        final route = response.data['paths'][0];

        /// 🟣 POLYLINE POINTS
        final coords = route['points']['coordinates'];
        final newRoute = coords.map<LatLng>((p) {
          return LatLng((p[1] as num).toDouble(), (p[0] as num).toDouble());
        }).toList();

        routePoints = newRoute;
        fullTripRoutePoints = List<LatLng>.from(newRoute);
        driverToDropoffPolyline.value = List<LatLng>.from(newRoute);

        /// DISTANCE (meters → miles)
        double distanceMeters = (route['distance'] as num).toDouble();
        totalRouteDistanceMiles = distanceMeters * 0.000621371;

        /// DURATION (milliseconds → minutes)
        // double durationMs = (route['time'] as num).toDouble();
        // estimatedTimeMinutes = durationMs / 1000 / 60;

        double durationMs = (route['time'] as num).toDouble();
        estimatedTimeMinutes = durationMs / 1000 / 60;
        estimatedTimeText = formatDuration(estimatedTimeMinutes);

        /// CENTER POINT FOR DISTANCE LABEL
        if (routePoints.isNotEmpty) {
          routeCenterPoint = routePoints[routePoints.length ~/ 2.5];
        } else {
          routeCenterPoint = null;
        }

        update(["map", "distance"]);

        /// AUTO FIT MAP TO ROUTE
        if (isMapReady && mapController != null && routePoints.isNotEmpty) {
          Future.delayed(const Duration(milliseconds: 100), () {
            final bounds = LatLngBounds.fromPoints(routePoints);
            mapController!.fitCamera(
              CameraFit.bounds(
                bounds: bounds,
                padding: const EdgeInsets.all(60),
              ),
            );
          });
        }
      }
    } catch (e) {
      print("Route error: $e");
    }
  }

  /// ==============================================  History booking
  void setRouteFromBooking(dynamic trip) {
    /// Pickup
    selectedPickUPLat = double.tryParse(trip.pickupLatitude ?? "0") ?? 0.0;
    selectedPickUPLon = double.tryParse(trip.pickupLongitude ?? "0") ?? 0.0;

    /// Drop
    selectedDropLat = double.tryParse(trip.dropoffLatitude ?? "0") ?? 0.0;
    selectedDropLon = double.tryParse(trip.dropoffLongitude ?? "0") ?? 0.0;

    /// Reset via
    via1Lat = 0.0;
    via1Lon = 0.0;
    via2Lat = 0.0;
    via2Lon = 0.0;
    showVia1.value = false;
    showVia2.value = false;

    /// VIA points
    if (trip.viapoints != null && trip.viapoints!.isNotEmpty) {
      /// 👉 VIA 1
      if (trip.viapoints!.length >= 1) {
        var v1 = trip.viapoints![0];

        via1Lat = double.tryParse(v1['lat']?.toString() ?? "0") ?? 0.0;
        via1Lon = double.tryParse(v1['lng']?.toString() ?? "0") ?? 0.0;

        showVia1.value = true;
      }

      /// 👉 VIA 2
      if (trip.viapoints!.length >= 2) {
        var v2 = trip.viapoints![1];

        via2Lat = double.tryParse(v2['lat']?.toString() ?? "0") ?? 0.0;
        via2Lon = double.tryParse(v2['lng']?.toString() ?? "0") ?? 0.0;

        showVia2.value = true;
      }
    }

    fetchRoute(); // 🔥 API call
    resetDriverTracking();
    update(["map"]);
  }

  ///============================================================  map funtion driver detail screen



  RxDouble driverLat = 0.0.obs;
  RxDouble driverLng = 0.0.obs;

  /// 🔥 Driver → Pickup remaining polyline (driver ke aage se pickup tak)
  RxList<LatLng> driverToPickupPolyline = <LatLng>[].obs;

  /// 🟣 Driver → Dropoff remaining polyline (driver ke aage se drop-off tak)
  RxList<LatLng> driverToDropoffPolyline = <LatLng>[].obs;
  List<LatLng> fullTripRoutePoints = [];

  /// 📍 Last position the animated car marker was at (updated every animation frame)
  /// Used so GPS-level trimming never jumps ahead of the visual car
  LatLng? lastAnimatedCarPos;

  /// Route deviation threshold — ~70-80 meters (0.0000005 in squared degrees)
  static const double _routeDeviationThreshold = 0.0000005;

  /// Flag to prevent multiple simultaneous route fetches
  bool _isFetchingDriverRoute = false;
  bool _isFetchingDropoffRoute = false;

  /// Cooldown — minimum 3 seconds between re-fetches
  DateTime? _lastDriverRouteFetchTime;
  DateTime? _lastDropoffRouteFetchTime;

  List<LatLng> driverRoutePoints = [];
  bool hasFetchedDriverRoute = false;

  /// 🔥 Driver pickup tak pohanch chuka hai ya nahi
  RxBool hasReachedPickup = false.obs;

  /// Reset driver tracking for fresh session
  void resetDriverTracking() {
    driverLat.value = 0.0;
    driverLng.value = 0.0;
    driverToPickupPolyline.clear();
    driverRoutePoints.clear();
    driverToDropoffPolyline.clear();
    fullTripRoutePoints.clear();
    hasFetchedDriverRoute = false;
    hasReachedPickup.value = false;
    _isFetchingDriverRoute = false;
    _isFetchingDropoffRoute = false;
    _lastDriverRouteFetchTime = null;
    _lastDropoffRouteFetchTime = null;
  }

  /// Call this when new driver GPS arrives from API (handles validation & jitter)
  void animateDriverTo(double newLat, double newLng) {
    // 🛡️ TC-23 & TC-11: Validate GPS coordinate range and ignore invalid data
    if (newLat < -90.0 || newLat > 90.0 || newLng < -180.0 || newLng > 180.0 || newLat == 0.0 || newLng == 0.0) {
      return;
    }

    // 🛡️ TC-01: First time — set directly and fetch initial route if not at pickup
    if (driverLat.value == 0.0 && driverLng.value == 0.0) {
      driverLat.value = newLat;
      driverLng.value = newLng;
      if (!hasReachedPickup.value) {
        fetchDriverRoute();
      }
      return;
    }

    // 🛡️ TC-09: Ignore micro GPS fluctuations / jitter (< ~1 meter)
    double latDiff = (newLat - driverLat.value).abs();
    double lngDiff = (newLng - driverLng.value).abs();
    if (latDiff < 0.000009 && lngDiff < 0.000009) {
      return;
    }

    final newPoint = LatLng(newLat, newLng);

    // 🛡️ Check if driver reached pickup point or is near/heading towards dropoff (< 40 meters)
    if (!hasReachedPickup.value && selectedPickUPLat != 0.0 && selectedPickUPLon != 0.0) {
      final pickupPoint = LatLng(selectedPickUPLat, selectedPickUPLon);
      double distToPickup = _distanceInMeters(newPoint, pickupPoint);

      if (distToPickup <= 40.0 || (routePoints.isNotEmpty && _distanceInMeters(newPoint, routePoints.first) <= 40.0)) {
        hasReachedPickup.value = true;
        driverToPickupPolyline.clear();
        driverRoutePoints.clear();
        hasFetchedDriverRoute = true;
        update(["map"]);
      }
    }

    // Phase 1 (Going to Pickup): Check deviation if route exists
    if (!hasReachedPickup.value) {
      if (driverRoutePoints.isNotEmpty) {
        double minDist = double.infinity;
        for (int i = 0; i < driverRoutePoints.length - 1; i++) {
          final projected = _projectOnSegment(
            newPoint, driverRoutePoints[i], driverRoutePoints[i + 1],
          );
          final dist = _distSquared(newPoint, projected);
          if (dist < minDist) minDist = dist;
        }

        // 🔴 If driver deviated from route (> ~75m), re-fetch new route immediately from driver to pickup
        if (minDist > _routeDeviationThreshold) {
          if (_lastDriverRouteFetchTime == null ||
              DateTime.now().difference(_lastDriverRouteFetchTime!).inSeconds >= 3) {
            debugPrint("🔴 Driver route changed/deviated! Re-fetching route from driver to pickup...");
            driverLat.value = newLat;
            driverLng.value = newLng;
            fetchDriverRoute();
            return;
          }
        }
      } else {
        if (!hasFetchedDriverRoute) {
          fetchDriverRoute();
        }
      }
    }
    // 🟣 Phase 2 (Pickup to Drop-off): Check deviation against purple route
    else if (hasReachedPickup.value && routePoints.isNotEmpty) {
      double minDist = double.infinity;
      for (int i = 0; i < routePoints.length - 1; i++) {
        final projected = _projectOnSegment(
          newPoint, routePoints[i], routePoints[i + 1],
        );
        final dist = _distSquared(newPoint, projected);
        if (dist < minDist) minDist = dist;
      }

      // 🔴 If driver deviated from drop-off route (> ~75m), re-fetch new purple route to drop-off
      if (minDist > _routeDeviationThreshold) {
        if (_lastDropoffRouteFetchTime == null ||
            DateTime.now().difference(_lastDropoffRouteFetchTime!).inSeconds >= 3) {
          debugPrint("🔴 Driver route changed after pickup! Re-fetching purple route to drop-off...");
          driverLat.value = newLat;
          driverLng.value = newLng;
          fetchDropoffRouteFromDriver();
          return;
        }
      }
    }

    // 🛡️ TC-02, TC-08: Update target coordinates so AnimatedCarMarker drives smoothly along polyline
    driverLat.value = newLat;
    driverLng.value = newLng;
    // Trim at the LAST ANIMATED POSITION (not the new GPS target) to avoid polyline jumping ahead of car
    final trimPos = lastAnimatedCarPos ?? newPoint;
    trimDriverPolyline(trimPos);
  }

  /// 🔥 Real-time polyline trimmer:
  /// - Phase 1 (Driver -> Pickup): Trims orange line behind driver (ends cleanly when pickup is reached)
  /// - Phase 2 (Pickup -> Dropoff): Trims purple line behind vehicle as it moves forward
  void trimDriverPolyline(LatLng carCurrentPos) {
    if (selectedPickUPLat == 0.0 || selectedPickUPLon == 0.0) return;
    final pickupPoint = LatLng(selectedPickUPLat, selectedPickUPLon);

    // 🎯 1. Pickup Arrival Check:
    if (!hasReachedPickup.value) {
      double distToPickup = _distanceInMeters(carCurrentPos, pickupPoint);
      if (distToPickup <= 40.0 || (routePoints.isNotEmpty && _distanceInMeters(carCurrentPos, routePoints.first) <= 40.0)) {
        hasReachedPickup.value = true;
        driverToPickupPolyline.clear();
        driverRoutePoints.clear();
        hasFetchedDriverRoute = true;
        update(["map"]);
      }
    }

    // 🔥 Phase 1: Trim Driver -> Pickup (Orange Line) - Stays active until driver reaches exact pickup!
    if (!hasReachedPickup.value && driverRoutePoints.isNotEmpty) {
      int closestSegmentIndex = 0;
      double minDist = double.infinity;
      LatLng closestProjection = carCurrentPos;

      for (int i = 0; i < driverRoutePoints.length - 1; i++) {
        final projected = _projectOnSegment(
          carCurrentPos, driverRoutePoints[i], driverRoutePoints[i + 1],
        );
        final dist = _distSquared(carCurrentPos, projected);
        if (dist < minDist) {
          minDist = dist;
          closestSegmentIndex = i;
          closestProjection = projected;
        }
      }

      // Check if car reached the last segments of the orange route
      if (closestSegmentIndex >= driverRoutePoints.length - 2) {
        double distToEnd = _distanceInMeters(carCurrentPos, driverRoutePoints.last);
        double distToPickup = _distanceInMeters(carCurrentPos, pickupPoint);
        if (distToEnd <= 35.0 || distToPickup <= 50.0) {
          hasReachedPickup.value = true;
          driverToPickupPolyline.clear();
          driverRoutePoints.clear();
          hasFetchedDriverRoute = true;
          update(["map"]);
          return;
        }
      }

      List<LatLng> remaining = [closestProjection];
      for (int i = closestSegmentIndex + 1; i < driverRoutePoints.length; i++) {
        remaining.add(driverRoutePoints[i]);
      }

      // Ensure the pickup point is always the destination endpoint of the orange line
      if (remaining.isNotEmpty &&
          (remaining.last.latitude != pickupPoint.latitude ||
              remaining.last.longitude != pickupPoint.longitude)) {
        remaining.add(pickupPoint);
      }

      if (remaining.length >= 2) {
        driverToPickupPolyline.value = remaining;
      } else {
        hasReachedPickup.value = true;
        driverToPickupPolyline.clear();
        driverRoutePoints.clear();
        hasFetchedDriverRoute = true;
        update(["map"]);
      }
    }
    // 🟣 Phase 2: Trim Pickup -> Drop-off (Purple Line)
    else {
      final tripRef = fullTripRoutePoints.isNotEmpty
          ? fullTripRoutePoints
          : (routePoints.isNotEmpty ? (fullTripRoutePoints = List<LatLng>.from(routePoints)) : <LatLng>[]);
      if (tripRef.isNotEmpty) {
        int closestSegmentIndex = 0;
        double minDist = double.infinity;
        LatLng closestProjection = carCurrentPos;

        for (int i = 0; i < tripRef.length - 1; i++) {
          final projected = _projectOnSegment(
            carCurrentPos, tripRef[i], tripRef[i + 1],
          );
          final dist = _distSquared(carCurrentPos, projected);
          if (dist < minDist) {
            minDist = dist;
            closestSegmentIndex = i;
            closestProjection = projected;
          }
        }

        // If car is within reasonable distance to the trip route or pickup has been reached
        if (minDist < 0.005 || hasReachedPickup.value) {
          List<LatLng> remaining = [closestProjection];
          for (int i = closestSegmentIndex + 1; i < tripRef.length; i++) {
            remaining.add(tripRef[i]);
          }

          if (selectedDropLat != 0.0 && selectedDropLon != 0.0) {
            final dropPoint = LatLng(selectedDropLat, selectedDropLon);
            if (remaining.isNotEmpty &&
                (remaining.last.latitude != dropPoint.latitude ||
                    remaining.last.longitude != dropPoint.longitude)) {
              remaining.add(dropPoint);
            }
          }

          if (remaining.length >= 2) {
            driverToDropoffPolyline.value = remaining;
          } else {
            driverToDropoffPolyline.clear();
          }
        }
      }
    }
  }

  Future<void> fetchDriverRoute() async {
    if (hasReachedPickup.value) return;
    if (driverLat.value == 0.0 || driverLng.value == 0.0 || selectedPickUPLat == 0.0 || selectedPickUPLon == 0.0) return;
    if (_isFetchingDriverRoute) return;

    _isFetchingDriverRoute = true;
    _lastDriverRouteFetchTime = DateTime.now();

    String url = 'https://graphhopper.com/api/1/route?vehicle=car&points_encoded=false&key=f57e40a3-f4c9-41da-8f4d-25d26e0b2e56'
        '&point=${driverLat.value},${driverLng.value}'
        '&point=$selectedPickUPLat,$selectedPickUPLon';

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        if (hasReachedPickup.value) return;

        final route = response.data['paths'][0];
        final coords = route['points']['coordinates'];
        final newPoints = coords.map<LatLng>((p) {
          return LatLng((p[1] as num).toDouble(), (p[0] as num).toDouble());
        }).toList();

        driverRoutePoints = newPoints;
        driverToPickupPolyline.value = List<LatLng>.from(newPoints);
        hasFetchedDriverRoute = true;
      }
    } catch (e) {
      print("Driver Route error: $e");
    } finally {
      _isFetchingDriverRoute = false;
    }
  }

  /// 🟣 Re-fetch route from Driver's current position to Drop-off (when driver changes route after pickup)
  Future<void> fetchDropoffRouteFromDriver() async {
    if (driverLat.value == 0.0 || driverLng.value == 0.0 || selectedDropLat == 0.0 || selectedDropLon == 0.0) return;
    if (_isFetchingDropoffRoute) return;

    _isFetchingDropoffRoute = true;
    _lastDropoffRouteFetchTime = DateTime.now();

    String url = 'https://graphhopper.com/api/1/route?vehicle=car&points_encoded=false&key=f57e40a3-f4c9-41da-8f4d-25d26e0b2e56'
        '&point=${driverLat.value},${driverLng.value}';

    // Include via points if not passed yet
    if (showVia1.value && via1Lat != 0.0 && via1Lon != 0.0) {
      final via1Point = LatLng(via1Lat, via1Lon);
      if (_distSquared(LatLng(driverLat.value, driverLng.value), via1Point) > 0.0001) {
        url += '&point=$via1Lat,$via1Lon';
      }
    }

    if (showVia2.value && via2Lat != 0.0 && via2Lon != 0.0) {
      final via2Point = LatLng(via2Lat, via2Lon);
      if (_distSquared(LatLng(driverLat.value, driverLng.value), via2Point) > 0.0001) {
        url += '&point=$via2Lat,$via2Lon';
      }
    }

    url += '&point=$selectedDropLat,$selectedDropLon';

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final route = response.data['paths'][0];
        final coords = route['points']['coordinates'];
        final newPoints = coords.map<LatLng>((p) {
          return LatLng((p[1] as num).toDouble(), (p[0] as num).toDouble());
        }).toList();

        routePoints = newPoints;
        fullTripRoutePoints = List<LatLng>.from(newPoints);
        driverToDropoffPolyline.value = List<LatLng>.from(newPoints);

        // Update distance & estimated time
        double distanceMeters = (route['distance'] as num).toDouble();
        totalRouteDistanceMiles = distanceMeters * 0.000621371;
        double durationMs = (route['time'] as num).toDouble();
        estimatedTimeMinutes = durationMs / 1000 / 60;
        estimatedTimeText = formatDuration(estimatedTimeMinutes);

        if (routePoints.isNotEmpty) {
          routeCenterPoint = routePoints[routePoints.length ~/ 2.5];
        }

        update(["map", "distance"]);
      }
    } catch (e) {
      debugPrint("Dropoff Route re-fetch error: $e");
    } finally {
      _isFetchingDropoffRoute = false;
    }
  }

  /// Helper: Project point on segment
  LatLng _projectOnSegment(LatLng p, LatLng v, LatLng w) {
    final l2 = _distSquared(v, w);
    if (l2 == 0.0) return v;
    final t = ((p.latitude - v.latitude) * (w.latitude - v.latitude) +
        (p.longitude - v.longitude) * (w.longitude - v.longitude)) / l2;
    final tClamped = t.clamp(0.0, 1.0);
    return LatLng(
      v.latitude + tClamped * (w.latitude - v.latitude),
      v.longitude + tClamped * (w.longitude - v.longitude),
    );
  }

  /// Helper: Distance squared between two points
  double _distSquared(LatLng a, LatLng b) {
    final dLat = a.latitude - b.latitude;
    final dLng = a.longitude - b.longitude;
    return dLat * dLat + dLng * dLng;
  }

  /// Helper: Distance in meters between two points (Haversine formula)
  double _distanceInMeters(LatLng a, LatLng b) {
    const double earthRadius = 6371000; // in meters
    final double dLat = (b.latitude - a.latitude) * math.pi / 180.0;
    final double dLng = (b.longitude - a.longitude) * math.pi / 180.0;
    final double lat1 = a.latitude * math.pi / 180.0;
    final double lat2 = b.latitude * math.pi / 180.0;

    final double sinDLat = math.sin(dLat / 2);
    final double sinDLng = math.sin(dLng / 2);

    final double h = sinDLat * sinDLat +
        math.cos(lat1) * math.cos(lat2) * sinDLng * sinDLng;
    final double c = 2 * math.asin(math.sqrt(math.max(0.0, math.min(1.0, h))));
    return earthRadius * c;
  }



/// ////  /// ================= ROUTE TRACKING =================





  bool hasFittedMap = false;
  // RxList<LatLng> routePointsTraking = <LatLng>[].obs;
  //
  // Future<void> fetchRouteTracking() async {
  //   if (selectedPickUPLat == 0.0 ||
  //       selectedPickUPLon == 0.0 ||
  //       selectedDropLat == 0.0 ||
  //       selectedDropLon == 0.0) return;
  //
  //   final requestId = ++_routeRequestId;
  //
  //   String url =
  //       'https://graphhopper.com/api/1/route?vehicle=car&points_encoded=false&key=YOUR_KEY'
  //       '&point=$selectedPickUPLat,$selectedPickUPLon';
  //
  //   if (via1Lat != 0.0 && via1Lon != 0.0) {
  //     url += '&point=$via1Lat,$via1Lon';
  //   }
  //
  //   if (via2Lat != 0.0 && via2Lon != 0.0) {
  //     url += '&point=$via2Lat,$via2Lon';
  //   }
  //
  //   url += '&point=$selectedDropLat,$selectedDropLon';
  //
  //   try {
  //     final response = await Dio().get(url);
  //
  //     if (requestId != _routeRequestId) return;
  //
  //     if (response.statusCode == 200 &&
  //         response.data != null &&
  //         response.data['paths'] != null &&
  //         (response.data['paths'] as List).isNotEmpty) {
  //
  //       final route = response.data['paths'][0];
  //       final List coords = route['points']?['coordinates'] ?? [];
  //
  //       final newRoute = coords.map<LatLng>((p) {
  //         return LatLng(
  //           (p[1] as num).toDouble(),
  //           (p[0] as num).toDouble(),
  //         );
  //       }).toList();
  //
  //       // 🔥 FIX (IMPORTANT)
  //       routePointsTraking.clear();
  //       routePointsTraking.addAll(newRoute);
  //
  //       routePointsTraking.refresh();
  //       update(["map"]);
  //     }
  //   } catch (e) {
  //     print("Route error: $e");
  //   }
  // }


  void setBookingRoute(booking) {
    selectedPickUPLat = double.tryParse(booking.pickupLatitude ?? "0") ?? 0.0;
    selectedPickUPLon = double.tryParse(booking.pickupLongitude ?? "0") ?? 0.0;

    selectedDropLat = double.tryParse(booking.dropoffLatitude ?? "0") ?? 0.0;
    selectedDropLon = double.tryParse(booking.dropoffLongitude ?? "0") ?? 0.0;

    pickUp.text = booking.pickup ?? "";
    dropOff.text = booking.dropoff ?? "";

    /// RESET VIA
    via1Lat = 0;
    via1Lon = 0;
    via2Lat = 0;
    via2Lon = 0;
    showVia1.value = false;
    showVia2.value = false;

    /// 🟡 VIA POINTS
    debugPrint("🟡 VIA POINTS RAW: ${booking.viapoints}");
    if (booking.viapoints != null && booking.viapoints.isNotEmpty) {
      /// VIA 1
      if (booking.viapoints.length >= 1) {
        var v1 = booking.viapoints[0];
        debugPrint("🟡 VIA 1 DATA: $v1");
        via1Lat = double.tryParse((v1['latitude'] ?? v1['lat'])?.toString() ?? "0") ?? 0.0;
        via1Lon = double.tryParse((v1['longitude'] ?? v1['lng'])?.toString() ?? "0") ?? 0.0;
        viaController1.text = v1['viapoint'] ?? "";
        debugPrint("🟡 VIA 1 SET: lat=$via1Lat, lon=$via1Lon");
        if (via1Lat != 0.0 && via1Lon != 0.0) {
          showVia1.value = true;
        }
      }

      /// VIA 2
      if (booking.viapoints.length >= 2) {
        var v2 = booking.viapoints[1];
        debugPrint("🟡 VIA 2 DATA: $v2");
        via2Lat = double.tryParse((v2['latitude'] ?? v2['lat'])?.toString() ?? "0") ?? 0.0;
        via2Lon = double.tryParse((v2['longitude'] ?? v2['lng'])?.toString() ?? "0") ?? 0.0;
        viaController2.text = v2['viapoint'] ?? "";
        debugPrint("🟡 VIA 2 SET: lat=$via2Lat, lon=$via2Lon");
        if (via2Lat != 0.0 && via2Lon != 0.0) {
          showVia2.value = true;
        }
      }
    }

    //routePointsTraking.clear();
    hasFittedMap = false;
    /// 🚀 ROUTE CALL
    fetchRoute();

    // UI UPDATE
    update(["map", "distance"]);
    //fetchRouteTracking();

  }






// bool hasFittedMap = false;
// RxList<LatLng> routePointsTraking = <LatLng>[].obs;
//
// Future<void> fetchRouteTracking() async {
//   if (selectedPickUPLat == 0.0 ||
//       selectedPickUPLon == 0.0 ||
//       selectedDropLat == 0.0 ||
//       selectedDropLon == 0.0) return;
//
//   final requestId = ++_routeRequestId;
//
//   String url =
//       'https://graphhopper.com/api/1/route?vehicle=car&points_encoded=false&key=YOUR_KEY'
//       '&point=$selectedPickUPLat,$selectedPickUPLon';
//
//   if (via1Lat != 0.0 && via1Lon != 0.0) {
//     url += '&point=$via1Lat,$via1Lon';
//   }
//
//   if (via2Lat != 0.0 && via2Lon != 0.0) {
//     url += '&point=$via2Lat,$via2Lon';
//   }
//
//   url += '&point=$selectedDropLat,$selectedDropLon';
//
//   try {
//     final response = await Dio().get(url);
//
//     if (requestId != _routeRequestId) return;
//
//     if (response.statusCode == 200 &&
//         response.data != null &&
//         response.data['paths'] != null &&
//         (response.data['paths'] as List).isNotEmpty) {
//
//       final route = response.data['paths'][0];
//
//       final List coords = route['points']?['coordinates'] ?? [];
//
//       if (coords.isEmpty) {
//         routePointsTraking.clear();
//         routePointsTraking.refresh();
//         return;
//       }
//
//       final newRoute = coords.map<LatLng>((p) {
//         return LatLng(
//           (p[1] as num).toDouble(),
//           (p[0] as num).toDouble(),
//         );
//       }).toList();
//
//       routePointsTraking
//         ..clear()
//         ..addAll(newRoute);
//
//       routePointsTraking.refresh();
//       update();
//     }
//   } catch (e) {
//     print("Route error: $e");
//   }
// }
/// ====================================================== set booking
//   void setBookingRoute(booking) {
//     /// 🔵 PICKUP
//     selectedPickUPLat = double.tryParse(booking.pickupLatitude ?? "0") ?? 0.0;
//
//     selectedPickUPLon = double.tryParse(booking.pickupLongitude ?? "0") ?? 0.0;
//
//     pickUp.text = booking.pickup ?? "";
//
//     /// 🔴 DROP
//     selectedDropLat = double.tryParse(booking.dropoffLatitude ?? "0") ?? 0.0;
//
//     selectedDropLon = double.tryParse(booking.dropoffLongitude ?? "0") ?? 0.0;
//
//     dropOff.text = booking.dropoff ?? "";
//
//     /// RESET VIA
//     via1Lat = 0;
//     via1Lon = 0;
//     via2Lat = 0;
//     via2Lon = 0;
//
//     showVia1.value = false;
//     showVia2.value = false;
//
//     /// 🟡 VIA POINTS
//     if (booking.viapoints != null && booking.viapoints.isNotEmpty) {
//       /// VIA 1
//       if (booking.viapoints.length >= 1) {
//         var v1 = booking.viapoints[0];
//
//         via1Lat = double.tryParse(v1['latitude']?.toString() ?? "0") ?? 0.0;
//
//         via1Lon = double.tryParse(v1['longitude']?.toString() ?? "0") ?? 0.0;
//
//         viaController1.text = v1['viapoint'] ?? "";
//
//         showVia1.value = true;
//       }
//
//       /// VIA 2
//       if (booking.viapoints.length >= 2) {
//         var v2 = booking.viapoints[1];
//
//         via2Lat = double.tryParse(v2['latitude']?.toString() ?? "0") ?? 0.0;
//
//         via2Lon = double.tryParse(v2['longitude']?.toString() ?? "0") ?? 0.0;
//
//         viaController2.text = v2['viapoint'] ?? "";
//
//         showVia2.value = true;
//       }
//     }
//
//     // reset route
//     routePointsTraking.clear();
//
//     // 🔥 CALL ROUTE API HERE
//     fetchRouteTracking();
//
//     /// 🚀 ROUTE CALL
//     // fetchRoute();
//     //
//     // // UI UPDATE
//     //  update(["map", "distance"]);
//   }
}