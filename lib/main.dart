import 'package:customer/Routing/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'Routing/routes.dart';
import 'package:bot_toast/bot_toast.dart';


void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customer App',
      initialRoute:  routesName.Splash_Screen,
      //transitionDuration: Duration(seconds: ),
      defaultTransition: Transition.leftToRight,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],


      getPages: AppRoutes.appRoutes(),


    );
  }
}
