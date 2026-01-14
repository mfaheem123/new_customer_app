import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

import 'map_controller.dart';


class OpenStreetMapView extends StatelessWidget {
  OpenStreetMapView({super.key});
  final mapC = Get.put(MapLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (mapC.currentPosition.value == null) {
          return const Center(child: CircularProgressIndicator());
        }


        return FlutterMap(
          mapController: mapC.mapController,
          options: MapOptions(
           initialCenter: mapC.currentPosition.value!,
            initialZoom: 13,


            onMapReady: () {
              mapC.mapController.move(mapC.currentPosition.value!, 15);
            },
           onPositionChanged: mapC.onMapMove,
         ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.customer',
                //urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'
            ),

            // Center Marker + Address
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 220,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Obx(() => Text(
                      mapC.currentAddress.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 10),
                    )),
                  ),
                  const Icon(Icons.location_on, color: Colors.red, size: 50),
                ],
              ),
            ),

            // My Location Button
            Positioned(
              right: 15,
              top: 50,
              child: FloatingActionButton(
                onPressed: mapC.moveToCurrent,
                child: const Icon(Icons.my_location),
              ),
            ),
          ],
        );
      }),
    );
  }
}
