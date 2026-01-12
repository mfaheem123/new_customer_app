import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/elevat_button.dart';
import 'package:customer/View/Widgets/textformfield.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stepper_touch/stepper_touch.dart';

import '../Widgets/all_text.dart';

class ExtrasScreen extends StatelessWidget {
  const ExtrasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: CustomColor.background,
        body: SingleChildScrollView(
          child: Container(
            height:MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back,
                          size: MediaQuery.of(context).size.width * 0.06,
                          color: CustomColor.Icon_Color,
                        ),
                      ),


                      Expanded(
                        child: Center(
                          child: Text(
                            "Extras",
                            style: AppTextStyles.heading(
                              size: MediaQuery.of(context).size.width * 0.06,
                            ),
                          ),
                        ),
                      ),

                      // RIGHT SIDE DUMMY BOX
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                    ],
                  ),
                ),


                // Container(
                //   height: MediaQuery.of(context).size.height * 0.1,
                //   padding: EdgeInsets.symmetric(horizontal: 8),
                //   decoration: BoxDecoration(
                //     //color: CustomColor.Container_Colors,
                //     borderRadius: BorderRadius.only(
                //       bottomLeft: Radius.circular(20),
                //       bottomRight: Radius.circular(20),
                //     ),
                //   ),
                //   child: Row(
                //     children: [
                //       IconButton(
                //         onPressed: () {
                //           Get.back();
                //         },
                //         icon: Icon(
                //           Icons.arrow_back,
                //           size: MediaQuery.of(context).size.width * 0.06,
                //           color: CustomColor.Icon_Color,
                //         ),
                //       ),
                //
                //       // SizedBox(width: 5),
                //
                //       Expanded(
                //         child: Center(
                //           child: Text(
                //             "Extras",
                //             style: AppTextStyles.heading(
                //               size: MediaQuery.of(context).size.width * 0.06,
                //
                //             ),
                //           ),
                //         ),
                //       ),
                //
                //
                //     ],
                //   ),
                // ),



                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     IconButton(
                //       onPressed: () => Get.back(),
                //       icon: const Icon(
                //         Icons.arrow_back,
                //         color: CustomColor.Text_Color,
                //         size: 25,
                //       ),
                //     ),
                //
                //      Text(
                //       "Extras",
                //       style: AppTextStyles.heading()),
                //     const Spacer(),
                //   ],
                // ),



                Padding(
                    padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      // 📝 TextField Section
                      Container(
                        //margin: const EdgeInsets.all(12),
                        child: CustomTextField(
                          hintText: "Enter ",
                          borderRadius: 15,
                         // fillColor: CustomColor.textfield_fill,
                          maxlength: 30,
                          maxLines: 3,
                          contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                        ),
                      ),

                      const SizedBox(height: 20),


                      Row(
                        children: [
                          const Text(
                            "Meet and greet services()",
                            style: TextStyle(
                                color: CustomColor.Text_Color,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Container(
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(26)),
                                color: CustomColor.Container_Colors
                            ),
                            child: StepperTouch(
                              initialValue: 0,
                              direction: Axis.horizontal,
                              withSpring: false,
                              onChanged: (int value) {
                                print('new value $value');
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),


                      Row(
                        children: [
                          const Text(
                            "Water / Extras",
                            style: TextStyle(
                                color: CustomColor.Text_Color,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Container(
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(26)),
                                color: CustomColor.Container_Colors
                            ),
                            child: StepperTouch(
                              initialValue: 0,
                              direction: Axis.horizontal,
                              withSpring: false,
                              onChanged: (int value) {
                                print('new value $value');
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),


                      Row(
                        children: [
                          const Text(
                            "MPV4",
                            style: TextStyle(
                                color: CustomColor.Text_Color,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Container(
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(26)),
                                color: CustomColor.Container_Colors
                            ),
                            child: StepperTouch(
                              initialValue: 0,
                              direction: Axis.horizontal,
                              withSpring: false,
                              onChanged: (int value) {
                                print('new value $value');
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),


                      Row(
                        children: [

                          Column(
                            children: const [
                              Text(
                                "Water / Extras",
                                style: TextStyle(color: CustomColor.Text_Color, fontSize: 15),
                              ),
                              Text(
                                "17.00",
                                style: TextStyle(
                                    color: CustomColor.Text_Color,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Padding(
                            padding: EdgeInsetsGeometry.only(top: 20),
                              child: Icon(Icons.add, size: 25, color: CustomColor.Icon_Color)),
                          const SizedBox(width: 10),
                          Column(
                            children: const [
                              Text(
                                "Extra Charges",
                                style: TextStyle(color: CustomColor.Text_Color, fontSize: 15),
                              ),
                              Text(
                                "17.00",
                                style: TextStyle(
                                    color: CustomColor.Text_Color,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: const Text(
                              "=   34.00",
                              style: TextStyle(
                                  color: CustomColor.Text_Color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),


                      Container(

                        height: 55,
                        width: 250,
                        child: MyElevatedButton(
                          text: '',
                          textWidget: FittedBox(
                            child: Text("Done",style: AppTextStyles.medium(size:25,weight: FontWeight.bold),),
                          ),
                          onPressed: () {  },
                        ),
                      ),
                    ],
                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
