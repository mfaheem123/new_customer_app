
import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height:MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
         // color: CustomColor.Container_Colors
          //color: Color.fromARGB(255, 30, 1, 44).withOpacity(0.8),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 30, 1, 44),
              Color.fromARGB(255, 183, 50, 234)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: BoxDecoration(
                  //color: CustomColor.Container_Colors,
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed:(){

                        Get.back();
                      }
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Hello 👋",
                    style: AppTextStyles.heading(),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Before  you create an account, please read and accept our Terms & Conditions",
                    style: AppTextStyles.regular(color: Colors.white70),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Terms & Conditions",
                        style: AppTextStyles.heading(
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("Last updated: 15 February 2025",
                          style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 10),
                      _buildSection("1. Conditions of use",
                          "By using this app, you certify that you have read and reviewed this Agreement and that you agree to comply with its terms. If you do not want to be bound by the terms of this Agreement, you are advised to stop using the app accordingly. DailyUI only grants use and access of this app, its products, and its services to those who have accepted its terms."),
                      _buildSection("2. Privacy policy",
                          "Before you continue using our app, we advise you to read our privacy policy regarding our user data collection. It will help you better understand our practices."),
                      _buildSection("3. Intellectual property",
                          "You agree that all materials, products, and services provided on this app are the property of DailyUI, its affiliates, and licensors including all copyrights, trade secrets, trademarks, patents, and other intellectual property. You also agree that you will not reproduce..."),
                    ],
                  ),
                ),
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.all(20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         child: OutlinedButton(
            //           onPressed: () {},
            //           child: Text("Decline",
            //           style: TextStyle(
            //             color: Colors.black
            //           ),
            //           ),
            //           style: OutlinedButton.styleFrom(
            //             side: BorderSide(color: Colors.black),
            //             foregroundColor: Colors.grey,
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //           ),
            //         ),
            //       ),
            //       SizedBox(width: 10),
            //       Expanded(
            //         child: ElevatedButton(
            //           onPressed: () {},
            //           child: Text("Accept",
            //           style: TextStyle(
            //             color: Colors.white
            //           ),
            //
            //           ),
            //           style: ElevatedButton.styleFrom(
            //             backgroundColor: Colors.purple,
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.medium(

            ),
          ),
          SizedBox(height: 5),
          Text(
            content,
            style: AppTextStyles.regular(),
          ),
        ],
      ),
    );
  }
}






























// import 'package:customer/View/Widgets/all_text.dart';
// import 'package:customer/View/Widgets/color.dart';
// import 'package:customer/View/Widgets/textstyle.dart';
// import 'package:customer/View/textstyle/apptextstyle.dart';
// import 'package:flutter/material.dart';
//
// class TremsAndCondition_Screen extends StatelessWidget {
//   const TremsAndCondition_Screen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomColor.background,
//       body: Container(
//         padding: const EdgeInsets.all(18.0),
//         height:MediaQuery.of(context).size.height,
//         width:MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color.fromARGB(255, 30, 1, 44),
//               Color.fromARGB(255, 227, 194, 242)
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               children: [
//
//                 SizedBox(height: 30,),
//                 Container(
//
//                   height: MediaQuery.of(context).size.height/ 4,
//                   width: MediaQuery.of(context).size.width ,
//                   padding: EdgeInsets.symmetric(horizontal: 15),
//                   decoration: BoxDecoration(
//
//                     color: CustomColor.Container_Colors.withOpacity(0.8),
//
//                     borderRadius: BorderRadius.all(Radius.circular(20)
//                       // bottomLeft: Radius.circular(20),
//                       // bottomRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                          Text(
//                     "Hello 👋",style: AppTextStyles.heading(),
//
//                                 ),
//                     Text(
//                      CustomText.Terms_text_1,
//                     textAlign: TextAlign.center,
//                     style: AppTextStyles.regular(),
//
//                                 ),
//                     ],),
//                   ),
//                 ),
//               ],
//             ),
//                 SizedBox(height: 10,),
//                 Text(
//                    CustomText.SigUp_TremsAndCondition,
//                   style: AppTextStyles.heading(),
//
//                 ),
//                  Text(
//                    CustomText.Terms_Text_1_light,
//                   style: AppTextStyles.small(color: Colors.blueGrey)
//
//                 ),
//                 SizedBox(height: 12),
//
//                  Text(
//                    CustomText.Terms_Text_2,
//                 style: AppTextStyles.medium()
//
//                 ),
//                 SizedBox(height: 5),
//
//                  Text(
//                    CustomText.Terms_Text_2_1,
//                 style: AppTextStyles.small(),
//
//                 ),
//                 SizedBox(height: 12),
//
//                     Text(
//                   CustomText.Terms_Text_3, style: AppTextStyles.medium(),
//
//                 ),
//                 SizedBox(height: 5),
//
//                        Text(
//                    CustomText.Terms_Text_3_1,
//                 style: AppTextStyles.small(),
//
//                 ),
//                 SizedBox(height: 12),
//
//                       Text(
//                    CustomText.Terms_Text_4,
//                 style: AppTextStyles.medium(),
//
//                 ),
//                 SizedBox(height: 5),
//                    Text(
//                    CustomText.Terms_Text_4_1,
//                 style: AppTextStyles.small(),
//
//                 ),
//
//
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
