
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Controller/payment/paymentcontroller.dart';
import '../Widgets/all_text.dart';
import '../Widgets/color.dart';
import '../Widgets/elevat_button.dart';
import '../thanks/thanksscreen.dart';
import 'DriverDetailscreen.dart';

class RideCompleteScreen extends StatelessWidget {

  final PaymentController  paymentController= Get.put(PaymentController());
  RideCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: CustomColor.background,
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
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height*0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(

                          height: MediaQuery.of(context).size.height * 0.1,
                         //padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                           // color: CustomColor.Container_Colors,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: MediaQuery.of(context).size.width * 0.06,
                                  color: CustomColor.Icon_Color,
                                ),
                              ),

                              SizedBox(width: 5),

                              Expanded(
                                child: Center(
                                  child: Text(
                                    CustomText.Ride_Complete,
                                    style: AppTextStyles.heading(
                                      size: MediaQuery.of(context).size.width * 0.06,

                                    ),
                                  ),
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.edit_notifications_sharp,
                                  size: MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),

                      SizedBox(height: 30,),

                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.13,
                          width: MediaQuery.of(context).size.width ,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Container(
                            //padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  CustomText.Reached_Destination,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.medium(),
                                ),
                                SizedBox(height: 10),
                                Icon(Icons.favorite,color: Colors.black,size: 25,),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30,),



                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on,size: 25,color: Colors.red),
                          //CustomColor.Icon_Color,),
                          SizedBox(width: 10,),

                          Expanded(
                            child: Text(
                              "1A Worrior Garden St.LEO "
                                  " Worrior Garden St.LEO TN36eb",
                              softWrap: true,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: AppTextStyles.medium(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),

                    Row(
                        children: [
                          Icon(Icons.money,size: 25,color: CustomColor.Icon_Color,),
                          SizedBox(width: 15,),

                          Text(
                            "3.000",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.medium(),
                          ),
                          Icon(Icons.currency_pound_sharp,size: 25,color: CustomColor.Icon_Color,),


                        ],
                      ),
                      SizedBox(height: 15,),

                      Text(
                        "Payment Method",
                        style: AppTextStyles.medium(
                        ),
                      ),

                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Radio<String>(
                            value: 'Cash',
                            groupValue: paymentController.paymentMethod.value,
                            onChanged: paymentController.setPaymentMethod,
                            activeColor: CustomColor.Icon_Color,
                            fillColor: MaterialStateProperty.all<Color>(CustomColor.Container_Colors),

                          ),

                          Text(
                            "Cash",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.medium(

                            ),
                          ),

                           SizedBox(width: 20),

                          Radio<String>(
                            value: 'Credit Card',
                            groupValue: paymentController.paymentMethod.value,
                            onChanged: paymentController.setPaymentMethod,
                            activeColor: CustomColor.Icon_Color,
                            fillColor: MaterialStateProperty.all<Color>(CustomColor.Container_Colors),
                          ),
                          Text(
                            "Credit Card",
                            textAlign: TextAlign.center,
                            style:  AppTextStyles.medium()
                          ),
                        ],
                      )),

                      SizedBox(height: 50,),

                      Center(
                        child:  SizedBox(
                          height: 55,
                          width: 250  ,
                          child: MyElevatedButton(
                            text: '',
                            onPressed: () {
                              Get.toNamed('/ThanksScreen');
                            },
                            textWidget:
                            FittedBox(
                                //fit: BoxFit.scaleDown,
                                child: Text('Done',style: AppTextStyles.medium(size: 25 ,weight: FontWeight.bold),
                                )
                            ),


                          ),
                        ),

                      ),





                    ],
                  ),
                ),
                Spacer(),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                 decoration: BoxDecoration(
                   color: CustomColor.Container_Colors,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                 ),
                  //height: MediaQuery.of(context).size.height*0.15,
                  child:   Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            const phone = "tel://03001234567";
                            final Uri phoneUri = Uri.parse(phone);

                            try {
                              bool launched = await launchUrl(
                                phoneUri,
                                mode: LaunchMode.externalApplication,
                              );

                              if (!launched) {
                                print("Dialer app not found");
                              }
                            } catch (e) {
                              print("Error: $e");
                            }
                          },
                          child: Text(
                            "Help And Support Please Call",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.medium(),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.call,size: 25,
                        color: CustomColor.Icon_Color,
                      ),



                    ],
                  ),
                ),

              ],
            ),
          ),

        )
    );
  }
}
