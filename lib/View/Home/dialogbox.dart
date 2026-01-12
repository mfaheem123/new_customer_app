import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/all_text.dart';
import '../Widgets/elevat_button.dart';
import '../textstyle/apptextstyle.dart';

class Dialogbox extends StatefulWidget {
  const Dialogbox({super.key});

  @override
  State<Dialogbox> createState() => _DialogboxState();
}

class _DialogboxState extends State<Dialogbox> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      height: 320,
      width: 350,
      child: Column(
        children: [
          const SizedBox(height: 25),
          Center(
            child: Text(
              CustomText.Pick_Up_Location,
              softWrap: true,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: AppTextStyles.heading(
                size: 20,
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              height: 80,
              width: 200,
              child: Text(
                CustomText.Pick_Up_Dialog_Text,
                textAlign: TextAlign.center,
                style: AppTextStyles.regular(),
              ),
            ),
          ),

          SizedBox(
            height: 50,
            width: 250,
            child: MyElevatedButton(
              text: 'Select Current Location',
              fontSize: 14, // increase size
              onPressed: () {},
              textWidget: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Select Current Location',
                  style: AppTextStyles.regular(
                      size: 16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),
          SizedBox(
            height: 50,
            width: 250,
            child: MyElevatedButton(
              text: "",
              onPressed: () {
                Get.toNamed('/RideInfoScreen');
              },
              textWidget: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Select PickUp Location",
                  style: AppTextStyles.medium(
                      size: 16),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
