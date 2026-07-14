
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../Deshboard/map_widget/map_polyLine.dart';
import '../Widgets/all_text.dart';

class TripDetail extends StatelessWidget {
   TripDetail({super.key});
  final data = Get.arguments;

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
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
                        Navigator.of(context).pop();
                      },
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Text(
                        CustomText.Trip_Detail,
                        style: AppTextStyles.heading(),
                      ),
                    ),
                  ),

                  // Back button ke size jitni empty space
                  const SizedBox(width: 48),
                ],
              ),
             SizedBox(height: 10,),
          
             ///=========================  Map
              Container(
                  clipBehavior: Clip.antiAlias, // 👈 Important
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey, width: 2),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/map_image.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 300,
                  child:  MapScreen()
          
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 100,
                    padding: const EdgeInsets.only(left: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                
                                
                          Text("Booking Status",
                            style: AppTextStyles.regular(
                              color: CustomColor.textColor
                          ),
                          ),
                          Text(
                            (data["status"]).toUpperCase() ?? "",
                            style: AppTextStyles.medium(
                              color: Colors.green,
                            ),
                          ),
                                
                          Text(
                            "Booking REF : ${data["referenceNo"] ?? ""}",
                            style: AppTextStyles.regular(
                              color: CustomColor.textColor
                            ),
                          ),
                                
                                
                        ],
                      ),
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
                              color: CustomColor.textColor
                          ),
                        ),
                        Text(
                          "${data["fare"] ?? ""}£",
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
                      child: Text(
                        "${data["date"] ?? ""}  ${data["time"] ?? ""}",
                        style: AppTextStyles.regular(
                          color:CustomColor.textColor
                        ),
                      ),
                    ),
                    Spacer(),
          
                    Text(
                      data["vehicle"] ?? "",
                      style: AppTextStyles.regular(
                        color: CustomColor.textColor
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
                            data["pickup"] ?? "",
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.regular(),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 2,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                    ),
          
          
                    Row(
                      children: [
                        Icon(Icons.location_on,size: 20,color: Colors.red,),
                        SizedBox(width: 10,),
                        Expanded(
                          child:Text(
                            data["dropoff"] ?? "",
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.regular(),
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
      ),
    ));
  }
}
