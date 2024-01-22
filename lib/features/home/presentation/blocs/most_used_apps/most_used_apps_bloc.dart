import 'package:dartz/dartz.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/models/apps/most_used_app_model.dart';
import 'package:parental_app/domain/services/apps/apps_service.dart';

class MostUsedAppsBloc extends BaseScreenBloc<List<MostUsedAppModel>> {
  final _service = AppService();
  @override
  Future<Either<Failure, List<MostUsedAppModel>>> repositoryCall(
      ScreenParams params) {
    return _service.getMostUsedApps();
  }
}
