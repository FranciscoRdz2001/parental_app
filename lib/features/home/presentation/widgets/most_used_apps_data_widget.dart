import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_state_switcher_widget.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/domain/models/apps/most_used_app_model.dart';
import 'package:parental_app/features/home/presentation/blocs/most_used_apps/most_used_apps_bloc.dart';
import 'package:parental_app/features/home/presentation/widgets/app_usage_data_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/placeholders/most_used_app_placeholder_widget.dart';

class MostUsedAppsDataWidget extends StatelessWidget {
  const MostUsedAppsDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MostUsedAppsBloc,
        BaseScreenState<List<MostUsedAppModel>>>(
      builder: (context, state) {
        final isEmpty = state.value?.isEmpty ?? true;
        return CustomStateSwitcher(
          isLoading: !state.status.isLoaded,
          childWidget: isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      const Icon(
                        Icons.list_alt_rounded,
                        color: AppColors.lightGray,
                        size: 32,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No hay datos para mostrar',
                        style: AppStyles.w400(12, AppColors.lightGray),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: state.value?.length ?? 0,
                  itemBuilder: (context, x) {
                    return AppUsageDataWidget(
                      appName: state.value![x].name,
                      totalTime: state.value![x].totalTime,
                      devices: state.value![x].devices,
                      package: state.value![x].package,
                      icon: state.value![x].icon,
                    );
                  },
                  separatorBuilder: (_, x) {
                    return const SizedBox(height: 16);
                  },
                ),
          loadingWidget: const MostUsedAppPlaceholderWidget(),
        );
      },
    );
  }
}
