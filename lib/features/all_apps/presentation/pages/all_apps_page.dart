import 'package:flutter/material.dart';
import 'package:parental_app/core/app/data/mocked_data.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_app_name.dart';
import 'package:parental_app/core/app/widgets/custom_back_button.dart';
import 'package:parental_app/core/app/widgets/custom_scaffold_widget.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/features/home/presentation/widgets/app_usage_data_widget.dart';

class AllAppsPage extends StatelessWidget {
  const AllAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      hasScroll: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CustomBackButton(),
              SizedBox(width: 16),
              CustomAppName(),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            MockedData.usersNames[0],
            style: AppStyles.w600(16),
          ),
          const SizedBox(height: 4),
          Text(
            MockedData.devicesNames[0],
            style: AppStyles.w400(12, AppColors.gray),
          ),
          const SizedBox(height: 32),
          Text(
            'Todas las apps',
            style: AppStyles.w600(14),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: MockedData.appNames.length,
            itemBuilder: (context, x) {
              return AppUsageDataWidget(
                appName: MockedData.appNames[x],
                isUserApp: true,
              );
            },
            separatorBuilder: (_, x) {
              return const SizedBox(height: 16);
            },
          ),
        ],
      ),
    );
  }
}
