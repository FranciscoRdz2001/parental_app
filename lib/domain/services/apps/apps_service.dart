import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/models/apps/most_used_app_model.dart';
import 'package:parental_app/domain/models/apps/user_activity_model.dart';
import 'package:parental_app/domain/services/base_service.dart';

class AppService extends BaseService {
  Future<Either<Failure, List<MostUsedAppModel>>> getMostUsedApps() async {
    final response = await getMethod<List<MostUsedAppModel>>(
      urlSpecific: 'parent/childs/mostUsed',
      fromJson: (json) => List<MostUsedAppModel>.from(
        json['mostUsedApps'].map(
          (x) => MostUsedAppModel.fromJson(x),
        ),
      ),
    );
    return response;
  }

  Future<Either<Failure, List<UserActivityModel>>> getChildMostUsedApps(
      {required String uuid}) async {
    final response = await getMethod<List<UserActivityModel>>(
      urlSpecific: 'parent/childs/activity/$uuid/today',
      fromJson: (json) => List<UserActivityModel>.from(
        json['activities'].map(
          (x) => UserActivityModel.fromJson(x),
        ),
      ),
    );
    return response;
  }

  Future<Either<Failure, List<UserActivityModel>>> childsByPackage({
    required String package,
  }) async {
    log('childsByPackage: $package');
    final response = await getMethod<List<UserActivityModel>>(
      urlSpecific: 'parent/childs/package/$package',
      fromJson: (json) => List<UserActivityModel>.from(
        json['activities'].map(
          (x) => UserActivityModel.fromJson(x),
        ),
      ),
    );
    return response;
  }
}
