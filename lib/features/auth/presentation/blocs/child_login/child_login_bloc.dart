import 'package:dartz/dartz.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
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
}
