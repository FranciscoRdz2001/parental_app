import 'package:dartz/dartz.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/models/childs/child_info_status_model.dart';
import 'package:parental_app/domain/services/child/childs_service.dart';

class ChildStatusBloc extends BaseScreenBloc<ChildInfoStatusModel> {
  final _repo = ChildsService();
  ChildStatusBloc() : super();

  @override
  Future<Either<Failure, ChildInfoStatusModel>> repositoryCall(
      ScreenParams params) {
    return _repo.getChildInfo();
  }
}
