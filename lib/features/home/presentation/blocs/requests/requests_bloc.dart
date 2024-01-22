import 'package:dartz/dartz.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/models/request/child_request_model.dart';
import 'package:parental_app/domain/services/request/request_service.dart';

class RequestsBloc extends BaseScreenBloc<List<ChildRequestModel>> {
  final _service = RequestService();
  @override
  Future<Either<Failure, List<ChildRequestModel>>> repositoryCall(
    ScreenParams params,
  ) {
    return _service.getRequests();
  }
}
