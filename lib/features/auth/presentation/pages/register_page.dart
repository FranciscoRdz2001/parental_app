import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/blocs/fmc/fmc_bloc.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_app_name.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/app/widgets/custom_input_widget.dart';
import 'package:parental_app/core/app/widgets/custom_scaffold_widget.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/utils/app_snackbars_util.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/core/utils/inputs_validator_util.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';
import 'package:parental_app/domain/models/auth/registered_user_model.dart';
import 'package:parental_app/features/auth/presentation/blocs/register/params/register_params.dart';
import 'package:parental_app/features/auth/presentation/blocs/register/register_bloc.dart';
import 'package:parental_app/features/auth/presentation/routes/auth_routes.dart';
import 'package:parental_app/features/home/presentation/routes/home_routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: const _RegisterPage(),
    );
  }
}

class _RegisterPage extends StatefulWidget {
  const _RegisterPage();

  @override
  State<_RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<_RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final sizer = ScreenSizer.of(context);
    return CustomScaffoldWidget(
      child: Center(
        child: Form(
          key: _formKey,
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
              Row(
                children: [
                  Expanded(
                    child: CustomInputWidget(
                      controller: _nameController,
                      label: 'Nombre',
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.account_circle_outlined,
                      validator: InputsValidator.validateNotEmpty,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomInputWidget(
                      controller: _lastNameController,
                      label: 'Apellido',
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.account_circle_outlined,
                      validator: InputsValidator.validateNotEmpty,
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
              CustomInputWidget(
                controller: _emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                validator: InputsValidator.validateEmail,
              ),
              const SizedBox(height: 16),
              CustomInputWidget(
                controller: _passwordController,
                label: 'Contraseña',
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icons.lock_outlined,
                validator: InputsValidator.validatePassword,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              BlocListener<RegisterBloc, BaseScreenState<RegisteredUserModel>>(
                listener: (context, state) {
                  if (state.status.isLoaded) {
                    context.read<FmcBloc>().add(const CallAction());
                    NavigatorRouter.pushReplacementNamed(HomeRoutes.home);
                  } else if (state.status.isError) {
                    AppSnackbars.error(
                      context,
                      message: 'No se pudo registrar el usuario',
                      description: 'Intente nuevamente',
                    );
                  }
                },
                child: BlocBuilder<RegisterBloc,
                    BaseScreenState<RegisteredUserModel>>(
                  builder: (context, state) {
                    return CustomButtonWidget(
                      text: 'Registrar',
                      isLoading: state.status.isLoading,
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<RegisterBloc>().add(
                                CallAction(
                                  params: RegisterParams(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    firstName: _nameController.text,
                                    lastName: _lastNameController.text,
                                  ),
                                ),
                              );
                        } else {
                          AppSnackbars.error(
                            context,
                            message: 'Error',
                            description: 'Debes completar todos los campos',
                          );
                        }
                      },
                    );
                  },
                ),
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
      ),
    );
  }
}
