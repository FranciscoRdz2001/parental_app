import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/data/global_data.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_app_name.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/utils/app_local_data_util.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';
import 'package:parental_app/features/auth/presentation/blocs/logout/logout_bloc.dart';
import 'package:parental_app/features/auth/presentation/routes/auth_routes.dart';
import 'package:parental_app/features/home/presentation/widgets/circle_image_widget.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final sizer = ScreenSizer.of(context);
    return Container(
      width: sizer.wp(70),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: SafeArea(
          child: Column(
            children: [
              const CustomAppName(),
              const SizedBox(height: 32),
              const CircleImageWidget(
                size: 84,
                child: Icon(
                  Icons.person_2_outlined,
                  color: AppColors.lightGray,
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                GlobalData.instance.user?.fullName ?? 'Sin nombre',
                style: AppStyles.w600(14),
              ),
              const SizedBox(height: 16),
              Text(
                'Código de sincronización:',
                style: AppStyles.w400(12, AppColors.lightGray),
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: GlobalData.instance.user?.syncCode.toString() ??
                          'Sin código',
                    ),
                  );
                },
                child: Text(
                  '#${GlobalData.instance.user?.syncCode ?? 'Sin código'}',
                  style: AppStyles.w600(12, AppColors.secondaryColor),
                ),
              ),
              const Spacer(),
              BlocBuilder<LogoutBloc, BaseScreenState<bool>>(
                builder: (context, state) {
                  return CustomButtonWidget(
                    text: 'Cerrar sesión',
                    isLoading: state.status.isLoading,
                    onTap: () {
                      context.read<LogoutBloc>().add(const CallAction());
                      AppLocalDataUtil.clearSession();
                      Future.delayed(const Duration(milliseconds: 500), () {
                        GlobalData.instance.clearData();
                      });
                      NavigatorRouter.popAll();
                      NavigatorRouter.pushReplacementNamed(AuthRoutes.login);
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
