import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/widgets/custom_state_switcher_widget.dart';
import 'package:parental_app/domain/models/apps/most_used_app_model.dart';
import 'package:parental_app/features/home/presentation/blocs/most_used_apps/most_used_apps_bloc.dart';
import 'package:parental_app/features/home/presentation/widgets/app_usage_data_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/placeholders/most_used_app_placeholder_widget.dart';

class MostUsedAppsDataWidget extends StatefulWidget {
  const MostUsedAppsDataWidget({super.key});

  @override
  State<MostUsedAppsDataWidget> createState() => _MostUsedAppsDataWidgetState();
}

class _MostUsedAppsDataWidgetState extends State<MostUsedAppsDataWidget> {
  @override
  void initState() {
    super.initState();
    context.read<MostUsedAppsBloc>().add(const CallAction());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MostUsedAppsBloc,
        BaseScreenState<List<MostUsedAppModel>>>(
      builder: (context, state) {
        return CustomStateSwitcher(
          isLoading: !state.status.isLoaded,
          childWidget: ListView.separated(
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
