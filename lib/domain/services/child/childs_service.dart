import 'package:dartz/dartz.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/models/activity/app_activity_model.dart';
import 'package:parental_app/domain/models/childs/child_data_model.dart';
import 'package:parental_app/domain/models/childs/child_info_status_model.dart';
import 'package:parental_app/domain/services/base_service.dart';

class ChildsService extends BaseService {
  Future<Either<Failure, List<ChildDataModel>>> getChilds() async {
    final response = await getMethod<List<ChildDataModel>>(
      urlSpecific: 'parent/childs',
      fromJson: (json) => List<ChildDataModel>.from(
        json['children'].map(
          (x) => ChildDataModel.fromJson(x),
        ),
      ),
    );
    return response;
  }

  Future<Either<Failure, ChildInfoStatusModel>> getChildInfo() async {
    final response = await getMethod<ChildInfoStatusModel>(
      urlSpecific: 'child/info',
      fromJson: (json) => ChildInfoStatusModel.fromJson(json['child']),
    );
    return response;
  }

  Future<Either<Failure, bool>> sendChildActity({
    required List<AppActivityModel> apps,
  }) async {
    final response = await putMethod<bool>(
      urlSpecific: 'child/activity/today',
      fromJson: (json) => true,
      data: {
        'activity': apps.map((e) => e.toMap()).toList(),
      },
    );
    return response;
  }
}
