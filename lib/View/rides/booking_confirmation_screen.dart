import 'package:customer/View/Widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/Ride/RideController.dart';
import '../../Routing/routes_name.dart';
import '../Widgets/elevat_button.dart';
import '../textstyle/apptextstyle.dart';

class BookingConfirmationScreen extends StatefulWidget {
  BookingConfirmationScreen({super.key});


  @override
  State<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  final rideController = Get.isRegistered<RideController>()
      ? Get.find<RideController>()
      : Get.put(RideController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      rideController.getBookingById();
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   rideController.getBookingById();
  // }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
      builder: (controller) {

        if (controller.bookingData == null ||
            controller.bookingData!.booking == null) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) {
                Get.offAllNamed(routesName.DeshBoard_Screen);
              }
            },
            child: Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 30, 1, 44),
                      Color.fromARGB(255, 227, 194, 242),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        }

        // if (controller.bookingData == null ||
        //     controller.bookingData!.booking == null) {
        //   return Scaffold(
        //     body:
        //     // controller.bookingData == null ||
        //     //     controller.bookingData!.booking == null ? CircularProgressIndicator():
        //     Container(
        //       width: double.infinity,
        //       height: double.infinity,
        //       decoration: const BoxDecoration(
        //         gradient: LinearGradient(
        //           colors: [
        //             Color.fromARGB(255, 30, 1, 44),
        //             Color.fromARGB(255, 227, 194, 242),
        //           ],
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter,
        //         ),
        //       ),
        //       child: const Center(
        //         child: Text("No Booking Found"),
        //       ),
        //     ),
        //   );
        // }

        final booking = controller.bookingData!.booking!;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              Get.offAllNamed(routesName.DeshBoard_Screen);
            }
          },
          child: SafeArea(
            child: Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 30, 1, 44),
                      Color.fromARGB(255, 227, 194, 242),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [

                      /// Success Icon
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                          "Booking Confirmed",
                          style:AppTextStyles.heading()
                      ),

                      const SizedBox(height: 8),

                      Text(
                          "Thank you for choosing Nexus.",
                          style: AppTextStyles.regular()

                      ),

                      const SizedBox(height: 30),

                      /// Company + Ref Card
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color:  CustomColor.Container_Colors,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [

                                  Text(
                                    "Nexus Tech\nGroups Ltd",
                                    style: AppTextStyles.medium(
                                        weight: FontWeight.bold,
                                        color: Colors.amber
                                    ),
                                  ),

                                  SizedBox(height: 8),

                                  Row(
                                    children: [
                                      Icon(Icons.phone, color: Colors.amber,size: 22,),
                                      SizedBox(width: 5,),
                                      Text(
                                        booking.mobile ?? "",
                                        style: AppTextStyles.small(),

                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),

                            Container(
                              width: 1,
                              height: 90,
                              color: Colors.white24,
                            ),

                            const SizedBox(width: 15),

                            Expanded(
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child:  Icon(
                                          Icons.person,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width:5 ),

                                      Expanded(
                                        child: Text(
                                          ( booking.name ?? "").toUpperCase(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: AppTextStyles.medium(),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  Row(
                                    children: [
                                      Icon(Icons.numbers_outlined,color: Colors.amber,size: 15,),
                                      SizedBox(width: 5,),
                                      Text(
                                          "Reference",
                                          style: AppTextStyles.regular()
                                      ),
                                    ],
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Text(
                                        booking.referenceNumber ?? "",
                                        style:AppTextStyles.medium()

                                    ),
                                  )

                                ],
                              ),
                            )

                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// Booking Details Card
                      Container(
                        decoration: BoxDecoration(
                          // color: const Color(0xff4A0A73),
                          color: CustomColor.Container_Colors   ,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [

                            detailTile(
                              Icons.location_on,
                              "Pickup",
                              booking.pickup ?? "",
                            ),

                            divider(),

                            detailTile(
                              Icons.flag,
                              "Dropoff",
                              booking.dropoff ?? "",
                            ),

                            divider(),

                            detailTile(
                              Icons.phone,
                              "Mobile",
                              booking.mobile ?? "",
                            ),

                            divider(),

                            detailTile(
                              Icons.email,
                              "Email",
                              booking.email ?? "",
                            ),

                            divider(),

                            detailTile(
                              Icons.calendar_month,
                              "Date",
                              booking.pickupDate ?? "",
                            ),

                            divider(),

                            detailTile(
                              Icons.access_time,
                              "Time",
                              booking.pickupTime ?? "",
                            ),

                            divider(),

                            detailTile(
                              Icons.local_taxi,
                              "Vehicle",
                              ( booking.vehicleType?.name ?? "").toUpperCase(),
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: MyElevatedButton(
                          text: '',
                          onPressed: () async {
                            Get.offAllNamed(
                              routesName.DeshBoard_Screen,
                            );
                          },

                          textWidget: FittedBox(
                            child: Text(
                              'Continue',
                              style: AppTextStyles.medium(
                                  size: 25,
                                  weight: FontWeight.bold),
                            ),
                          ),
                        ),

                      ),

                      const SizedBox(height: 15),

                      /// PDF Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            rideController.generatePdf();
                          },
                          icon: const Icon(
                            Icons.picture_as_pdf,
                            color: CustomColor.Button_background_Color,
                          ),
                          label: const Text(
                            "Download PDF",
                            style:
                            TextStyle(
                              color: CustomColor.Button_background_Color,
                              fontSize: 17,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: CustomColor.Button_background_Color,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                    ],
                  ),
                ),
              ),// <-- Aap ki puri existing UI
            ),
          ),
        );
      },
    );
  }


  Widget divider() {
    return const Divider(
      color: Colors.white12,
      height: 24,
    );
  }

  Widget detailTile(
      IconData icon,
      String title,
      String value,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Icon(
          icon,
          color: Colors.amber,
          size: 22,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                  title,
                  style: AppTextStyles.small(
                      color: Colors.grey
                  )

              ),

              const SizedBox(height: 4),
              Text(
                  value,
                  style: AppTextStyles.medium(
                      size: 16
                    // weight: FontWeight.w600,
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}