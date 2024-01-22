import 'package:dartz/dartz.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/models/apps/user_activity_model.dart';
import 'package:parental_app/domain/services/apps/apps_service.dart';
import 'package:parental_app/features/all_apps/presentation/blocs/child_most_used_apps/child_most_used_apps_params.dart';

class ChildMostUsedAppsBloc extends BaseScreenBloc<List<UserActivityModel>> {
  final _service = AppService();

  @override
  Future<Either<Failure, List<UserActivityModel>>> repositoryCall(
      ScreenParams params) {
    if (params is ChildMostUsedAppsParams) {
      return _service.getChildMostUsedApps(uuid: params.childUuid);
    }
    throw Exception('Invalid params type');
  }
}
