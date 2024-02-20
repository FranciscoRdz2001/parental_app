import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_app_name.dart';
import 'package:parental_app/core/app/widgets/custom_back_button.dart';
import 'package:parental_app/core/app/widgets/custom_scaffold_widget.dart';
import 'package:parental_app/core/app/widgets/custom_state_switcher_widget.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/domain/models/apps/user_activity_model.dart';
import 'package:parental_app/domain/models/childs/child_data_model.dart';
import 'package:parental_app/features/all_apps/presentation/blocs/child_most_used_apps/child_most_used_apps_bloc.dart';
import 'package:parental_app/features/all_apps/presentation/blocs/child_most_used_apps/child_most_used_apps_params.dart';
import 'package:parental_app/features/all_apps/presentation/widgets/placeholders/all_user_apps_placeholder.dart';
import 'package:parental_app/features/home/presentation/widgets/app_usage_data_widget.dart';

class AllAppsPage extends StatefulWidget {
  final ChildDataModel child;
  const AllAppsPage({super.key, required this.child});

  @override
  State<AllAppsPage> createState() => _AllAppsPageState();
}

class _AllAppsPageState extends State<AllAppsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChildMostUsedAppsBloc>().add(
          CallAction(
            params: ChildMostUsedAppsParams(
              childUuid: widget.child.uuid,
            ),
          ),
        );
  }

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
            widget.child.name,
            style: AppStyles.w600(16),
          ),
          const SizedBox(height: 4),
          Text(
            widget.child.deviceName,
            style: AppStyles.w400(12, AppColors.gray),
          ),
          const SizedBox(height: 32),
          Text(
            'Todas las apps',
            style: AppStyles.w600(14),
          ),
          const SizedBox(height: 16),
          BlocBuilder<ChildMostUsedAppsBloc,
              BaseScreenState<List<UserActivityModel>>>(
            builder: (context, state) {
              return CustomStateSwitcher(
                isLoading: !state.status.isLoaded,
                childWidget: (state.value?.length ?? 0) == 0
                    ? Center(
                        child: Text(
                          'No hay aplicaciones para mostrar',
                          style: AppStyles.w400(12, AppColors.gray),
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
                            totalTime: state.value![x].time,
                            package: state.value?[x].package ?? '',
                            icon: state.value?[x].icon,
                            isUserApp: true,
                          );
                        },
                        separatorBuilder: (_, x) {
                          return const SizedBox(height: 16);
                        },
                      ),
                loadingWidget: const AllUserAppsPlaceholder(),
              );
            },
          ),
        ],
      ),
    );
  }
}
