// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:geolocator/geolocator.dart';
//
// class OpenStreetMapWidget extends StatefulWidget {
//   const OpenStreetMapWidget({super.key});
//
//   @override
//   State<OpenStreetMapWidget> createState() => _OpenStreetMapWidgetState();
// }
//
// class _OpenStreetMapWidgetState extends State<OpenStreetMapWidget> {
//   final MapController _controller = MapController();
//   LatLng? _currentLocation;
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) return;
//
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//
//     if (permission == LocationPermission.deniedForever) return;
//
//     Position position = await Geolocator.getCurrentPosition();
//     setState(() {
//       _currentLocation = LatLng(position.latitude, position.longitude);
//     });
//   }
//
//   Future<void> _moveToCurrentLocation() async {
//     if (_currentLocation != null) {
//       _controller.move(_currentLocation!, 15);
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FlutterMap(
//         mapController: _controller,
//         options: MapOptions(
//           initialCenter: _currentLocation ?? LatLng(0, 0),
//           initialZoom: 5,
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//             userAgentPackageName: 'com.example.customer',
//           ),
//           CurrentLocationLayer(),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _moveToCurrentLocation,
//         backgroundColor: Colors.blue,
//         child: Icon(Icons.my_location, color: Colors.white),
//       ),
//     );
//   }
// }
