import 'package:dartz/dartz.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/models/childs/child_data_model.dart';
import 'package:parental_app/domain/services/child/childs_service.dart';

class ChildsBloc extends BaseScreenBloc<List<ChildDataModel>> {
  final _serivce = ChildsService();

  @override
  Future<Either<Failure, List<ChildDataModel>>> repositoryCall(
    ScreenParams params,
  ) {
    return _serivce.getChilds();
  }
}
