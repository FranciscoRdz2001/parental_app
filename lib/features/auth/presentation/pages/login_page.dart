import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_app_name.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/app/widgets/custom_input_widget.dart';
import 'package:parental_app/core/app/widgets/custom_scaffold_widget.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';
import 'package:parental_app/domain/services/apps_history_service.dart';
import 'package:parental_app/features/auth/presentation/routes/auth_routes.dart';
import 'package:parental_app/features/home/presentation/routes/home_routes.dart';

enum LoginType { user, kid }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginType _loginType = LoginType.user;

  @override
  void initState() {
    super.initState();
    AppsHistoryService.getAppsHistory();
  }

  @override
  Widget build(BuildContext context) {
    final sizer = ScreenSizer.of(context);
    return DefaultTabController(
      length: 2,
      child: CustomScaffoldWidget(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomAppName(),
              SizedBox(height: sizer.hp(25)),
              Text(
                'Inicio de sesión',
                style: AppStyles.w600(24),
              ),
              Text(
                'Ingresa tus datos para continuar',
                style: AppStyles.w400(12, AppColors.gray),
              ),
              const SizedBox(height: 16),
              TabBar(
                labelStyle: AppStyles.w600(12, AppColors.secondaryColor),
                unselectedLabelStyle: AppStyles.w400(12, AppColors.gray),
                onTap: (value) {
                  setState(() {
                    _loginType = value == 0 ? LoginType.user : LoginType.kid;
                  });
                },
                tabs: ['Padre', 'Hijo']
                    .map(
                      (e) => Tab(
                        child: Text(e),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _loginType == LoginType.user
                    ? const _UserLoginForm()
                    : const _KidLoginForm(),
              ),
              const Spacer(),
              Center(
                child: Text(
                  'Versión 1.0.0',
                  style: AppStyles.w400(12, AppColors.lightGray),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserLoginForm extends StatelessWidget {
  const _UserLoginForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CustomInputWidget(
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email_outlined,
        ),
        const SizedBox(height: 16),
        const CustomInputWidget(
          label: 'Contraseña',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.lock_outlined,
          obscureText: true,
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '¿Olvidaste tu contraseña?',
            style: AppStyles.w600(
              12,
              AppColors.secondaryColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        CustomButtonWidget(
          text: 'Iniciar sesión',
          onTap: () {
            NavigatorRouter.pushNamed(HomeRoutes.home);
          },
        ),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Text(
                '¿No tienes una cuenta?',
                style: AppStyles.w400(12, AppColors.gray),
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: () {
                  NavigatorRouter.pushReplacementNamed(AuthRoutes.register);
                },
                child: Text(
                  'Regístrate',
                  style: AppStyles.w600(12, AppColors.secondaryColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _KidLoginForm extends StatelessWidget {
  const _KidLoginForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CustomInputWidget(
          label: 'Código de acceso',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email_outlined,
        ),
        const SizedBox(height: 16),
        CustomButtonWidget(
          text: 'Iniciar sesión',
          onTap: () {
            NavigatorRouter.pushReplacementNamed(AuthRoutes.syncStatus);
          },
        ),
      ],
    );
  }
}
