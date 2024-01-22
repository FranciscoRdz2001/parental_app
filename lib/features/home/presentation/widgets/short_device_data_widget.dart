import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/domain/models/apps/user_activity_model.dart';
import 'package:parental_app/features/home/presentation/widgets/circle_image_widget.dart';

class ShortDeviceDataWidget extends StatelessWidget {
  final UserActivityModel userActivity;
  const ShortDeviceDataWidget({super.key, required this.userActivity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        // AppDialogs.showDeviceData(context);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleImageWidget(size: 48),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        userActivity.name,
                        style: AppStyles.w600(14),
                      ),
                    ),
                    if (userActivity.deviceName != null) ...[
                      const SizedBox(width: 16),
                      Text(
                        userActivity.deviceName!,
                        style: AppStyles.w400(12, AppColors.gray),
                      ),
                    ]
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${userActivity.time} de uso',
                        style: AppStyles.w400(12, AppColors.gray),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
