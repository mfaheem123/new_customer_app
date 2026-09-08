import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Controller/Ride/RideController.dart';
import '../../Widgets/color.dart';
import '../../textstyle/apptextstyle.dart';

/// Opens the Child Seat dialog matching the reference image with project dark theme
void showChildSeatDialog(BuildContext context) {
  Get.dialog(
    const ChildSeatDialog(),
    barrierDismissible: true,
  );
}

class ChildSeatDialog extends StatelessWidget {
  const ChildSeatDialog({super.key});

  static const Color _greenAccent = Color(0xFF00A859);
  static const Color _mintBg = Color(0xFFDFF5E6);

  @override
  Widget build(BuildContext context) {
    final rideController = Get.isRegistered<RideController>()
        ? Get.find<RideController>()
        : Get.put(RideController());

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.Container_Colors,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withOpacity(0.12),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.45),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 22),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Top drag handle ──
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.28),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Header (Icon + Title & Subtitle) ──
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: _mintBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.child_friendly_rounded,
                      color: _greenAccent,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CHILD SEAT(S)',
                          style: AppTextStyles.heading(
                            size: 16,
                            weight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Let us know how many children are travelling and their age.',
                          style: AppTextStyles.small(
                            size: 11,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ── Number of children label ──
              Text(
                'Number of children',
                style: AppTextStyles.medium(
                  size: 14,
                  weight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              // ── Counter Box with Obx ──
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.22),
                    width: 1.1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Minus button
                    InkWell(
                      onTap: () {
                        if (rideController.childrenCount.value > 0) {
                          rideController.childrenCount.value--;
                        }
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _greenAccent,
                            width: 1.6,
                          ),
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                          color: _greenAccent,
                        ),
                      ),
                    ),

                    // Count wrapped in Obx
                    Obx(
                      () => Text(
                        '${rideController.childrenCount.value}',
                        style: AppTextStyles.heading(
                          size: 20,
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Plus button
                    InkWell(
                      onTap: () {
                        rideController.childrenCount.value++;
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _greenAccent,
                            width: 1.6,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 18,
                          color: _greenAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ── Age(s) label ──
              Text(
                'Age(s)',
                style: AppTextStyles.medium(
                  size: 14,
                  weight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              // ── Age Input Field ──
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.22),
                    width: 1.1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: rideController.ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: AppTextStyles.regular(color: Colors.white, size: 15),
                  cursorColor: _greenAccent,
                  decoration: InputDecoration(
                    hintText: 'e.g. 5',
                    hintStyle: AppTextStyles.regular(color: Colors.white38, size: 14),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Save Button ──
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    rideController.saveChildSeat(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:CustomColor.Button_background_Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Save',
                    style: AppTextStyles.medium(
                      size: 16,
                      weight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ── Cancel Button ──
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color:CustomColor.Button_background_Color,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.medium(
                      size: 16,
                      weight: FontWeight.w600,
                      color: CustomColor.Button_background_Color,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
