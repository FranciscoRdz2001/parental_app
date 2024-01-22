import 'package:dartz/dartz.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/services/child/childs_service.dart';
import 'package:parental_app/features/auth/presentation/blocs/child_activity/params/child_activity_params.dart';

class ChildActivityBloc extends BaseScreenBloc<bool> {
  final _service = ChildsService();

  @override
  Future<Either<Failure, bool>> repositoryCall(ScreenParams params) {
    if (params is ChildActivityParams) {
      return _service.sendChildActity(apps: params.apps);
    }
    throw Exception('Invalid params');
  }
}
