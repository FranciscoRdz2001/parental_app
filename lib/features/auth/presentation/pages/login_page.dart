import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_app_name.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/app/widgets/custom_input_widget.dart';
import 'package:parental_app/core/app/widgets/custom_scaffold_widget.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/types/session_type.dart';
import 'package:parental_app/core/utils/app_local_data_util.dart';
import 'package:parental_app/core/utils/app_snackbars_util.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/core/utils/inputs_validator_util.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';
import 'package:parental_app/domain/models/auth/child_auth_model.dart';
import 'package:parental_app/domain/models/auth/user_model.dart';
import 'package:parental_app/domain/services/apps_history_service.dart';
import 'package:parental_app/domain/services/push_notifications_service.dart';
import 'package:parental_app/features/auth/presentation/blocs/child_login/child_login_bloc.dart';
import 'package:parental_app/features/auth/presentation/blocs/child_login/params/child_login_params.dart';
import 'package:parental_app/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:parental_app/features/auth/presentation/blocs/login/params/login_params.dart';
import 'package:parental_app/features/auth/presentation/blocs/user/user_bloc.dart';
import 'package:parental_app/features/auth/presentation/routes/auth_routes.dart';
import 'package:parental_app/features/home/presentation/routes/home_routes.dart';

enum LoginType { user, child }

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
    PushNotificationService.instance.requestPermission();
    AppsHistoryService.requestPermissions();

    final savedSession = AppLocalDataUtil.getSessionData;
    if (savedSession != null) {
      if (savedSession.sessionType == SessionType.parent) {
        context.read<LoginBloc>().add(
              CallAction(
                params: LoginParams(
                  email: savedSession.email,
                  password: savedSession.password,
                ),
              ),
            );
      } else {
        context.read<ChildLoginBloc>().add(
              CallAction(
                params: ChildLoginParams(
                  name: savedSession.email,
                  syncCode: int.tryParse(savedSession.password) ?? 0,
                ),
              ),
            );
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppSnackbars.success(
          context,
          message: 'Ingresando...',
          description: 'Espere un momento...',
        );
      });
    }
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
                    _loginType = value == 0 ? LoginType.user : LoginType.child;
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
              BlocListener<UserBloc, BaseScreenState<UserModel>>(
                listener: (context, state) {
                  if (state.status.isLoaded) {
                    NavigatorRouter.pushReplacementNamed(HomeRoutes.home);
                  }
                },
                child: BlocListener<LoginBloc, BaseScreenState<String>>(
                  listener: (context, state) {
                    if (state.status.isLoaded) {
                      context.read<UserBloc>().add(const CallAction());
                    } else if (state.status.isError) {
                      AppSnackbars.error(
                        context,
                        message: 'Error',
                        description: 'La información ingresada es incorrecta',
                      );
                    }
                  },
                  child: BlocListener<ChildLoginBloc,
                      BaseScreenState<ChildAuthModel>>(
                    listener: (context, state) {
                      if (state.status.isLoaded) {
                        NavigatorRouter.pushReplacementNamed(
                            AuthRoutes.syncStatus);
                      } else if (state.status.isError) {
                        AppSnackbars.error(
                          context,
                          message: 'Error',
                          description: 'La información ingresada es incorrecta',
                        );
                      }
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: _loginType == LoginType.user
                          ? const _ParentLoginForm()
                          : const _ChildLoginForm(),
                    ),
                  ),
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

class _ParentLoginForm extends StatefulWidget {
  const _ParentLoginForm();

  @override
  State<_ParentLoginForm> createState() => _ParentLoginFormState();
}

class _ParentLoginFormState extends State<_ParentLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.lock_outlined,
            obscureText: true,
            validator: InputsValidator.validatePassword,
          ),
          const SizedBox(height: 16),
          CustomButtonWidget(
            text: 'Iniciar sesión',
            isLoading: context.watch<LoginBloc>().state.status.isLoading ||
                context.watch<UserBloc>().state.status.isLoading,
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<LoginBloc>().add(
                      CallAction(
                        params: LoginParams(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      ),
                    );
              } else {
                AppSnackbars.error(
                  context,
                  message: 'Error',
                  description: 'Debes llenar todos los campos',
                );
              }
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
      ),
    );
  }
}

class _ChildLoginForm extends StatefulWidget {
  const _ChildLoginForm();

  @override
  State<_ChildLoginForm> createState() => _ChildLoginFormState();
}

class _ChildLoginFormState extends State<_ChildLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomInputWidget(
            controller: _nameController,
            label: 'Nombre',
            keyboardType: TextInputType.text,
            prefixIcon: Icons.account_circle_rounded,
            validator: InputsValidator.validateNotEmpty,
          ),
          const SizedBox(height: 16),
          CustomInputWidget(
            controller: _codeController,
            label: 'Código de acceso',
            keyboardType: TextInputType.number,
            prefixIcon: Icons.numbers,
            validator: InputsValidator.validateNotEmpty,
          ),
          const SizedBox(height: 16),
          BlocBuilder<ChildLoginBloc, BaseScreenState<ChildAuthModel>>(
            builder: (context, state) {
              return CustomButtonWidget(
                text: 'Iniciar sesión',
                isLoading: state.status.isLoading,
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<ChildLoginBloc>().add(
                          CallAction(
                            params: ChildLoginParams(
                              name: _nameController.text,
                              syncCode: int.tryParse(_codeController.text) ?? 0,
                            ),
                          ),
                        );
                  } else {
                    AppSnackbars.error(
                      context,
                      message: 'Error',
                      description: 'Debes llenar todos los campos',
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
