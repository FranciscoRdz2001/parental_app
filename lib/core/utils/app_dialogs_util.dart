import 'package:flutter/material.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';
import 'package:parental_app/domain/models/childs/child_data_model.dart';
import 'package:parental_app/features/home/presentation/widgets/dialogs/add_kid_dialog.dart';
import 'package:parental_app/features/home/presentation/widgets/dialogs/app_data_dialog.dart';
import 'package:parental_app/features/home/presentation/widgets/dialogs/device_data_dialog.dart';
import 'package:parental_app/features/home/presentation/widgets/dialogs/sync_request_dialog.dart';

class AppDialogs {
  static void _baseDialog(
    BuildContext context, {
    BoxConstraints? constraints,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 32,
    ),
    required Widget content,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      constraints: constraints,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Padding(
            padding: padding,
            child: content,
          ),
        );
      },
    );
  }

  static void showDeviceData(
    BuildContext context, {
    required ChildDataModel child,
  }) {
    return _baseDialog(
      context,
      content: DeviceDataDialog(child: child),
    );
  }

  static void showAppDetails(
    BuildContext context, {
    required String appName,
    required String package,
  }) {
    final sizer = ScreenSizer.of(context);
    return _baseDialog(
      context,
      constraints: BoxConstraints(
        maxHeight: sizer.hp(80),
      ),
      content: AppDataDialog(
        appName: appName,
        package: package,
      ),
    );
  }

  static void addDevice(BuildContext context) {
    return _baseDialog(
      context,
      content: const AddKidDialog(),
    );
  }

  static void syncRequest(BuildContext context, {required String uuid}) {
    return _baseDialog(
      context,
      content: SyncRequestDialog(
        uuid: uuid,
      ),
    );
  }
}
