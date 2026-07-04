  import 'package:flutter/material.dart';
  import 'package:get/get.dart';

  import '../textstyle/apptextstyle.dart';
  import 'color.dart';

  class LocationPermissionDialog {
    static Future<void> show({
      required VoidCallback onPressed,
    }) async {
      await Get.dialog(
        PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 22,
              ),
              decoration: BoxDecoration(
                color: CustomColor.Container_Colors,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Location Icon
                  Container(
                    height: 65,
                    width: 65,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "Enable Location",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading(),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Location access is required to continue using the app. Please enable your location services and grant permission to proceed.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular(),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        CustomColor.Button_background_Color,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Grant Permission",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }