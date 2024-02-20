import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/data/global_data.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/models/auth/user_model.dart';
import 'package:parental_app/domain/services/auth/auth_service.dart';

class UserBloc extends BaseScreenBloc<UserModel> {
  final _repo = AuthService();
  @override
  Future<Either<Failure, UserModel>> repositoryCall(ScreenParams params) {
    return _repo.parentInfo();
  }

  @override
  void onSuccess(
    Emitter<BaseScreenState<UserModel>> emit,
    UserModel value,
    ScreenParams params,
  ) {
    GlobalData.instance.setUser(value);
    super.onSuccess(emit, value, params);
  }
}
