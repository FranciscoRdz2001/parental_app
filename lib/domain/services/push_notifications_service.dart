import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:parental_app/core/app/data/global_data.dart';

import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class PushNotificationService {
  factory PushNotificationService() {
    return _instance;
  }

  PushNotificationService._internal();

  static final PushNotificationService _instance =
      PushNotificationService._internal();

  static PushNotificationService get instance => _instance;

  final messaging = FirebaseMessaging.instance;
  String? token;
  void Function(Map<String, dynamic> action)? onTapNotification;

  Future<void> _messageHandler(RemoteMessage message) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('ic_launcher'),
    );

    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      token ?? '',
      'ParentalAppNotification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      color: AppColors.black,
      enableVibration: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        onTapNotification?.call({});
      },
    );
    final notification = message.notification;
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetails,
      );
    }
  }

  // On tap push notification
  Future<void> _messageOpenAppHandler(RemoteMessage message) async {
    onTapNotification?.call(message.data);
  }

  Future<void> _tokenRefresh(String newToken) async {
    if (newToken.isNotEmpty && newToken != token) {
      token = newToken;
      if (token != null) GlobalData.instance.setFcmToken(token!);
    }
  }

  Future<void> deleteToken() async {
    await messaging.deleteToken();
  }

  Future<void> initToken() async {
    token = await messaging.getToken();
    log('Token $token');
    if (token?.isNotEmpty != null) {
      GlobalData.instance.setFcmToken(token!);
    }
    // Handlers
    FirebaseMessaging.onMessage.listen(_messageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_messageOpenAppHandler);
    FirebaseMessaging.instance.onTokenRefresh.listen(_tokenRefresh);
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> requestPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied) {
      // NotificationSettings settings
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
  }
}
