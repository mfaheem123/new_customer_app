import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../View/Deshboard/map_widget/map_controller.dart';
import '../../View/Home/model/Airportl_ist_model.dart';
import '../../api_servies/api_servies.dart';
import 'model/pickuplocationmodel.dart';

class SwapController extends GetxController {


  var viaControllers = <TextEditingController>[].obs;
  final TextEditingController pickUp = TextEditingController();
  final TextEditingController dropOff = TextEditingController();

  final TextEditingController viaController1 = TextEditingController();
  final TextEditingController viaController2 = TextEditingController();


  // final mapWedgit =OpenStreetMapWidget();
  final mapC = Get.isRegistered<PickLocationController>()
      ? Get.find<PickLocationController>()
      : Get.put(PickLocationController());

//===============================================   pick UP lication
  void pickupCurrentLocation() {
    // pickUp.text = mapC.currentAddress.value;
    pickUp.text = mapC.address.value;
  }

///======================================================================================  listWidget working and api
  var selectedItem = (0).obs;
  RxInt selectedIndex = 0.obs;




  List<Map<String, dynamic>> iconItems = [
    {"name": "Home", "icon": Icons.home},
    {"name": "Bus", "icon": Icons.airplanemode_active_rounded},
    {"name": "Plane", "icon": Icons.directions_bus},
  ];

  //
  // List<String> busStops = [
  //   "Karachi Cantt Station",
  //   "Lahore Railway Station",
  //   "Islamabad Railway Station",
  //   "Rawalpindi Railway Station",
  //   "Faisalabad Station",
  //   "PIDC Bus Stop",
  //   "Tariq Road Bus Stop",
  //   "Clifton Teen Talwar Bus Stop",
  //   "Shah Faisal Colony Stop",
  //   "Saddar Mobile Market Stop",
  //   "Cantt Station Bus Stop",
  //   "Lahore Thokar Niaz Baig Stop",
  //   "Kalma Chowk Bus Stop",
  //   "Model Town Link Road Stop",
  //   "Anarkali Stop",
  //   "Rawalpindi Faizabad Bus Stop",
  //   "Murree Road Committee Chowk Stop",
  //   "Peshawar Khyber Bazaar Stop",
  //   "Faisalabad D Ground Bus Stop"
  // ];

  /// 🔹 THIS list UI me show ho rahi hai
  List<String> busStops = [];

  /// 🔹 Airport API data
  List<Location> airportLocations = [];

  /// 🔹 Train static data
  List<String> trainStops = [
    "Karachi Cantt Station",
    "Lahore Railway Station",
    "Islamabad Railway Station",
    "Rawalpindi Railway Station",
    "Faisalabad Station",
  ];




  RxBool airportLoading = false.obs;

  Future<void> fetchAirports() async {
    airportLoading.value = true;
    update();

    var response = await ApiService.get(
      "airports/get",   // 👈 base url ApiService me hoga
      auth: true,
    );

    if (response != null && response.statusCode == 200) {
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
  void selectLocationFromList(int index) {
    String address = "";
    double lat = 0.0;
    double lng = 0.0;

    /// ✈️ AIRPORT
    if (selectedIndex.value == 1) {
      final loc = airportLocations[index];
      address = loc.name ?? loc.address ?? "";
      lat = double.tryParse(loc.latitude ?? "0") ?? 0;
      lng = double.tryParse(loc.longitude ?? "0") ?? 0;
    }

    /// 🚆 TRAIN (static — lat/lng nahi)
    else if (selectedIndex.value == 2) {
      address = trainStops[index];
    }

    /// 🏠 ADDRESS (home/work)
    else {
      address = busStops[index];
    }

    /// 🔥 FIELD TARGETING
    switch (activeField.value) {
      case "pickup":
        pickUp.text = address;
        selectedPickUPLat = lat;
        selectedPickUPLon = lng;
        print("🟢 PICKUP SET → $address | Lat: $lat | Lng: $lng");
        break;

      case "via1":
        viaController1.text = address;
        via1Lat = lat;
        via1Lon = lng;
        showVia1.value = true;
        print("🟡 VIA 1 SET → $address | Lat: $lat | Lng: $lng");
        break;

      case "via2":
        viaController2.text = address;
        via2Lat = lat;
        via2Lon = lng;
        showVia2.value = true;
        print("🟠 VIA 2 SET → $address | Lat: $lat | Lng: $lng");
        break;

      case "drop":
        dropOff.text = address;
        selectedDropLat = lat;
        selectedDropLon = lng;
        print("🔴 DROP SET → $address | Lat: $lat | Lng: $lng");
        break;
    }


    fetchRoute();
      update(["map", "distance"]);

  }


  //  void selectLocation(int index) {
 //    if (activeField.value == "pickup") {
 //      selectPickup(index);
 //    } else {
 //      selectDrop(index);
 //    }
 //  }


  //
  // void selectPickup(int index) {
  //   pickUp.text = busStops[index];
  //
  //   // ✈️ AIRPORT selected
  //   if (selectedIndex.value == 1) {
  //     final loc = airportLocations[index];
  //
  //     final   lat = double.tryParse(loc.latitude ?? "");
  //     final lng = double.tryParse(loc.longitude ?? "");
  //
  //     if (lat != null && lng != null) {
  //       selectedPickUPLat = lat;
  //       selectedPickUPLon = lng;
  //
  //       print("✅ Airport Pickup set: $lat , $lng");
  //
  //       fetchRoute(); // 🔥 route auto update
  //       update(["map", "distance"]);
  //     }
  //   }
  // }
  //
  // void selectDrop(int index) {
  //   dropOff.text = busStops[index]; // airport ya train list
  //
  //   // Agar airport drop hai
  //   if (selectedIndex.value == 1) {
  //     final loc = airportLocations[index];
  //
  //     final lat = double.tryParse(loc.latitude ?? "");
  //     final lng = double.tryParse(loc.longitude ?? "");
  //
  //     if (lat != null && lng != null) {
  //       selectedDropLat = lat;
  //       selectedDropLon = lng;
  //
  //       print("✅ Airport Drop set: $lat , $lng");
  //
  //       fetchRoute(); // route auto update
  //       update(["map", "distance"]);
  //     }
  //   }
  // }
  //


  ///----------------------------------------------------------------------------------------  where to go


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
      'services/search',
      //'',
      // fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${pickUp.text.toUpperCase()}',
      auth: true,
      isProgressShow: false,

      queryParameters: {
        'search':pickUp.text
      }
    );

    // var response = await ApiService.get(
    //   '',
    //   fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${pickUp
    //       .text.toUpperCase()}',
    //   auth: true,
    //   isProgressShow: false,
    // );

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

      queryParameters: {
        'search':dropOff.text
      }
    );
    // var response = await ApiService.get(
    //   '',
    //   fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${dropOff.text.toUpperCase()}',
    //   auth: true,
    //   isProgressShow: false, // User loader nahi chahiye
    // );

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
      queryParameters: {
        'search':viaController1.text
      }
    );

    // var response = await ApiService.get(
    //   '',
    //   fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${viaController1
    //       .text.toUpperCase()}',
    //   auth: true,
    //   isProgressShow: false,
    // );

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
      queryParameters: {
        'search':viaController2.text
      }
    );
    // var response = await ApiService.get(
    //   '',
    //   fullUrl: 'http://192.168.110.5:5000/api/services/search?search=${viaController2
    //       .text.toUpperCase()}',
    //   auth: true,
    //   isProgressShow: false,
    // );

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


  // void removeFields(int fieldNumber) {
  //   if (fieldNumber == 1) {
  //     viaController1.clear();
  //     showVia1.value = false;
  //
  //     // 💥 CRITICAL
  //     via1Lat = 0.0;
  //     via1Lon = 0.0;
  //   }
  //
  //   else if (fieldNumber == 2) {
  //     viaController2.clear();
  //     showVia2.value = false;
  //
  //     // 💥 CRITICAL
  //     via2Lat = 0.0;
  //     via2Lon = 0.0;
  //   }
  //
  //   fetchRoute(); //  route recalc
  //   update(["map"]); //  map rebuild
  // }


  Future<void> fetchRoute() async {
    if (selectedPickUPLat == 0.0 ||
        selectedPickUPLon == 0.0 ||
        selectedDropLat == 0.0 ||
        selectedDropLon == 0.0) return;

    // Track latest API call
    final requestId = ++_routeRequestId;

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