import 'package:flutter/material.dart';
import 'package:parental_app/core/app/data/global_data.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_app_name.dart';
import 'package:parental_app/core/app/widgets/custom_scaffold_widget.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/features/home/presentation/widgets/most_used_apps_data_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/parent_childs_list_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/sync_request_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
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
                        16,
                        Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      children: [
                        TextSpan(
                          text: GlobalData.instance.user?.fullName ??
                              'Sin nombre',
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
                Text(
                  'Dispositivos',
                  style: AppStyles.w600(14),
                ),
                const SizedBox(height: 16),
                const ParentChildListWidget(),
                const SizedBox(height: 16),
                Text(
                  'Aplicaciones mas usadas',
                  style: AppStyles.w600(14),
                ),
                const SizedBox(height: 16),
                const MostUsedAppsDataWidget(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
