import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/data/global_data.dart';
import 'package:parental_app/core/types/session_type.dart';
import 'package:parental_app/core/utils/app_local_data_util.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/services/auth/auth_service.dart';
import 'package:parental_app/features/auth/presentation/blocs/login/params/login_params.dart';

class LoginBloc extends BaseScreenBloc<String> {
  final _repo = AuthService();
  LoginBloc() : super();

  @override
  Future<Either<Failure, String>> repositoryCall(ScreenParams params) {
    if (params is LoginParams) {
      return _repo.login(
        email: params.email,
        password: params.password,
      );
    }
    throw Exception('Invalid params type for LoginBloc');
  }

  @override
  void onSuccess(
    Emitter<BaseScreenState<String>> emit,
    String value,
    ScreenParams params,
  ) {
    final p = params as LoginParams;
    GlobalData.instance.setToken(value);
    AppLocalDataUtil.saveSession(
      email: p.email,
      password: p.password,
      type: SessionType.parent,
      token: value,
    );
    super.onSuccess(emit, value, params);
  }
}
