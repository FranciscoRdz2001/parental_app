import 'dart:developer';

import 'package:flutter/services.dart';

class AppsHistoryService {
  static const _platform = MethodChannel(
    'com.example.parental_app/apps_history',
  );

  static Future<void> getAppsHistory() async {
    try {
      log('Getting result');
      final result = await _platform.invokeMethod('getAppsHistory');
      log('Result: $result');
    } on PlatformException catch (e) {
      log('Exception: $e');
    }
  }
}
