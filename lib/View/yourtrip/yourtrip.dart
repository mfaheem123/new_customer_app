import 'package:customer/View/Widgets/all_text.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:customer/View/yourtrip/widget/card%20widget.dart';
import 'package:customer/View/yourtrip/widget/schedule_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/yourtrip/yourtrip_Controller.dart';
import '../Reebook/Reebookingscreen.dart';
import '../Widgets/color.dart';

  class Yourtrip extends StatefulWidget {
  Yourtrip({super.key});

  @override
  State<Yourtrip> createState() => _YourtripState();
}

class _YourtripState extends State<Yourtrip> {
  final YourTripController tripControl = Get.put(YourTripController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tripControl.ChangeIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: CustomColor.background,
        body: Container(
          height:MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 30, 1, 44),
                Color.fromARGB(255, 227, 194, 242)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [

              Container(

                height: MediaQuery.of(context).size.height * 0.1,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  //color: CustomColor.Container_Colors,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: CustomColor.Icon_Color,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          CustomText.Your_Trip,
                          style: AppTextStyles.heading(),
                        ),
                      ),
                    ),

                    // Back button ke barabar empty space
                    const SizedBox(width: 48),
                  ],
                ),
              ),




              SizedBox(height: 10),

              Obx(
                () => Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: tripControl.selectedIndex.value == 0
                      ? CustomColor.Button_background_Color
                        : CustomColor.Container_Colors,

                      ),

                      child: TextButton(
                        onPressed: () {
                          tripControl.ChangeIndex(0);
                          //tripControl.getBookingScheduleApi();
                        },
                        child: Text(
                          "SCHEDULED",
                          style: AppTextStyles.medium(
                           // fontSize: 20,
                            color: tripControl.selectedIndex.value == 0?
                                CustomColor.Button_Text_Color
                                :CustomColor.Text_Color,

                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: tripControl.selectedIndex.value == 1
                            ?CustomColor.Button_background_Color
                            : CustomColor.Container_Colors,
                      ),
                      child: TextButton(
                        onPressed: () {
                          tripControl.ChangeIndex(1);
                         // tripControl.getBookingHistoryApi();
                        },
                        child: Text(
                          "HISTORY",
                          style: AppTextStyles.medium(
                            // fontSize: 20,
                            color: tripControl.selectedIndex.value == 1?
                            CustomColor.Button_Text_Color
                                :CustomColor.Text_Color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              
              //ListView.builder(itemBuilder: itemBuilder),

              /// 🔹 BODY
              Expanded(
                child: GetBuilder<YourTripController>(
                  builder: (controller) {

                    /// 📅 INDEX 0 → ALWAYS SHOW THIS

                    // if (controller.selectedIndex.value == 0) {
                    //   return Center(
                    //     child: Text(
                    //       "No Scheduled Trips",
                    //       style: AppTextStyles.heading(),
                    //     ),
                    //   );
                    // }
                    if (controller.selectedIndex.value == 0) {

                      /// 🔄 LOADING
                      if (controller.scheduleLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      /// ❌ EMPTY
                      if (controller.bookingScheduleModel == null ||
                          controller.bookingScheduleModel!.bookings == null ||
                          controller.bookingScheduleModel!.bookings!.isEmpty) {
                        return Center(
                          child: Text(
                            "No Scheduled Trips",
                            style: AppTextStyles.heading(),
                          ),
                        );
                      }

                      /// ✅ LIST
                      return ListView.builder(
                        itemCount:
                        controller.bookingScheduleModel!.bookings!.length,
                        itemBuilder: (context, index) {

                          var trip =
                          controller.bookingScheduleModel!.bookings![index];

                          return ScheduleBookingCard(
                            referenceNo: trip.referenceNumber ?? "",
                            date: trip.pickupDate ?? "",
                            time: trip.pickupTime ?? "",
                            PicUp_Location: trip.pickup ?? "",
                            Drop_of_Location: trip.dropoff ?? "",
                            vechileName: trip.vehicleType?.name ?? "",
                            fare: trip.fares ?? "",
                            status: trip.bookingStatus?.bookingStatus ?? "",
                            trip: trip,
                          );
                        },
                      );
                    }

                    /// 📜 INDEX 1 → HISTORY
                    if (controller.selectedIndex.value == 1) {

                      /// 🔄 LOADING
                      if (controller.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      /// ❌ EMPTY
                      if (controller.bookingHistoryModel == null ||
                          controller.bookingHistoryModel!.bookings == null ||
                          controller.bookingHistoryModel!.bookings!.isEmpty) {
                        return Center(
                          child: Text(
                            "No History Found",
                            style: AppTextStyles.heading(),
                          ),
                        );
                      }

                      /// ✅ LIST
                      return ListView.builder(
                        itemCount:
                        controller.bookingHistoryModel!.bookings!.length,
                        itemBuilder: (context, index) {

                          var trip = controller.bookingHistoryModel!.bookings![index];

                          return bookingCardwidget(
                            referenceNo: trip.referenceNumber ?? "",
                            date: trip.pickupDate ?? "",
                            time: trip.pickupTime ?? "",
                            PicUp_Location: trip.pickup ?? "",
                            Drop_of_Location: trip.dropoff ?? "",
                            vechileName: trip.vehicleType?.name ?? "",
                            fare: trip.fares ?? "",
                            status:
                            trip.bookingStatus?.bookingStatus ?? "",
                            trip: trip, // 🔥 IMPORTANT
                          );
                        },
                      );
                    }

                    return SizedBox(); // fallback
                  },
                ),
              )



            ],
          ),
        ),
      ),
    );
  }
}
