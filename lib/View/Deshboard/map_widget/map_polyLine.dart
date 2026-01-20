import 'package:customer/Controller/Home/home-controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final SwapController c = Get.find<SwapController>();
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pickup → Drop Map")),

      body: GetBuilder<SwapController>(
        builder: (c) {
          // 🔒 Safety check
          if (c.selectedPickUPLat == 0.0 ||
              c.selectedPickUPLon == 0.0 ||
              c.selectedDropLat == 0.0 ||
              c.selectedDropLon == 0.0) {
            return const Center(
              child: Text("Select Pickup and Drop to view map"),
            );
          }

          final pickupLatLng =
          LatLng(c.selectedPickUPLat, c.selectedPickUPLon);
          final dropLatLng =
          LatLng(c.selectedDropLat, c.selectedDropLon);

          final mapCenter = LatLng(
            (pickupLatLng.latitude + dropLatLng.latitude) / 2,
            (pickupLatLng.longitude + dropLatLng.longitude) / 2,
          );

          return FlutterMap(
            options: MapOptions(
              initialCenter: mapCenter,
              initialZoom: 13,
              onMapReady: () {
                // 🔥 FIT BOTH POINTS ON SCREEN
                mapController.fitCamera(
                  CameraFit.bounds(
                    bounds: LatLngBounds.fromPoints([
                      pickupLatLng,
                      dropLatLng,
                    ]),
                    padding: const EdgeInsets.all(60),
                  ),
                );
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.customer',
              ),

              // ✅ POLYLINE (GENERIC FIX)
              PolylineLayer(
                polylines: <Polyline<Object>>[
                  Polyline<Object>(
                    points: [pickupLatLng, dropLatLng],
                    strokeWidth: 4,
                    color: Colors.blue,
                  ),
                ],
              ),

              // ✅ MARKERS (flutter_map 8.x)
              MarkerLayer(
                markers: [
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
                  Marker(
                    point: dropLatLng,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),

      bottomNavigationBar: GetBuilder<SwapController>(
        builder: (c) => Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                "${c.pickUp.text} → ${c.dropOff.text}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
