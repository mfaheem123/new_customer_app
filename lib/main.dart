import 'package:customer/Routing/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:customer/api_servies/push_notification_service.dart';
import 'Routing/routes.dart';
import 'package:bot_toast/bot_toast.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Handling a background message: ${message.messageId}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await PushNotificationService().init();
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
