import 'package:flutter/material.dart';
import 'package:parental_app/core/app/data/mocked_data.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_app_name.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/app/widgets/custom_scaffold_widget.dart';
import 'package:parental_app/core/utils/app_dialogs_util.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/features/home/presentation/widgets/app_usage_data_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/device_data_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/sync_request_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      persistentFooterButton: CustomButtonWidget(
        text: 'Agregar dispositivo',
        onTap: () {
          AppDialogs.addDevice(context);
        },
      ),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 135,
            toolbarHeight: 0,
            elevation: 0,
            actions: const [SizedBox()],
            leading: const SizedBox(),
            clipBehavior: Clip.hardEdge,
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppName(),
                  const SizedBox(height: 32),
                  RichText(
                    text: TextSpan(
                      text: 'Bienvenido ',
                      style: AppStyles.w400(
                          16, Theme.of(context).textTheme.bodyLarge?.color),
                      children: [
                        TextSpan(
                          text: 'Francisco Rodríguez',
                          style: AppStyles.w600(16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Aquí podrás ver el estado de los dispositivos de tu hijos',
                    style: AppStyles.w400(12, AppColors.lightGray),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SyncRequestWidget(),
                const SizedBox(height: 16),
                Text(
                  'Dispositivos',
                  style: AppStyles.w600(14),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: MockedData.devicesNames.length,
                    itemBuilder: (context, x) {
                      return DeviceDataWidget(index: x);
                    },
                    separatorBuilder: (_, x) {
                      return const SizedBox(width: 16);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Aplicaciones mas usadas',
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
                    );
                  },
                  separatorBuilder: (_, x) {
                    return const SizedBox(height: 16);
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
