import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controller/reebooking/reebookingcontroller.dart';
import '../Widgets/color.dart';
import '../Widgets/elevat_button.dart';
import '../Widgets/textformfield.dart';
import '../payments/paymentscreen.dart';
import '../rides/ridesearchscreen.dart';
import 'extras.dart';

class ReebookingScreen extends StatelessWidget {
  ReebookingScreen({super.key});

  final BookingController reebookingController = Get.put(BookingController());

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
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height*0.8,
                  child: Column(
                    children: [
                      // ============================================  Map
                      Stack(
                        children: [
                          Container(
                            height: 400,
                            decoration:  BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/map_image.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),


                          Positioned(
                            top: 40,
                            left: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: IconButton(
                                icon:  Icon(
                                    Icons.arrow_back,
                                    color:CustomColor.Icon_Color
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                          ),

                        ],
                      ),

                      // ================================================ Vehicle Select
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration:  BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Column(
                            children: [
                               SizedBox(height: 8),
                              Container(
                                height: 5,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: CustomColor.Icon_Color,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                               SizedBox(height: 10),

                              // ==================================================       Vehicle List
                              Expanded(
                                child: ListView.builder(
                                  itemCount: reebookingController.vehicleList.length,
                                  itemBuilder: (context, index) {
                                    var vehicle = reebookingController.vehicleList[index];

                                    return Obx(() {
                                      bool isSelected =
                                          reebookingController.selectedVehicleIndex.value == index;

                                      return GestureDetector(
                                        onTap: () {
                                          reebookingController.selectedVehicleIndex.value = index;
                                        },
                                        child: Container(
                                          margin:  EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          padding:  EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                               // ?Colors.white70.withOpacity(0.4)
                                            ?CustomColor.Container_Colors.withOpacity(0.4)
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(
                                              color: isSelected
                                                  ? CustomColor.Button_background_Color
                                                : Colors.grey.shade400,
                                              width: 2
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Vehicle Info
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${vehicle["name"]}",
                                                    style:  AppTextStyles.regular(),
                                                  ),
                                                   SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                       Icon(Icons.person,
                                                          color: CustomColor.Icon_Color, size: 18),
                                                      Text(" x${vehicle["people"]}",
                                                          style:
                                                           AppTextStyles.medium()),
                                                       Icon(Icons.work,
                                                          color: CustomColor.Icon_Color, size: 18),
                                                      Text(" x${vehicle["cases"]}",
                                                          style:
                                                           AppTextStyles.regular(color: CustomColor.Text_Color)),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                              // ===========================================       vehicle Icon & Price
                                              Row(
                                                children: [
                                                   Icon(Icons.directions_car,
                                                      color: CustomColor.Icon_Color, size: 32),
                                                   SizedBox(width: 10),
                                                  Text(
                                                    "£${vehicle["price"]}",
                                                    style:  AppTextStyles.regular(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                ),
                              ),


                              // ==================================================    Bottom Tab
                              //const Divider(color: Colors.white24),

                               SizedBox(height: 10),
                              //==========================================      Confirm Button


                            ],
                          ),
                        ),
                      ),
                    ],

                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height: MediaQuery.of(context).size.height*0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(15)),
                  color: CustomColor.Container_Colors,
                ),

                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      //color: CustomColor.Container_Colors,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:  [
                          InkWell(
                              onTap:(){
                                Get.to(PaymentScreen());
                              },
                              child: BottomButton(icon: Icons.credit_card, button_name: "Card")),
                          InkWell(
                              onTap:(){ Get.to(ExtrasScreen());
                              },
                              child: BottomButton(icon: Icons.add_circle_outline, button_name: "Extras")),
                          InkWell(
                              onTap:(){

                                Get.bottomSheet(
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: CustomColor.Container_Colors,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    height: 350,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 8),
                                        Container(
                                          height: 5,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: CustomColor.Icon_Color,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        SizedBox(height: 10),

                                        // ---------- Heading ----------
                                        Text(
                                          "Schedule Ride",
                                          style: AppTextStyles.medium(
                                            size: 25,
                                            weight: FontWeight.bold,
                                            color: CustomColor.Text_Color,
                                          ),
                                        ),

                                        const SizedBox(height: 20),

                                        // ---------- Time Buttons ----------
                                        Obx(() => Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // ----- ASAP -----
                                            SizedBox(
                                              width: 100,
                                              height: 45,
                                              child: ElevatedButton(
                                                onPressed: () => reebookingController.setASAP(),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: reebookingController.selectedTimeOption.value == "ASAP"
                                                      ? CustomColor.Button_background_Color
                                                      : Colors.black54,
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                child: Text(
                                                  "ASAP",
                                                  style: AppTextStyles.small(

                                                    weight: reebookingController.selectedTimeOption.value == "ASAP"
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,

                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),

                                            // ----- 15 min -----
                                            SizedBox(
                                              width: 100,
                                              height: 45,
                                              child: ElevatedButton(
                                                onPressed: () => reebookingController.addMinutes(15),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: reebookingController.selectedTimeOption.value == "15 min"
                                                      ?  CustomColor.Button_background_Color
                                                      : Colors.black54,
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                child: Text(
                                                  "15 min",
                                                  style: AppTextStyles.small(

                                                    weight: reebookingController.selectedTimeOption.value == "15 min"
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,

                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),

                                            // ----- 30 min -----
                                            SizedBox(
                                              width: 100,
                                              height: 45,
                                              child: ElevatedButton(
                                                onPressed: () => reebookingController.addMinutes(30),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: reebookingController.selectedTimeOption.value == "30 min"
                                                      ?  CustomColor.Button_background_Color
                                                      : Colors.black54,
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                child: Text(
                                                  "30 min",
                                                  style: AppTextStyles.small(

                                                    weight: reebookingController.selectedTimeOption.value == "30 min"
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),

                                        const SizedBox(height: 25),

                                        // ---------- Date & Time ----------
                                        // Center(
                                        //   child: Row(
                                        //     mainAxisAlignment: MainAxisAlignment.center,
                                        //     children: [
                                        //       // ----- Date Picker -----
                                        //       Obx(() => GestureDetector(
                                        //         onTap: () => reebookingController.pickDate(context),
                                        //         child: Container(
                                        //           width: 150,
                                        //           padding:
                                        //           const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                        //           decoration: BoxDecoration(
                                        //             borderRadius: BorderRadius.circular(10),
                                        //             color: Colors.black,
                                        //           ),
                                        //           child: Row(
                                        //             mainAxisAlignment: MainAxisAlignment.center,
                                        //             children: [
                                        //               const Icon(Icons.calendar_today,
                                        //                   color: Colors.white, size: 18),
                                        //               const SizedBox(width: 6),
                                        //               Flexible(
                                        //                 child: Text(
                                        //                   reebookingController.formattedTime(context),
                                        //                   style: const TextStyle(
                                        //                     fontSize: 15,
                                        //                     fontWeight: FontWeight.bold,
                                        //                     color: Colors.white,
                                        //                   ),
                                        //                   overflow: TextOverflow.ellipsis,
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       )),
                                        //       const SizedBox(width: 15),
                                        //
                                        //       // ----- Time Picker -----
                                        //       Obx(() => GestureDetector(
                                        //         onTap: () => reebookingController.pickTime(context),
                                        //         child: Container(
                                        //           width: 150,
                                        //           padding:
                                        //           const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                        //           decoration: BoxDecoration(
                                        //             borderRadius: BorderRadius.circular(10),
                                        //             color: Colors.black,
                                        //           ),
                                        //           child: Row(
                                        //             mainAxisAlignment: MainAxisAlignment.center,
                                        //             children: [
                                        //               const Icon(Icons.access_time,
                                        //                   color: Colors.white, size: 18),
                                        //               const SizedBox(width: 6),
                                        //               Flexible(
                                        //                 child: Text(
                                        //                   reebookingController.formattedTime(context),
                                        //                   style:  AppTextStyles.regular(
                                        //                     weight: FontWeight.bold,
                                        //                   ),
                                        //                   overflow: TextOverflow.ellipsis,
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       )),
                                        //     ],
                                        //   ),
                                        // ),

                                        // ---------- Date & Time ----------
                                        Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // ----- Date Picker -----
                                              Obx(() => GestureDetector(
                                                onTap: () => reebookingController.pickDate(context),
                                                child: Container(
                                                  width: 150,
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.black,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(Icons.calendar_today, color: Colors.white, size: 18),
                                                      const SizedBox(width: 6),
                                                      Flexible(
                                                        child: Text(
                                                          DateFormat('yyyy-MM-dd')
                                                              .format(reebookingController.selectedDate.value),
                                                          style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                              const SizedBox(width: 15),

                                              // ----- Time Picker (24-hour format) -----
                                              Obx(() => GestureDetector(
                                                onTap: () => reebookingController.pickTime(context),
                                                child: Container(
                                                  width: 150,
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.black,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(Icons.access_time, color: Colors.white, size: 18),
                                                      const SizedBox(width: 6),
                                                      Flexible(
                                                        child: Text(
                                                          reebookingController.formattedTime24(),  // FIXED: now 24-hour time
                                                          style: AppTextStyles.regular(weight: FontWeight.bold),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),


                                        const SizedBox(height: 35),

                                        // ========================================================== Book Ride Button
                                        SizedBox(
                                          height: 55,
                                          width: 250  ,
                                          child: MyElevatedButton(
                                            text: '',
                                            onPressed: () {
                                              Get.to(RideSearchScreen());
                                            },
                                            textWidget:
                                            FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text("Book Ride",style: AppTextStyles.medium(size: 25,weight: FontWeight.bold),
                                                )
                                            ),

                                            fontSize: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: BottomButton(icon: Icons.schedule, button_name: "Schedule")
                          ),
                          InkWell(
                              onTap:(){

                                Get.bottomSheet(
                                  Container(

                                    decoration: const BoxDecoration(
                                      color: CustomColor.Container_Colors,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height * 0.45,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: SingleChildScrollView(
                                       child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 8),
                                          Center(
                                            child: Container(
                                              height: 5,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: CustomColor.Icon_Color,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                      
                                      
                                          Row(
                                              children: [
                                      
                                                SizedBox(width: 20,),
                                      
                                                IconButton(
                                                  icon: Icon(Icons.cancel_outlined, color: Colors.red),
                                                  iconSize: 35,
                                                  onPressed: () => Get.back(),
                                                ),
                                       
                                      
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      "ADD ORDER DETAILS",
                                                      style:  AppTextStyles.medium(

                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                      
                                      
                                                const SizedBox(width: 48),
                                              ]
                                          ),
                                      
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                      
                                      
                                          const Text(
                                            "Order Number",
                                            style: TextStyle(
                                              color: CustomColor.textColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          CustomTextField(
                                            hintText: "Type your order number",
                                            borderRadius: 15,
                                            fillColor: CustomColor.textfield_fill,
                                          ),
                                      
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                                           Text(
                                            "Name on order",
                                            style: AppTextStyles.medium(),
                                          ),
                                          const SizedBox(height: 3),
                                          CustomTextField(
                                            hintText: "Type name on order",
                                            borderRadius: 15,
                                            fillColor: CustomColor.textfield_fill,
                                          ),
                                      
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                                      
                                      
                                          Center(
                                            child: SizedBox(
                                              height:55,
                                              width:250,
                                              child: MyElevatedButton(
                                                text: 'DONE',
                                                textWidget: FittedBox(
                                                  child: Text("Done",style: AppTextStyles.medium(size:25,weight: FontWeight.bold),),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );

                                // Get.bottomSheet(
                                //   Container(
                                //     decoration: const BoxDecoration(
                                //       color: Colors.grey,
                                //       borderRadius: BorderRadius.only(
                                //         topLeft: Radius.circular(30),
                                //         topRight: Radius.circular(30),
                                //       ),
                                //     ),
                                //     height: 400,
                                //     width: MediaQuery.of(context).size.width*1,
                                //     child:Padding(
                                //       padding: const EdgeInsets.all(10.0),
                                //       child: Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           SizedBox(height: 10,),
                                //           Row(
                                //             children: [
                                //               IconButton(
                                //                 icon:  Icon(Icons.cancel_outlined, color:CustomColor.Icon_Color),
                                //                 onPressed: () {
                                //                   Get.back();
                                //                 },
                                //               ),
                                //               SizedBox(width: 10,),
                                //               Text(
                                //                 "ADD ORDER DETAILS",
                                //                 style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                                //               ),
                                //               SizedBox(width: 20,),
                                //               SizedBox(
                                //                 height: 50,
                                //                 width:   100,
                                //                 child: MyElevatedButton(
                                //                   text: 'DONE',
                                //                   onPressed: () {  },
                                //                   backgroundColor: Colors.black,
                                //                   textColor: CustomColor.Icon_Color,
                                //                   fontSize: 15,
                                //                 ),
                                //               ),
                                //
                                //
                                //             ],
                                //           ),
                                //           SizedBox(height: 10,),
                                //           Text(
                                //             "Oder number",
                                //             style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                                //           ),
                                //           SizedBox(height: 3),
                                //
                                //           Padding(
                                //             padding: const EdgeInsets.all(15.0),
                                //             child: CustomTextField(
                                //               // controller: ,
                                //               hintText: "Type your order number",
                                //               borderRadius: 15,
                                //               fillColor: CustomColor.textfield_fill,
                                //             ),
                                //           ),
                                //           SizedBox(height: 5,),
                                //           Text(
                                //             "Name on oder",
                                //             style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                                //           ),
                                //           SizedBox(height: 3),
                                //
                                //           Padding(
                                //             padding: const EdgeInsets.all(15.0),
                                //             child: CustomTextField(
                                //               // controller: ,
                                //               hintText: "Type name on Oder",
                                //               borderRadius: 15,
                                //               fillColor: CustomColor.textfield_fill,
                                //             ),
                                //           ),
                                //
                                //
                                //
                                //
                                //         ],
                                //       ),
                                //     ),
                                //   )
                                // );

                              },
                              child: BottomButton(icon: Icons.shopping_cart_outlined, button_name: "Shopping")),
                          InkWell(
                              onTap:(){Get.toNamed('/PromoScreen');},
                              child: BottomButton(icon: Icons.local_offer_outlined, button_name: "Promo")),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15),
                        // margin: EdgeInsets.symmetric(vertical: 8),
                      //color: CustomColor.Container_Colors,
                      height: 55,
                      width: 250  ,
                      child: MyElevatedButton(
                        text: '',
                        textWidget: FittedBox(
                          child: Text("Confirm Booking",style: AppTextStyles.medium(size: 25 ,weight: FontWeight.bold),),
                        ),
                        onPressed: () {  },
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),

      ),
    );
  }
}





// =========================================================== tab bar  Button

class BottomButton extends StatelessWidget {
  final IconData icon;
  final String button_name ;
  const BottomButton({required this.icon, required this.button_name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: CustomColor.Icon_Color, size: 22),
         SizedBox(height: 3),
        Text(button_name,
            style:  AppTextStyles.small()),
      ],
    );
  }
}
