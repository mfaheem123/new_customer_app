import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../Controller/Home/home-controller.dart';
import '../../../Controller/yourtrip/yourtrip_Controller.dart';
import '../../Widgets/color.dart';
import '../../textstyle/apptextstyle.dart';

class ScheduleBookingCard extends StatelessWidget {
  ScheduleBookingCard({super.key,
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
            color: Colors.transparent,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.only(left: 10,right: 10,bottom: 0,top: 10),
                  height: 80,
                  width: 130,

                  child: Center(
                    child: Text(
                      PicUp_Location!,
                      // "1A Worrior "
                      //     "Garden St.LEO"
                      //     " TN36eb",
                      softWrap: true,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.small(),
                    ),
                  ),
                ),
                SizedBox(width: 10),

                Icon(
                  Icons.arrow_forward_rounded,
                  size: 30,
                  color: CustomColor.Text_Color,
                ),

                SizedBox(width: 10),

                Container(
                  margin: EdgeInsets.only(left: 8),

                  padding: EdgeInsets.all(10),
                  height: 80,
                  width: 130,
                  child: Center(
                    child: Text(
                      Drop_of_Location!,
                      // "Flat  1 "
                      //     "Bland fold"
                      //     "Nw6",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.small(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //SizedBox(height: 2),
          //=======================================     Rate and status
          Container  (
            //color: CustomColor.background,
            padding: EdgeInsets.only(left: 14 ,top: 0),
            height: 70,
            child: Row(
              children: [
                Icon(Icons.directions_car,
                  color: CustomColor.Icon_Color,),
                SizedBox(width: 2,),
                Container(
                  height: 60,
                  padding: EdgeInsets.only(top: 2),
                  child: Column(
                    children: [
                      Text(
                        vechileName!,
                        // " ESTATE CAR",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.small(),
                      ),
                      Text(
                        "${fare!}£",
                        // "&177.00",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.medium(size: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 70),
                //====================================   Status text
                Container(
                  height: 30,
                  width: 100,
                  margin: EdgeInsets.only(left: 25),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (status!).toUpperCase(),
                      // "Cancelled",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: CustomColor.Text_Color,
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

                        final tripController = Get.find<YourTripController>();
                        if (trip.id != null) {
                          tripController.saveBookingId(trip.id!);

                          // 3. Phir direct cancel API call karein
                          tripController.rideCancelApi();
                        } else {
                          print("Error: Booking ID is null");
                        }
                        // Get.to(ReebookingScreen());
                      },

                      child:  Text(
                        "Cancel Booking",
                        style: AppTextStyles.regular(),
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

                        final swapController = Get.find<SwapController>();

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
                        "Track Driver",
                        style: AppTextStyles.regular(),
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
