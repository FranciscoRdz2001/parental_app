import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/utils/app_snackbars_util.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/core/utils/app_utils.dart';
import 'package:parental_app/domain/models/childs/child_data_model.dart';
import 'package:parental_app/features/all_apps/presentation/pages/all_apps_page.dart';
import 'package:parental_app/features/home/presentation/blocs/requests/params/request_action_params.dart';
import 'package:parental_app/features/home/presentation/blocs/requests/request_actions_bloc.dart';
import 'package:parental_app/features/home/presentation/widgets/circle_image_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/circle_status_widget.dart';

class DeviceDataDialog extends StatelessWidget {
  final ChildDataModel child;
  const DeviceDataDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        const Positioned(
          top: -76,
          child: CircleImageWidget(size: 84),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleStatusWidget(),
                const SizedBox(width: 4),
                Text(
                  child.name,
                  style: AppStyles.w600(16),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              child.deviceName,
              style: AppStyles.w400(12, AppColors.gray),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.05),
                    blurRadius: 32,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Tiempo de uso',
                          style: AppStyles.w400(12, AppColors.gray),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        AppUtils.instance.totalTimeString(child.totalTime),
                        style: AppStyles.w400(12, AppColors.gray),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Aplicaciones',
                          style: AppStyles.w400(12, AppColors.gray),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        child.appCount.toString(),
                        style: AppStyles.w400(12, AppColors.gray),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Dispositivos',
                          style: AppStyles.w400(12, AppColors.gray),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '5',
                        style: AppStyles.w400(12, AppColors.gray),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocListener<RequestActionsBloc, BaseScreenState<int>>(
              listener: (context, state) {
                if (state.status.isLoaded) {
                  NavigatorRouter.pop();
                  AppSnackbars.success(
                    context,
                    message: 'Dispositivo desvinculado',
                    description:
                        'El dispositivo de ${child.name} ha sido desvinculado',
                  );
                }
              },
              child: BlocBuilder<RequestActionsBloc, BaseScreenState<int>>(
                builder: (context, state) {
                  return CustomButtonWidget(
                    text: 'Ver todas las aplicaciones',
                    isLoading: state.status.isLoading,
                    onTap: () {
                      NavigatorRouter.pushReplacement(
                        AllAppsPage(child: child),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                context.read<RequestActionsBloc>().add(
                      CallAction(
                        params: RequestActionParams(
                          uuid: child.uuid,
                          isAccept: false,
                        ),
                      ),
                    );
              },
              child: Text(
                'Desvincular',
                style: AppStyles.w400(12),
              ),
            )
          ],
        ),
      ],
    );
  }
}
