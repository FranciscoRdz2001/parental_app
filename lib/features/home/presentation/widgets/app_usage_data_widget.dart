import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/utils/app_dialogs_util.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/core/utils/app_utils.dart';
import 'package:parental_app/features/home/presentation/widgets/circle_image_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/circle_status_widget.dart';

class AppUsageDataWidget extends StatelessWidget {
  final bool isUserApp;
  final String appName;
  final String package;
  final int totalTime;
  final int? devices;

  const AppUsageDataWidget({
    super.key,
    this.isUserApp = false,
    required this.appName,
    required this.totalTime,
    required this.package,
    this.devices,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        AppDialogs.showAppDetails(
          context,
          appName: appName,
          package: package,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
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
                          appName,
                          style: AppStyles.w600(14),
                        ),
                      ),
                      if (!isUserApp) ...[
                        const SizedBox(width: 16),
                        const CircleStatusWidget(),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppUtils.instance.totalTimeString(totalTime),
                          style: AppStyles.w400(12, AppColors.gray),
                        ),
                      ),
                      if (!isUserApp && devices != null) ...[
                        const SizedBox(width: 16),
                        Text(
                          '$devices dispositivos',
                          style: AppStyles.w400(12, AppColors.gray),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
