import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../Controller/Home/home-controller.dart';
import '../../Deshboard/map_widget/map_polyLine.dart';
import '../../Reebook/Reebookingscreen.dart';
import '../../Widgets/color.dart';
import '../../textstyle/apptextstyle.dart';

class bookingCardwidget extends StatelessWidget {
   bookingCardwidget({super.key,
     required this.referenceNo,
     required this.date,
     required this.time,
     required this.PicUp_Location,
     required this.Drop_of_Location,
     required this.vechileName,
     required this.fare,
     required this.status,
     required this.trip, // ✅ ADD THIS
   });
 String? referenceNo;
 String? date;
 String? time;
 String? PicUp_Location;
 String? Drop_of_Location;
 String? vechileName;
 String? fare;
 String? status;
   final dynamic trip;



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      height: 250,
      width: 350,
      decoration: BoxDecoration(
        //color: CustomColor.Container_Colors,
        borderRadius: BorderRadius.all(
          Radius.circular(15),

        ),
        border: Border.all(
          color: CustomColor.Container_Colors,
          width: 4,
        ),
        //color: Colors.black,
      ),
      child: Column(
        children: [
          //====================================     card header
          Container(
            padding: EdgeInsets.only(left: 10,right: 10, top: 3,bottom: 5),
            color: CustomColor.Container_Colors,
            height: 23,
            child: Row(
              children: [
                Text(
                 referenceNo!,
                  // "Ref: 123456",
                  style: AppTextStyles.small(),
                ),
                Spacer(),
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                  size: 18,
                ),
                Text(
                  date!,
                  // "00/00/2001",
                  style: AppTextStyles.small(),
                ),
                SizedBox(width: 10),
                Text(
                  time!,
                  // "00:00",
                  style: AppTextStyles.small(),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          //==========================        Addresses to Address
          Container(
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// PICKUP
                Expanded(
                  child: Text(
                    PicUp_Location ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.small(),
                  ),
                ),

                /// ARROW
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 26,
                    color: CustomColor.Text_Color,
                  ),
                ),

                /// DROP OFF
                Expanded(
                  child: Text(
                    Drop_of_Location ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.small(),
                  ),
                ),
              ],
            ),
          ),
          //SizedBox(height: 2),
          //=======================================     Rate and status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 70,
            child: Row(
              children: [
                /// LEFT: CAR + FARE
                Row(
                  children: [
                    const Icon(
                      Icons.directions_car,
                      color: CustomColor.Icon_Color,
                    ),
                    const SizedBox(width: 6),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vechileName ?? "",
                          style: AppTextStyles.small(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${fare ?? ""} £",
                          style: AppTextStyles.medium(size: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),

                /// 👉 CENTER STATUS (TRUE CENTER FIX)
                Expanded(
                  child: Center(
                    child: Container(
                      margin:EdgeInsets.only(left: 75) ,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        (status ?? "").toUpperCase(),
                        style: AppTextStyles.small(
                            weight: FontWeight.bold,
                            size: 13
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            //height: 49,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15)
              ),

              //color: CustomColor.background,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: CustomColor.Container_Colors,
                    child: TextButton(
                      onPressed: () {
                        final swapController = Get.isRegistered<SwapController>()
                            ? Get.find<SwapController>()
                            : Get.put(SwapController());
                          swapController.setRouteFromBooking(trip);



                        Get.to(ReebookingScreen(),arguments: trip);
                      },

                      child:  Text(
                        "Rebook Now",
                        style: AppTextStyles.medium(),
                      ),
                    ),
                  ),
                ),
                VerticalDivider(width: 2,color: Colors.white70,),
                Expanded(
                  child: Container(
                    color: CustomColor.Container_Colors,
                    child: TextButton(
                      onPressed: () {
                       // Get.toNamed('/TripDetail');

                        // final swapController = Get.find<SwapController>();
                        final swapController = Get.isRegistered<SwapController>()
                            ? Get.find<SwapController>()
                            : Get.put(SwapController());

                        swapController.setRouteFromBooking(trip);

                        Get.toNamed(
                          '/TripDetail',
                          arguments: {
                            "referenceNo": referenceNo,
                            "date": date,
                            "time": time,
                            "pickup": PicUp_Location,
                            "dropoff": Drop_of_Location,
                            "vehicle": vechileName,
                            "fare": fare,
                            "status": status,

                          },
                        );
                      },
                      child:  Text(
                        "Show Detail",
                        style: AppTextStyles.medium(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),






        ],
      ),
    );
  }
}
