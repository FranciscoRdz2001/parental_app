import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:parental_app/domain/models/auth/child_auth_model.dart';
import 'package:parental_app/domain/models/auth/user_model.dart';

class GlobalData {
  GlobalData._();

  static final GlobalData instance = GlobalData._();

  UserModel? user;
  ChildAuthModel? child;
  String? token;
  String? deviceName;
  String? fcmToken;

  void setUser(UserModel user) {
    this.user = user;
  }

  void setChild(ChildAuthModel child) {
    this.child = child;
  }

  void setFcmToken(String token) {
    fcmToken = token;
  }

  void setToken(String token) {
    this.token = token;
  }

  bool get isLogged => user != null;

  Future<void> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      final androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
      log('Device name: $deviceName');
    } catch (e) {
      deviceName = 'Unknown';
      log('Error getting device name: $e');
    }
  }

  void clearData() {
    user = null;
    child = null;
    token = null;
  }
}
