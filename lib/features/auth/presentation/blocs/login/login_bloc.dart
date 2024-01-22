import 'package:dartz/dartz.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
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
}
