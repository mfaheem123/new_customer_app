import 'package:customer/View/Widgets/all_text.dart';
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/elevat_button.dart';
import '../Widget/openstrretmap.dart';
import '../Widget/osm.dart';
import '../dashboard.dart';

class PickupScreen extends StatelessWidget {
 const  PickupScreen({super.key});
  // final mapWedgit =OpenStreetMapWidget();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       // backgroundColor: CustomColor.background,
        body: Container(
          height:MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                height: MediaQuery.of(context).size.height*0.85,
                decoration: BoxDecoration(
                  //color: CustomColor.background,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                ),
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
                  Row(
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
                          "Set Location",
                          style: AppTextStyles.heading(
                            size: MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ],
                ),
            SizedBox(height: 70,),

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.location_on,
                    size: 20,
                    color: Colors.red
                    //CustomColor.Icon_Color,
                  ),
                ),
                Text(CustomText.Pickup,style: AppTextStyles.medium(
                ),)
              ],
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("123 Green Valley Street""Springfield, IL 62704 United States",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.medium(),
              ),
            ),

            SizedBox(height: 10,),
            // OpenStreetMapWidget(),//==== map
            //  Container(
            //                    height: MediaQuery.of(context).size.height*0.74,
            //                    child: Image(image: AssetImage("assets/images/map2.png"),fit: BoxFit.cover,),
            // //                  child: OpenStreetMapWidget(),
            //                  ),
          ],
        ),
              ),

                SizedBox(
                  height: 55,
                  width: 250,
                  child: MyElevatedButton(
                    text: '',
                    fontSize: 14,
                    onPressed: () {},
                    textWidget: FittedBox(
                      child: Text(
                        "DONE",
                        style: AppTextStyles.regular(size: 25,weight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),


              // Container(
              //   height: MediaQuery.of(context).size.height*0.1,
              //   padding: const EdgeInsets.all(20.0),
              //   child: SizedBox(
              //     height: 50,
              //     width: 250  ,
              //     child: MyElevatedButton(
              //       text: 'DONE',
              //       onPressed: () {
              //         Get.to(DeshBoard_Screen());
              //       },
              //       fontSize: 20,
              //     ),
              //   ),
              // ),



            ],
          ),
        ),
      ),
    );
  }
}
