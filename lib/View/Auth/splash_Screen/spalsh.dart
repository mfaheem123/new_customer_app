import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../api_servies/session.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
    void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {

      if (TokenManager.isLogin) {
        Get.offAllNamed('/DeshBoard_Screen');   // already logged in
      } else {
        Get.offAllNamed('/SigIn_Screen');       // not logged in
      }
     //Get.offAllNamed('/SigIn_Screen');
      //Get.offAllNamed('/DeshBoard_Screen');
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: CustomColor.background,
      body: Container(
        height:MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 30, 1, 44),
              Color.fromARGB(255, 129, 75, 154),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
        Center(
              child: Container(
                height:200,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ProductImages.splash_image),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
