import 'dart:convert';
import 'package:customer/Routing/routes_name.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../Controller/Home/home-controller.dart';
import '../Controller/Ride/RideController.dart';
import '../View/rides/DriverDetailscreen.dart';
import '../api_servies/api_servies.dart';
import '../api_servies/session.dart';


class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await requestPermission();
    await _initLocal();

    // 🔥 FCM TOKEN
    String? token = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $token");

    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      debugPrint("Token refreshed: $newToken");
    });

    // ✅ FOREGROUND
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Foreground notification");

      _showNotification(message);
      _handleNotification(message);
    });

    // ✅ BACKGROUND CLICK
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Background click");

      _handleNotification(message);
    });

    // ✅ TERMINATED STATE
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      debugPrint("App opened from terminated");

      _handleNotification(initialMessage);
    }
  }

  // ✅ PERMISSION
  Future<void> requestPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // ✅ LOCAL INIT
  Future<void> _initLocal() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await _localNotificationsPlugin.initialize(
      settings: initSettings, // ✅ FIX
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          Map data = jsonDecode(response.payload!);
          _handleData(data);
        }
      },
    );
  }

  // ✅ SHOW LOCAL NOTIFICATION
  Future<void> _showNotification(RemoteMessage message) async {
    if (message.notification == null) return;

    await _localNotificationsPlugin.show(
      id: message.hashCode, // ✅ FIX
      title: message.notification!.title,
      body: message.notification!.body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_channel',
          'High Importance',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  // 🔥 HANDLE MESSAGE
  void _handleNotification(RemoteMessage message) {
    _handleData(message.data);
  }

  // 🔥 CORE
  String? driverId;
  String? bookingId;
  String? type;

  Future<void> _handleData(Map data) async {
    try {
       bookingId = data['booking_id']?.toString();
      driverId = data['driver_id']?.toString(); // ✅ correct
       type = data['type']?.toString();

      debugPrint("bookingId: $bookingId");
      debugPrint("driverId: $driverId");
      debugPrint("type: $type");

      // ❌ required fields check
      if (driverId == null) return;

      // ❌ NOT LOGIN
      if (!TokenManager.isLogin) {
        debugPrint("User NOT logged in → ignore");
        await _localNotificationsPlugin.cancelAll();
        return;
      }

      // ✅ TYPE HANDLE
      switch (type) {
        case "RIDE_ACCEPTED":
          // await _hitDriverApi(driverId!); // 🔥 FIX (driverId pass// )

          if (driverId != null) {
            await _hitDriverApi(driverId!);
          }

          if (bookingId != null) {
            await _getBookingById(bookingId!); // 🔥 ADD THIS
          }


          // //  ADD THIS
          final rideController = Get.isRegistered<RideController>()
              ? Get.find<RideController>()
              : Get.put(RideController());
          rideController.startPolling(driverId!);


          break;

        case "RIDE_CANCELLED":
          debugPrint("Ride cancelled");
          break;

        default:
          debugPrint("Unknown type");
      }

    } catch (e) {
      debugPrint("Handle error: $e");
    }
  }

  // 🔥 API CALL
  Future<void> _hitDriverApi(String driverId) async {
    try {
      debugPrint("Calling API with driver_id: $driverId");

      var response = await ApiService.get(
        "drivers/getbyid/$driverId", // ✅ dynamic path
        auth: true,
      );

      if ( response!.statusCode == 200) {
        var data = response.data;

        debugPrint("Driver Data: $data");

        // ✅ NAVIGATION
        // Get.offAllNamed(routesName.Driverdetailscreen, arguments: data);
        Get.offAllNamed(routesName.Driverdetailscreen, arguments: {
          "id": driverId
        });

      } else {
        debugPrint("API Failed: ${response.statusCode}");
      }

    } catch (e) {
      debugPrint("API error: $e");
    }
  }

  Future<void> _getBookingById(String bookingId) async {
    try {
      debugPrint("Calling Booking API: $bookingId");

      var response = await ApiService.get(
        "bookings/getbyid/$bookingId", // ✅ correct endpoint
        auth: true,
      );

      if ( response!.statusCode == 200) {
        var data = response.data;

        debugPrint("Booking Data: $data");

        // 👉 Controller me store karo
        final rideController = Get.isRegistered<RideController>()
            ? Get.find<RideController>()
            : Get.put(RideController());

        rideController.setBookingData(data);

      } else {
        debugPrint("Booking API Failed: ${response.statusCode}");
      }

    } catch (e) {
      debugPrint("Booking API error: $e");
    }
  }




}


















// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class PushNotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   Future<void> init() async {
//     // Request permission for iOS and Android 13+
//     await requestPermission();
//
//     // Initialize Local Notifications
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );
//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     await _localNotificationsPlugin.initialize(
//       settings: initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         if (response.payload != null) {
//           debugPrint('Notification payload: ${response.payload}');
//           // Handle notification tap here
//         }
//       },
//     );
//
//     // Get FCM Token
//     try {
//       String? token = await _firebaseMessaging.getToken();
//       debugPrint('FCM Token: $token');
//       // You can store or send the token to your backend here
//     } catch (e) {
//       debugPrint('Error getting FCM token: $e');
//     }
//
//     // Handle token refresh
//     _firebaseMessaging.onTokenRefresh.listen((newToken) {
//       debugPrint('FCM Token refreshed: $newToken');
//     });
//
//     // Handle Foreground Messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint('Foreground message received: ${message.messageId}');
//       _showLocalNotification(message);
//     });
//
//     // Handle App Opened from background via Notification
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint('App opened from background via notification: ${message.messageId}');
//     });
//   }
//
//   Future<void> requestPermission() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     debugPrint('User granted permission: ${settings.authorizationStatus}');
//   }
//
//   Future<void> _showLocalNotification(RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     AppleNotification? apple = message.notification?.apple;
//
//     if (notification != null && (android != null || apple != null)) {
//       await _localNotificationsPlugin.show(
//         id: notification.hashCode,
//         title: notification.title,
//         body: notification.body,
//         notificationDetails: const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'high_importance_channel',
//             'High Importance Notifications',
//             channelDescription: 'This channel is used for important notifications.',
//             importance: Importance.max,
//             priority: Priority.high,
//             icon: '@mipmap/ic_launcher',
//           ),
//           iOS: DarwinNotificationDetails(
//             presentAlert: true,
//             presentBadge: true,
//             presentSound: true,
//           ),
//         ),
//         payload: message.data.toString(),
//       );
//     }
//   }
//
// //  PushNotificationService
// Future<String?> getToken() async {
//   try {
//     String? token = await _firebaseMessaging.getToken();
//     return token;
//   } catch (e) {
//     debugPrint('Error getting FCM token: $e');
//     return null;
//   }
// }
//
// }
