
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../Widgets/color.dart';
import '../Widgets/elevat_button.dart';
import '../Widgets/textformfield.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          backgroundColor: CustomColor.background ,
      body:Container(
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
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child:  IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back, size: 25, color: CustomColor.Icon_Color  ),
              ),
            ),
            SizedBox(height: 20,),

            Container(
              height: 200,
              decoration: BoxDecoration(
                //color: Colors.yellow,
                  image:DecorationImage(image: AssetImage("assets/images/promo.png",), fit: BoxFit.cover)
              ),
            ),

            SizedBox(height: 15,),


            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomTextField(
               // controller: ,
                hintText: "Enter Promo",
                borderRadius: 15,

              ),
            ),

            SizedBox(height: 10,),
            Center(
              child: Container(
                height: 55,
                width: 250  ,
                child: MyElevatedButton(
                  text: 'DONE',
                  textWidget: FittedBox(
                    child: Text("Done",style: AppTextStyles.medium(size: 25,weight: FontWeight.bold),),
                  ),
                  onPressed: () {  },
                  fontSize: 20,
                ),
              ),
            )

          ],
        ),
      )
    ));
  }
}
