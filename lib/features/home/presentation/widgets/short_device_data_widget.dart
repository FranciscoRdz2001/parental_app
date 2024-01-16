import 'package:flutter/material.dart';
import 'package:parental_app/core/app/data/mocked_data.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/utils/app_dialogs_util.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/features/home/presentation/widgets/circle_image_widget.dart';

class ShortDeviceDataWidget extends StatelessWidget {
  final int index;
  const ShortDeviceDataWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        AppDialogs.showDeviceData(context);
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
                        MockedData.usersNames[index],
                        style: AppStyles.w600(14),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      MockedData.devicesNames[index],
                      style: AppStyles.w400(12, AppColors.gray),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '01:30 de uso',
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
