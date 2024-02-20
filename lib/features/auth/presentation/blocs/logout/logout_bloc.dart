import 'package:dartz/dartz.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/services/auth/auth_service.dart';

class LogoutBloc extends BaseScreenBloc<bool> {
  final _service = AuthService();

  @override
  Future<Either<Failure, bool>> repositoryCall(ScreenParams params) {
    return _service.logout();
  }
}
