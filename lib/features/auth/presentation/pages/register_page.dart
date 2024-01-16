import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_app_name.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/app/widgets/custom_input_widget.dart';
import 'package:parental_app/core/app/widgets/custom_scaffold_widget.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';
import 'package:parental_app/features/auth/presentation/routes/auth_routes.dart';
import 'package:parental_app/features/home/presentation/routes/home_routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizer = ScreenSizer.of(context);
    return CustomScaffoldWidget(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomAppName(),
            SizedBox(height: sizer.hp(15)),
            Text(
              'Registro',
              style: AppStyles.w600(24),
            ),
            Text(
              'Ingresa tus datos para registrar tu cuenta',
              style: AppStyles.w400(12, AppColors.gray),
            ),
            const SizedBox(height: 16),
            Text(
              'Datos personales',
              style: AppStyles.w500(14),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                  child: CustomInputWidget(
                    label: 'Nombre',
                    keyboardType: TextInputType.name,
                    prefixIcon: Icons.account_circle_outlined,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomInputWidget(
                    label: 'Apellido',
                    keyboardType: TextInputType.name,
                    prefixIcon: Icons.account_circle_outlined,
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Datos de la cuenta',
              style: AppStyles.w500(14),
            ),
            const SizedBox(height: 16),
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
              text: 'Registrar',
              onTap: () {
                NavigatorRouter.pushNamed(HomeRoutes.home);
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Text(
                    'Ya tienes una cuenta?',
                    style: AppStyles.w400(12, AppColors.gray),
                  ),
                  const SizedBox(height: 4),
                  InkWell(
                    onTap: () {
                      NavigatorRouter.pushReplacementNamed(AuthRoutes.login);
                    },
                    child: Text(
                      'Inicia sesión',
                      style: AppStyles.w600(12, AppColors.secondaryColor),
                    ),
                  ),
                ],
              ),
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
    );
  }
}
