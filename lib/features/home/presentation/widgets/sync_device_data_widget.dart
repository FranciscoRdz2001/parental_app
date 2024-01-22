import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/utils/app_dialogs_util.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/domain/models/request/child_request_model.dart';

class SyncDeviceDataWidget extends StatelessWidget {
  final ChildRequestModel child;
  const SyncDeviceDataWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        AppDialogs.syncRequest(
          context,
          uuid: child.uuid,
        );
      },
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                child.name,
                style: AppStyles.w600(14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              child.deviceName,
              style: AppStyles.w400(12, AppColors.lightGray),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
