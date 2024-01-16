import 'package:flutter/material.dart';
import 'package:parental_app/core/app/data/mocked_data.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/features/home/presentation/widgets/circle_image_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/short_device_data_widget.dart';

class AppDataDialog extends StatelessWidget {
  final String appName;
  const AppDataDialog({super.key, required this.appName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 32),
              Text(
                appName,
                style: AppStyles.w600(16),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '5 dispositivos usando esta app',
                  style: AppStyles.w600(14),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '1 hora 30 minutos',
                      style: AppStyles.w400(12, AppColors.gray),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '5 dispositivos',
                    style: AppStyles.w400(12, AppColors.gray),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: MockedData.devicesNames.length,
                itemBuilder: (context, x) {
                  return ShortDeviceDataWidget(index: x);
                },
                separatorBuilder: (_, x) {
                  return const SizedBox(height: 24);
                },
              ),
              const SizedBox(height: 64),
            ],
          ),
        ),
        CustomButtonWidget(
          text: 'Aceptar',
          onTap: () {
            NavigatorRouter.pop();
          },
        ),
        const Positioned(
          top: -76,
          child: CircleImageWidget(
            size: 84,
          ),
        ),
      ],
    );
  }
}
