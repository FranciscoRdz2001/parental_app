import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/data/global_data.dart';
import 'package:parental_app/core/types/session_type.dart';
import 'package:parental_app/core/utils/app_local_data_util.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/models/auth/registered_user_model.dart';
import 'package:parental_app/domain/services/auth/auth_service.dart';
import 'package:parental_app/features/auth/presentation/blocs/register/params/register_params.dart';

class RegisterBloc extends BaseScreenBloc<RegisteredUserModel> {
  final _service = AuthService();
  @override
  Future<Either<Failure, RegisteredUserModel>> repositoryCall(
    ScreenParams params,
  ) {
    if (params is! RegisterParams) {
      throw Exception('Invalid params');
    }
    return _service.register(
      email: params.email,
      password: params.password,
      firstName: params.firstName,
      lastName: params.lastName,
    );
  }

  @override
  void onSuccess(
    Emitter<BaseScreenState<RegisteredUserModel>> emit,
    RegisteredUserModel value,
    ScreenParams params,
  ) {
    final p = params as RegisterParams;
    GlobalData.instance.setUser(value.user);
    GlobalData.instance.setToken(value.token);
    AppLocalDataUtil.saveSession(
      email: p.email,
      password: p.password,
      type: SessionType.parent,
      token: value.token,
    );
    super.onSuccess(emit, value, params);
  }
}
