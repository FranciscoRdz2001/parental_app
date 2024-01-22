import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/app/widgets/custom_shimmer.dart';
import 'package:parental_app/core/app/widgets/custom_state_switcher_widget.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/domain/models/apps/user_activity_model.dart';
import 'package:parental_app/features/all_apps/presentation/widgets/placeholders/all_user_apps_placeholder.dart';
import 'package:parental_app/features/home/presentation/blocs/childs_by_package/childs_by_package_bloc.dart';
import 'package:parental_app/features/home/presentation/blocs/childs_by_package/params/childs_by_package_params.dart';
import 'package:parental_app/features/home/presentation/widgets/circle_image_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/short_device_data_widget.dart';

class AppDataDialog extends StatefulWidget {
  final String appName;
  final String package;
  const AppDataDialog(
      {super.key, required this.appName, required this.package});

  @override
  State<AppDataDialog> createState() => _AppDataDialogState();
}

class _AppDataDialogState extends State<AppDataDialog> {
  @override
  void initState() {
    super.initState();
    context.read<ChildsByPackageBloc>().add(
          CallAction(
            params: ChildsByPackageParams(
              packageName: widget.package,
            ),
          ),
        );
  }

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
                widget.appName,
                style: AppStyles.w600(16),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: BlocBuilder<ChildsByPackageBloc,
                    BaseScreenState<List<UserActivityModel>>>(
                  builder: (context, state) {
                    return CustomStateSwitcher(
                      isLoading: !state.status.isLoaded,
                      loadingWidget: const CustomShimmer(
                        width: double.infinity,
                        height: 14,
                      ),
                      childWidget: Text(
                        '${state.value?.length ?? 0} dispositivos usando esta app',
                        style: AppStyles.w600(14),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<ChildsByPackageBloc,
                  BaseScreenState<List<UserActivityModel>>>(
                builder: (context, state) {
                  return CustomStateSwitcher(
                    isLoading: !state.status.isLoaded,
                    loadingWidget: const AllUserAppsPlaceholder(
                      items: 2,
                    ),
                    childWidget: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: state.value?.length ?? 0,
                      itemBuilder: (context, x) {
                        final child = state.value![x];
                        return ShortDeviceDataWidget(userActivity: child);
                      },
                      separatorBuilder: (_, x) {
                        return const SizedBox(height: 24);
                      },
                    ),
                  );
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
          child: CircleImageWidget(size: 84),
        ),
      ],
    );
  }
}
