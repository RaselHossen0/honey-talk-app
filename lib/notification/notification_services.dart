import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class NotificationServices {
  static Callback callback = () {};

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // This Method Call in Main...
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(android: androidInitializationSettings, iOS: initializationSettingsDarwin);

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        callback.call();
        handleNotificationAction(response);
      },
    );

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      "High Importance Notification",
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      playSound: true,
      channel.id,
      channel.name,
      channelDescription: "your channel description",
      // importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
      enableVibration: true,
      icon: "@mipmap/ic_launcher",

      actions: [
        AndroidNotificationAction(
          'ACCEPT_CALL',
          'Video',
          showsUserInterface: true,
          icon: DrawableResourceAndroidBitmap('ic_launcher'),
        ),
        AndroidNotificationAction(
          'DECLINE_CALL',
          'Decline',
          showsUserInterface: true,
        ),
      ],
      // actions: [
      //   const AndroidNotificationAction(
      //     'ACCEPT_CALL',
      //     'Accept',
      //     showsUserInterface: true,
      //   ),
      //   const AndroidNotificationAction(
      //     'DECLINE_CALL',
      //     'Decline',
      //     showsUserInterface: true,
      //   ),
      // ],
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    _flutterLocalNotificationsPlugin.show(
      id: Random.secure().nextInt(100000),
      title: message.notification?.title.toString(),
      body: message.notification?.body.toString(),
      notificationDetails: notificationDetails,
    );
  }

  static Future<void> firebaseInit() async {
    // This Method Call in Main...
    FirebaseMessaging.onMessage.listen(
      (message) {
        Utils.showLog("Local Notification => Is Show Notification => ${Database.isShowNotification} => Is App Open => }");
        Utils.showLog("Notification => ${message.data}");
        Utils.showLog("Notification Title => ${message.notification?.title.toString()}");
        Utils.showLog("Notification Body => ${message.notification?.body.toString()}");

        showNotification(message);

        if (Database.isShowNotification) {
          callback = () async {
            try {
              if (message.data["type"] == "CHAT") {
                debugPrint("Click To Chat Notification");
                Get.offAllNamed(AppRoutes.bottomBarPage);
                await 1.seconds.delay();
                final bottomBarController = Get.find<BottomBarController>();
                bottomBarController.onChangeBottomBar(3); // Go To Chat Page...
              }
            } catch (e) {
              Utils.showLog("Notification Change Routes Failed => $e");
            }
          };
        }
      },
    );
  }

  static Future<void> onShowBackgroundNotification(RemoteMessage message) async {
    Utils.showLog("Background Notification => Is Show Notification => ${Database.isShowNotification} => Is App Open =>  => ${message.messageId}");
  }

  static void handleNotificationAction(NotificationResponse response) {
    Utils.showLog("Notification Action Clicked: ${response.actionId}");

    if (response.actionId == 'ACCEPT_CALL') {
      Get.offAllNamed(AppRoutes.searchPage); // Navigate to Accept Page
    } else if (response.actionId == 'DECLINE_CALL') {
      Get.offAllNamed(AppRoutes.editProfilePage); // Navigate to Decline Page
    }
  }
}
