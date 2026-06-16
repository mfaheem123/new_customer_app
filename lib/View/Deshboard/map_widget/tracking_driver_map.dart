import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../../Controller/Home/home-controller.dart';

class TrackingMap extends StatefulWidget {
  final SwapController c;
  const TrackingMap({super.key, required this.c});

  @override
  State<TrackingMap> createState() => _TrackingMapState();
}

class _TrackingMapState extends State<TrackingMap> {
  final MapController mapController = MapController();

  void _fitMapOnce(SwapController c) {
    if (c.hasFittedMap) return;
    if (c.routePointsTraking.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (c.routePointsTraking.isEmpty) return;

      mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds.fromPoints(c.routePointsTraking),
          padding: const EdgeInsets.all(60),
        ),
      );
    });

    c.hasFittedMap = true;
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.c;

    return Obx(() {
      if (c.selectedPickUPLat == 0.0 ||
          c.selectedDropLat == 0.0) {
        return const Center(
          child: Text("Select Pickup & Drop"),
        );
      }

      final pickup = LatLng(c.selectedPickUPLat, c.selectedPickUPLon);
      final drop = LatLng(c.selectedDropLat, c.selectedDropLon);

      _fitMapOnce(c);

      return FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(
            (pickup.latitude + drop.latitude) / 2,
            (pickup.longitude + drop.longitude) / 2,
          ),
          initialZoom: 10,
        ),

        children: [
          // ================= TILE LAYER =================
          TileLayer(
            urlTemplate:
            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),

          // ================= POLYLINE (SAFE) =================
          PolylineLayer(
            polylines: [
              if (c.routePointsTraking.isNotEmpty)
                Polyline(
                  points: c.routePointsTraking.toList(),
                  strokeWidth: 4,
                  color: Colors.deepPurple,
                ),
            ],
          ),

          // ================= MARKERS =================
          MarkerLayer(
            markers: [
              Marker(
                point: pickup,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 35,
                ),
              ),
              Marker(
                point: drop,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 35,
                ),
              ),
            ],
          ),

          // ================= DRIVER MARKER =================
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(
                  c.driverLat.value,
                  c.driverLng.value,
                ),
                width: 60,
                height: 60,
                child: const Icon(
                  Icons.local_taxi,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}