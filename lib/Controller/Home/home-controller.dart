import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  @override
  void onClose() {
   // mapC.dispose();
    super.onClose();
  }


  final TextEditingController pickUp = TextEditingController();
  final TextEditingController dropOff = TextEditingController();
  final TextEditingController viaController1 = TextEditingController();
  final TextEditingController viaController2 = TextEditingController();
  final TextEditingController babyNoteController   = TextEditingController();


  var babyNote = "";

  void babynoteText(){
    babyNote = babyNoteController.text;
    Get.back();
     babyNoteController.clear();
    print(babyNote);
  }





//===============================================   pick UP location


  void pickupCurrentLocation() {
    final loc = mapC.selectedLocation.value;

    if (loc == null) {
      print("❌ Location not ready yet");
      return;
    }

    pickUp.text = mapC.address.value;

    /// 🔥 MAP → ROUTE SYSTEM
    setPickup(loc.latitude, loc.longitude);

    print("🟢 PICKUP FROM CURRENT LOCATION → ${loc.latitude}, ${loc.longitude}");
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
      "airports/get?company_id=1",   //  base url ApiService me hoga
      auth: true,
    );

    if ( response!.statusCode == 200) {
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

      queryParameters: {
        'search':pickUp.text
      }
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

      queryParameters: {
        'search':dropOff.text
      }
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
      queryParameters: {
        'search':viaController1.text
      }
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
      queryParameters: {
        'search':viaController2.text
      }
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
    print("====================================${selectedPickUPLat }   , ${selectedPickUPLon }");
    await fetchRoute();
    update();
  }
  
    void setDrop(double lat, double lon) {
      selectedDropLat = lat;
      selectedDropLon = lon;
      print("Dropoff================================================${selectedDropLat }   , ${selectedDropLon }");
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
  String estimatedTimeText = "";     // 2 hours 3 minutes

  String formatDuration(double totalMinutes) {
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes.round() % 60;

    String h = hours == 1 ? "h" : "h";
    String m = minutes == 1 ? "min" : "min";

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
        selectedDropLon == 0.0) return;

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
        routePoints = coords.map<LatLng>((p) {
          return LatLng(
            (p[1] as num).toDouble(),
            (p[0] as num).toDouble(),
          );
        }).toList();

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
    update(["map"]);
  }





  ///============================================================  map funtion driver detail screen


  void setBookingRoute(booking) {

    /// 🔵 PICKUP
    selectedPickUPLat =
        double.tryParse(booking.pickupLatitude ?? "0") ?? 0.0;

    selectedPickUPLon =
        double.tryParse(booking.pickupLongitude ?? "0") ?? 0.0;

    pickUp.text = booking.pickup ?? "";

    /// 🔴 DROP
    selectedDropLat =
        double.tryParse(booking.dropoffLatitude ?? "0") ?? 0.0;

    selectedDropLon =
        double.tryParse(booking.dropoffLongitude ?? "0") ?? 0.0;

    dropOff.text = booking.dropoff ?? "";

    /// RESET VIA
    via1Lat = 0;
    via1Lon = 0;
    via2Lat = 0;
    via2Lon = 0;

    showVia1.value = false;
    showVia2.value = false;

    /// 🟡 VIA POINTS
    if (booking.viapoints != null && booking.viapoints.isNotEmpty) {

      /// VIA 1
      if (booking.viapoints.length >= 1) {
        var v1 = booking.viapoints[0];

        via1Lat =
            double.tryParse(v1['latitude']?.toString() ?? "0") ?? 0.0;

        via1Lon =
            double.tryParse(v1['longitude']?.toString() ?? "0") ?? 0.0;

        viaController1.text = v1['viapoint'] ?? "";

        showVia1.value = true;
      }

      /// VIA 2
      if (booking.viapoints.length >= 2) {
        var v2 = booking.viapoints[1];

        via2Lat =
            double.tryParse(v2['latitude']?.toString() ?? "0") ?? 0.0;

        via2Lon =
            double.tryParse(v2['longitude']?.toString() ?? "0") ?? 0.0;

        viaController2.text = v2['viapoint'] ?? "";

        showVia2.value = true;
      }
    }

    /// 🚀 ROUTE CALL
    fetchRoute();

    /// UI UPDATE
    update(["map", "distance"]);
  }


}