// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';
//
//
//
// class OpenStreetMapWidget extends StatefulWidget {
//   const OpenStreetMapWidget({super.key});
//   @override
//   State<OpenStreetMapWidget> createState() => _OsmState();
// }
//
// class _OsmState extends State<OpenStreetMapWidget> {
//   LatLng? _currentPosition;
//   final MapController _mapController = MapController();
//   String? _currentAddress = "Fetching location...";
//   bool _isLoadingAddress = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//   }
//
//   ///  1: Get user location
//   Future<void> _getUserLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return;
//     }
//
//     // Check and request permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return;
//     }
//
//     //  Get current position
//     Position position = await Geolocator.getCurrentPosition(
//       locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
//     );
//     //  Update map and position
//     LatLng latLng = LatLng(position.latitude, position.longitude);
//     _updateAddress(latLng);
//
//     if (_currentPosition == null) {
//       setState(() {
//         _currentPosition = latLng;
//       });
//     }
//
//
//     _mapController.move(_currentPosition!, 15.0);
//   }
//
//   //  Convert LatLng → Human-readable address
//   Future<void> _updateAddress(LatLng position) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//       if (placemarks.isNotEmpty) {
//         final place = placemarks.first;
//         setState(() {
//           _currentAddress =
//           "${place.name ?? ''}, "
//               "${place.street ?? ''}, "
//               "${place.subLocality ?? ''}, "
//               "${place.locality ?? ''}, "
//               "${place.country ?? ''}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _currentAddress = "Address not found";
//       });
//     } finally {
//       setState(() {
//         _isLoadingAddress = false;
//       });
//     }
//   }
//
//   // Step 3: Listen to map movements
//   void _onPositionChanged(position, bool hasGesture) {
//     if (position.center != null && hasGesture) {
//       final latLng = position.center!;
//       setState(() {
//         _currentPosition = latLng;
//         _isLoadingAddress = true;
//       });
//       _updateAddress(latLng);
//     }
//   }
//
//
//
//   // Move map to current location on button press
//   Future<void> _moveCurrentLocation() async {
//     if (_currentPosition != null) {
//       _mapController.move(_currentPosition!, 17.0);
//     }
//   }
//
//   // ///  Step 4: Handle map tap — move marker & update address
//   // void _onMapTap(TapPosition tapPosition, LatLng latlng) {
//   //   setState(() {
//   //     _currentPosition = latlng;
//   //     _currentAddress = "Updating address...";
//   //   });
//   //   _updateAddress(latlng);
//   // }
//   //
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  _currentPosition == null
//           ? Center(child: CircularProgressIndicator())
//           : FlutterMap(
//         mapController: _mapController,
//         options: MapOptions(
//           initialCenter: _currentPosition!,
//           initialZoom: 13,
//           onPositionChanged: _onPositionChanged,
//         ),
//         children: [
//           TileLayer(
//             urlTemplate:
//             'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//           ),
//
//           //  Fixed Center Marker
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 40,
//                   width: 200,
//                   padding: EdgeInsets.only(top: 5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: Colors.blue,
//                   ),
//                   child: Text(
//                     _currentAddress ?? "Loading address...",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 8,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//                 IgnorePointer(
//                   child: Icon(
//                     Icons.location_on,
//                     size: 50,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           Container(
//             margin: EdgeInsets.only(left: 350, top: 20),
//             height: 55,
//             width: 55,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.grey,
//             ),
//             child: Center(
//               child: IconButton(
//                 onPressed: _moveCurrentLocation,
//                 icon: Icon(Icons.my_location, size:30),
//               ),
//             ),
//           ),
//
//           // MarkerLayer(
//           //   markers: [
//           //     Marker(
//           //       point: _currentPosition!,
//           //       child: const Icon(
//           //         Icons.location_on,
//           //         size: 50,
//           //         color: Colors.red,
//           //       ),
//           //     ),
//           //   ],
//           // ),
//         ],
//       ),
//     );
//   }
// }
