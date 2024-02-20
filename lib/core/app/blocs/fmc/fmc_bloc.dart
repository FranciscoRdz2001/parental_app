import 'package:dartz/dartz.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/services/auth/auth_service.dart';
import 'package:parental_app/domain/services/push_notifications_service.dart';

class FmcBloc extends BaseScreenBloc<bool> {
  final _service = AuthService();
  @override
  Future<Either<Failure, bool>> repositoryCall(ScreenParams params) {
    final token = PushNotificationService.instance.token;
    if (token == null) {
      throw Exception('Invalid params');
    }
    return _service.sendFMC(fmc: token);
  }
}
