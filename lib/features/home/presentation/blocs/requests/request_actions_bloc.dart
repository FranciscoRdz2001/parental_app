import 'package:dartz/dartz.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/services/request/request_service.dart';
import 'package:parental_app/features/home/presentation/blocs/requests/params/request_action_params.dart';

class RequestActionsBloc extends BaseScreenBloc<int> {
  final _service = RequestService();
  @override
  Future<Either<Failure, int>> repositoryCall(ScreenParams params) {
    if (params is! RequestActionParams) {
      throw Exception('Invalid params');
    }
    if (params.isAccept) {
      return _service.acceptRequest(uuid: params.uuid);
    } else {
      return _service.denyRequest(uuid: params.uuid);
    }
  }
}
