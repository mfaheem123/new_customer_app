
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      "Promo ",
                      style: AppTextStyles.heading(
                        // size: MediaQuery.of(context).size.width * 0.06,
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
