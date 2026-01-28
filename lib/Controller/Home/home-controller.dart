import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../View/Deshboard/map_widget/map_controller.dart';
import '../../api_servies/api_servies.dart';
import 'model/pickuplocationmodel.dart';

class SwapController extends GetxController {


  var viaControllers = <TextEditingController>[].obs;
  final TextEditingController pickUp = TextEditingController(); // observable list
  final TextEditingController dropOff = TextEditingController(); // observable list

  final TextEditingController viaController1 = TextEditingController();
  final TextEditingController viaController2 = TextEditingController();


  // final mapWedgit =OpenStreetMapWidget();
  final mapC = Get.isRegistered<PickLocationController>()
      ? Get.find<PickLocationController>()
      : Get.put(PickLocationController());


  void pickupCurrentLocation() {
    // pickUp.text = mapC.currentAddress.value;
    pickUp.text = mapC.address.value;
  }


  var selectedItem = (0).obs;
  RxInt selectedIndex = 0.obs;


  List<Map<String, dynamic>> iconItems = [
    {"name": "Home", "icon": Icons.home},
    {"name": "Bus", "icon": Icons.airplanemode_active_rounded},
    {"name": "Plane", "icon": Icons.directions_bus},
  ];


  List<String> busStops = [
    "Korangi 2 No. Bus Stop",
    "Nagan Chowrangi Bus Stop",
    "Gulshan Chowrangi Bus Stop",
    "Sohrab Goth Bus Stop",
    "Johar Mor Bus Stop",
    "Kala Pul Bus Stop",
    "PIDC Bus Stop",
    "Tariq Road Bus Stop",
    "Clifton Teen Talwar Bus Stop",
    "Shah Faisal Colony Stop",
    "Saddar Mobile Market Stop",
    "Cantt Station Bus Stop",
    "Lahore Thokar Niaz Baig Stop",
    "Kalma Chowk Bus Stop",
    "Model Town Link Road Stop",
    "Anarkali Stop",
    "Rawalpindi Faizabad Bus Stop",
    "Murree Road Committee Chowk Stop",
    "Peshawar Khyber Bazaar Stop",
    "Faisalabad D Ground Bus Stop"
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }


  void swapField() {
    String temp = pickUp.text;
    pickUp.text = dropOff.text;
    dropOff.text = temp;
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

  // Remove via field
  // void removeField(int fieldNumber) {
  //   if (fieldNumber == 1) {
  //     viaController1.clear();
  //     showVia1.value = false;
  //   } else if (fieldNumber == 2) {
  //     viaController2.clear();
  //     showVia2.value = false;
  //   }
  // }


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
      '',
      fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${pickUp
          .text.toUpperCase()}',
      auth: true,
      isProgressShow: false,
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
      '',
      fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${text
          .toUpperCase()}',
      auth: true,
      isProgressShow: false, // User loader nahi chahiye
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
      '',
      fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${viaController1
          .text.toUpperCase()}',
      auth: true,
      isProgressShow: false,
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
      '',
      fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${viaController2
          .text.toUpperCase()}',
      auth: true,
      isProgressShow: false,
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


  void setPickup(double lat, double lon) {
    selectedPickUPLat = lat;
    selectedPickUPLon = lon;
    fetchRoute();
    update();
  }

  void setDrop(double lat, double lon) {
    selectedDropLat = lat;
    selectedDropLon = lon;
    fetchRoute();
    update();
  }
  // void setVia1(double lat, double lon) {
  //   via1Lat = lat;
  //   via1Lon = lon;
  //   fetchRoute();
  //   update();
  // }
  //
  // void setVia2(double lat, double lon) {
  //   via2Lat = lat;
  //   via2Lon = lon;
  //   fetchRoute();
  //   update();
  // }

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

  void removePickUpField() {
    pickUp.clear();
    selectedPickUPLat = 0.0;
    selectedPickUPLon = 0.0;


    fetchRoute();
    update(["map"]);
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
  double estimatedTimeMinutes = 0.0;


  void calculateRouteCenter() {
    if (routePoints.isEmpty) {
      routeCenterPoint = null;
      update(["distance"]);
      return;
    }

    routeCenterPoint = routePoints[routePoints.length ~/ 2];
    update(["distance"]);
  }

  // void calculateRouteDistance() {
  //   if (routePoints.length < 2) {
  //     totalRouteDistanceMiles = 0;
  //     routeCenterPoint = null;
  //     update(["distance"]);
  //     return;
  //   }
  //
  //   final Distance distance = Distance();
  //   double totalMeters = 0;
  //
  //   for (int i = 0; i < routePoints.length - 1; i++) {
  //     totalMeters += distance(routePoints[i], routePoints[i + 1]);
  //   }
  //
  //   //  METERS → MILES
  //   totalRouteDistanceMiles = totalMeters * 0.000621371;
  //
  //   //  ETA CALCULATION
  //   double averageSpeedMph = 30; // change if needed
  //   double timeInHours = totalRouteDistanceMiles / averageSpeedMph;
  //   estimatedTimeMinutes = timeInHours * 60;
  //
  //   // Polyline center
  //   routeCenterPoint = routePoints[routePoints.length ~/ 2];
  //
  //   update(["distance"]);
  // }




  void removeFields(int fieldNumber) {
    if (fieldNumber == 1) {
      viaController1.clear();
      showVia1.value = false;

      // 💥 CRITICAL
      via1Lat = 0.0;
      via1Lon = 0.0;
    }

    else if (fieldNumber == 2) {
      viaController2.clear();
      showVia2.value = false;

      // 💥 CRITICAL
      via2Lat = 0.0;
      via2Lon = 0.0;
    }

    fetchRoute(); //  route recalc
    update(["map"]); //  map rebuild
  }


  Future<void> fetchRoute() async {
    if (selectedPickUPLat == 0.0 ||
        selectedPickUPLon == 0.0 ||
        selectedDropLat == 0.0 ||
        selectedDropLon == 0.0) return;

    final requestId = ++_routeRequestId; // Track latest API call

    String coordinates = "${selectedPickUPLon},${selectedPickUPLat}";

    // VIA 1
    if (via1Lat != 0.0 && via1Lon != 0.0) {
      coordinates += ";${via1Lon},${via1Lat}";
    }

    // VIA 2
    if (via2Lat != 0.0 && via2Lon != 0.0) {
      coordinates += ";${via2Lon},${via2Lat}";
    }

    // DROP
    coordinates += ";${selectedDropLon},${selectedDropLat}";

    final url =
        'https://router.project-osrm.org/route/v1/driving/$coordinates'
        '?overview=full&geometries=geojson';

    try {
      final response = await Dio().get(url);

      // Ignore old responses
      if (requestId != _routeRequestId) return;

      if (response.statusCode == 200) {
        final route = response.data['routes'][0];

        /// 🟣 POLYLINE POINTS
        final coords = route['geometry']['coordinates'];
        routePoints = coords.map<LatLng>((p) {
          return LatLng(
            (p[1] as num).toDouble(),
            (p[0] as num).toDouble(),
          );
        }).toList();

        /// DISTANCE (meters → miles)
        double distanceMeters = (route['distance'] as num).toDouble();
        totalRouteDistanceMiles = distanceMeters * 0.000621371;

        ///  DURATION (seconds → minutes)
        double durationSeconds = (route['duration'] as num).toDouble();
        estimatedTimeMinutes = durationSeconds / 60;

        ///  CENTER POINT FOR DISTANCE LABEL
        if (routePoints.isNotEmpty) {
          routeCenterPoint = routePoints[routePoints.length ~/ 2];
        } else {
          routeCenterPoint = null;
        }

        update(["map", "distance"]);

        ///  AUTO FIT MAP TO ROUTE
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




// Future<void> fetchRoute() async {
  //   if (selectedPickUPLat == 0.0 ||
  //       selectedPickUPLon == 0.0 ||
  //       selectedDropLat == 0.0 ||
  //       selectedDropLon == 0.0) return;
  //
  //   final requestId = ++_routeRequestId; // track latest call
  //
  //   String coordinates = "${selectedPickUPLon},${selectedPickUPLat}";
  //
  //   if (via1Lat != 0.0 && via1Lon != 0.0) {
  //     coordinates += ";${via1Lon},${via1Lat}";
  //   }
  //
  //   if (via2Lat != 0.0 && via2Lon != 0.0) {
  //     coordinates += ";${via2Lon},${via2Lat}";
  //   }
  //
  //   coordinates += ";${selectedDropLon},${selectedDropLat}";
  //
  //   final url =
  //       'https://router.project-osrm.org/route/v1/driving/$coordinates'
  //       '?overview=full&geometries=geojson';
  //
  //   try {
  //     final dio = Dio();
  //     final response = await dio.get(url);
  //
  //     // 🧠 Ignore old responses
  //     if (requestId != _routeRequestId) return;
  //
  //     if (response.statusCode == 200) {
  //       final coords = response.data['routes'][0]['geometry']['coordinates'];
  //
  //       routePoints = coords.map<LatLng>((p) {
  //         return LatLng((p[1] as num).toDouble(), (p[0] as num).toDouble());
  //       }).toList();
  //
  //       update(["map"]); // 👈 only rebuild map\
  //       calculateRouteDistance();
  //
  //       if (isMapReady && mapController != null) {
  //         Future.delayed(const Duration(milliseconds: 200), () {
  //           final bounds = LatLngBounds.fromPoints(routePoints);
  //           mapController!.fitCamera(
  //             CameraFit.bounds(
  //                 bounds: bounds, padding: const EdgeInsets.all(60)),
  //           );
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     print("Route error: $e");
  //   }
  // }

}