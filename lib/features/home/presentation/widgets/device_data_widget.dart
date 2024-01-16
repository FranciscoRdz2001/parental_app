import 'package:flutter/material.dart';
import 'package:parental_app/core/app/data/mocked_data.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/utils/app_dialogs_util.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';
import 'package:parental_app/features/home/presentation/widgets/circle_status_widget.dart';

class DeviceDataWidget extends StatelessWidget {
  final int index;
  const DeviceDataWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final sizer = ScreenSizer.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        AppDialogs.showDeviceData(context);
      },
      child: Container(
        width: sizer.wp(70),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            MockedData.usersNames[index],
                            style: AppStyles.w600(14),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.phone,
                          color: AppColors.lightGray,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '16 horas de uso',
                    style: AppStyles.w400(12, AppColors.gray),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    MockedData.devicesNames[index],
                    style: AppStyles.w400(12, AppColors.lightGray),
                  ),
                ),
                const SizedBox(width: 16),
                const CircleStatusWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
