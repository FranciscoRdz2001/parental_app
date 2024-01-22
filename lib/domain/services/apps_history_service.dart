import 'dart:developer';

import 'package:installed_apps/installed_apps.dart';
import 'package:parental_app/domain/models/activity/app_activity_model.dart';
import 'package:usage_stats/usage_stats.dart';

class AppsHistoryService {
  static const _systemPackages = [
    'com.android',
    'com.google.android',
    'com.google.android.gms',
    'com.system',
  ];

  static Future<void> requestPermissions() async {
    final isPermissionGranted =
        await UsageStats.checkUsagePermission() ?? false;
    if (!isPermissionGranted) {
      await UsageStats.grantUsagePermission();
    }
  }

  static Future<List<AppActivityModel>> getAppsHistory() async {
    try {
      final endDate = DateTime.now();

      final usageStats = await UsageStats.queryUsageStats(
        endDate.subtract(const Duration(days: 1)),
        endDate,
      );

      final filteredList = usageStats
          .where(
            (element) => !_systemPackages.any(
              (package) => element.packageName?.contains(package) ?? false,
            ),
          )
          .toList();

      final infoList =
          filteredList.where((e) => e.packageName != null).toList();
      final List<AppActivityModel> list = [];

      for (var i = 0; i < infoList.length; i++) {
        final info = await InstalledApps.getAppInfo(infoList[i].packageName!);
        final name = info.name;
        final time =
            (int.tryParse(infoList[i].totalTimeInForeground ?? '0') ?? 0) /
                1000;
        if (infoList[i].packageName == 'com.example.parental_app') {
          log(time.toString());
        }
        list.add(
          AppActivityModel(
            package: infoList[i].packageName!,
            name: name,
            time: time.round(),
          ),
        );
      }

      return list;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
