import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/data/global_data.dart';
import 'package:parental_app/core/types/session_type.dart';
import 'package:parental_app/core/utils/app_local_data_util.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/models/auth/child_auth_model.dart';
import 'package:parental_app/domain/services/auth/auth_service.dart';
import 'package:parental_app/features/auth/presentation/blocs/child_login/params/child_login_params.dart';

class ChildLoginBloc extends BaseScreenBloc<ChildAuthModel> {
  final _repo = AuthService();
  ChildLoginBloc() : super();

  @override
  Future<Either<Failure, ChildAuthModel>> repositoryCall(ScreenParams params) {
    if (params is ChildLoginParams) {
      return _repo.childLogin(
        name: params.name,
        syncCode: params.syncCode,
      );
    }
    throw Exception('Invalid params type for ChiLD lOGIN Blco');
  }

  @override
  void onSuccess(
    Emitter<BaseScreenState<ChildAuthModel>> emit,
    ChildAuthModel value,
    ScreenParams params,
  ) {
    final p = params as ChildLoginParams;
    GlobalData.instance.setChild(value);
    GlobalData.instance.setToken(value.token);
    AppLocalDataUtil.saveSession(
      email: p.name,
      password: p.syncCode.toString(),
      type: SessionType.child,
      token: value.token,
    );
    super.onSuccess(emit, value, params);
  }
}
