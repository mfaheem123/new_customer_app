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

  void _fitMap(SwapController c) {
    if (c.hasFittedMap) return;
    if (c.routePointsTraking.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final points = [
        LatLng(c.selectedPickUPLat, c.selectedPickUPLon),
        LatLng(c.selectedDropLat, c.selectedDropLon),
        ...c.routePointsTraking,
      ];

      mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds.fromPoints(points),
          padding: const EdgeInsets.all(90),
        ),
      );
    });

    c.hasFittedMap = true;
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.c;

    return GetBuilder<SwapController>(
      id: "map",
      builder: (c) {
        if (c.selectedPickUPLat == 0.0 || c.selectedDropLat == 0.0) {
          return const Center(child: Text("Select Pickup & Drop"));
        }

        final pickup = LatLng(c.selectedPickUPLat, c.selectedPickUPLon);
        final drop = LatLng(c.selectedDropLat, c.selectedDropLon);

        _fitMap(c);

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

            // ================= TILE =================
            TileLayer(
              urlTemplate:
              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),

            // ================= POLYLINE (FIXED) =================
            PolylineLayer(
              polylines: [
                if (c.routePointsTraking.isNotEmpty)
                  Polyline(
                    points: List<LatLng>.from(c.routePointsTraking),
                    strokeWidth: 5,
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

            // ================= DRIVER =================
            MarkerLayer(
              markers: [
                if (c.driverLat.value != 0.0 && c.driverLng.value != 0.0)
                  Marker(
                    point: LatLng(c.driverLat.value, c.driverLng.value),
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
      },
    );
  }
}