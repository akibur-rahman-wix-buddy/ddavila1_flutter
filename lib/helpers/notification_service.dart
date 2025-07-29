// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:kickback/helpers/di.dart';
// import '../../constants/app_constants.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:uuid/uuid.dart';

// class NotificationService {
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   final _androidChannel = const AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: "This is notification description",
//     importance: Importance.defaultImportance,
//   );

//   final _localNotification = FlutterLocalNotificationsPlugin();

//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//   }

//   Future initLocalNotification() async {
//     const ios = DarwinInitializationSettings();
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android, iOS: ios);

//     await _localNotification.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (payload) {
//         final message = RemoteMessage.fromMap(jsonDecode(payload.toString()));
//         handleMessage(message);
//       },
//     );

//     final platform = _localNotification.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }

//   Future initPushNotification() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     // Handle when app is launched initially via a notification
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

//     // Handle when the app is opened via a notification
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

//     // Handle background messages
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

//     // Handle foreground notifications
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if (notification != null) {
//         // Display local notification for foreground messages
//         _localNotification.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               _androidChannel.id,
//               _androidChannel.name,
//               channelDescription: _androidChannel.description,
//               icon: '@mipmap/ic_launcher',
//             ),
//             iOS: const DarwinNotificationDetails(),
//           ),
//           payload: jsonEncode(message.data),
//         );
//       }
//     });
//   }

//   Future<void> handleBackgroundMessage(RemoteMessage message) async {
//     log("Title ${message.notification?.title ?? ""}");
//     log("Body ${message.notification?.body ?? ""}");
//     log("data ${message.data}");
//   }

//   Future<void> initNotification() async {
//     try {
//       // Request permission for notifications
//       await _firebaseMessaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );

//       String? fcmToken;
//       final deviceInfo = DeviceInfoPlugin();
//       String? deviceId;

//       // Platform-specific token handling
//       if (Platform.isIOS) {
//         log("Come here (iOS)");
//         final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//         fcmToken = await _firebaseMessaging.getToken();
//         log("FCM Token =====>>> $fcmToken");

//         if (apnsToken != null) {
//           log("APNS Token =====>>> $apnsToken");
//         } else {
//           log("Error: APNS token is not set.");
//         }

//         // Get iOS device ID
//         final iosInfo = await deviceInfo.iosInfo;
//         deviceId = iosInfo.identifierForVendor;
//       } else {
//         // Android token
//         fcmToken = await _firebaseMessaging.getToken();
//         log("FCM Token =====>>> $fcmToken");

//         // Get Android device ID
//         final androidInfo = await deviceInfo.androidInfo;
//         deviceId = androidInfo.id;
//       }

//       // Fallback to random UUID if device ID is null
//       deviceId ??= const Uuid().v4();

//       // Save tokens
//       appData.write(kKeyFCMToken, fcmToken);
//       appData.write(kKeyDeviceID, deviceId);

//       log("FCM Token saved successfully: $fcmToken");
//       log("Generated Device ID =====>>> $deviceId");

//       // // Send to API
//       // final success = await storeNotificationApiRx.createFCM(
//       //   token: fcmToken,
//       //   device_id: deviceId,
//       // );
//       // if (success) {
//       //   log("Push notification sent successfully.");
//       // } else {
//       //   log("Failed to send push notification.");
//       // }
//     } catch (e) {
//       log("Error initializing notifications: $e");
//     }

//     // Initialize listeners
//     initPushNotification();
//     initLocalNotification();
//   }
// }
