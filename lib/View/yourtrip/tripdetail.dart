
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Deshboard/Widget/openstrretmap.dart';
import '../Deshboard/Widget/osm.dart';
import '../Widgets/all_text.dart';

class TripDetail extends StatelessWidget {
  const TripDetail({super.key});

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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  height: 40,
                  width: 40,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back, size: 25, color:CustomColor.Icon_Color),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.22,),
                Text(
                  CustomText.Trip_Detail,
                  style: AppTextStyles.heading(
                  ),
                ),

              ],
            ),

            //=========================  Map
            // Container(
            //   height: 300,
            //   child:  OpenStreetMapWidget(),
            // ),

            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  height: 100,
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Booking Status",
                        style: AppTextStyles.regular(
                          color: Colors.blueGrey
                      ),
                      ),
                      Text("Cancelled",
                        style: AppTextStyles.medium(
                            color: Colors.red,
                        ),
                      ),
                      Text("Booking REF : 123456",
                        style: AppTextStyles.regular(

                            color: CustomColor.blueGrey
                        ),
                      ),


                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width*0.4,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("CASH",
                        style: AppTextStyles.regular(
                            color: Colors.blueGrey
                        ),
                      ),
                      Text(
                        "&177.00",
                        softWrap: true,
                        style: AppTextStyles.medium(
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            SizedBox(height: 10,),

            Container(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                children: [

                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                    child: Text("00/00/2025 00:00",
                      style: AppTextStyles.regular(

                          color: Colors.blueGrey
                      ),
                    ),
                  ),
                  Spacer(),

                  Text("ESTATE CAR",
                    style: AppTextStyles.regular(
                        color: Colors.blueGrey
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15,),


            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle_sharp,size: 20,color: Colors.blue),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          "1A Worrior "
                              "Garden St.LEO"
                              " TN36eb",
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style:AppTextStyles.regular(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 2,
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                  ),


                  Row(
                    children: [
                      Icon(Icons.location_on,size: 20,color: Colors.red,),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          "Flat  1 "
                              "Bland fold"
                              " London Nw6",
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.regular(
                          ),
                        ),
                      ),
                    ],
                  )

              ],
              ),
            )




          ],
        ),
      ),
    ));
  }
}
