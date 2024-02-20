import 'dart:convert';
import 'dart:typed_data';

import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/utils/app_constants_util.dart';
import 'package:parental_app/core/utils/app_snackbars_util.dart';

class AppUtils {
  AppUtils._internal();

  static final AppUtils _instance = AppUtils._internal();

  static AppUtils get instance => _instance;

  double stringToDouble(String number) {
    var newNumber = number;
    try {
      if (number.contains(',')) {
        newNumber = number.replaceAll(',', '.');
      }
      return double.parse(newNumber);
    } catch (_) {
      return 0;
    }
  }

  double currencyToDouble(String number) {
    var newNumber = number;
    try {
      if (number.contains(r'$')) {
        newNumber = number.replaceAll(r'$', '');
      }
      if (number.contains(',')) {
        newNumber = number.replaceAll(',', '.');
      }
      return double.parse(newNumber);
    } catch (_) {
      return 0;
    }
  }

  dynamic getDataDecode(Uint8List bodyBytes) {
    return json.decode(utf8.decode(bodyBytes));
  }

  void noInternetConnection() {
    AppSnackbars.error(
      NavigatorRouter.currentContext,
      message: AppConstant.connectionError,
    );
  }

  String totalTimeString(int time) {
    final minutes = time ~/ 60;
    final seconds = time % 60;
    final hours = minutes ~/ 60;

    final formattedHour = hours == 0 ? '' : '$hours h ';
    final formattedMinutes = minutes % 60 == 0 ? '' : '${minutes % 60} min ';
    final formattedSeconds = seconds == 0 ? '' : '$seconds sec ';
    final completed = formattedHour + formattedMinutes + formattedSeconds;
    if (completed.isEmpty) {
      return 'Sin uso';
    }
    return '$formattedHour$formattedMinutes${formattedSeconds}de uso';
  }
}
