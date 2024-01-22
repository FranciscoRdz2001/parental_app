import 'package:dartz/dartz.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/models/request/child_request_model.dart';
import 'package:parental_app/domain/services/base_service.dart';

class RequestService extends BaseService {
  Future<Either<Failure, List<ChildRequestModel>>> getRequests() async {
    final response = await getMethod<List<ChildRequestModel>>(
      urlSpecific: 'parent/childs/requests',
      fromJson: (json) => List<ChildRequestModel>.from(
        json['children'].map(
          (x) => ChildRequestModel.fromJson(x),
        ),
      ),
    );
    return response;
  }

  Future<Either<Failure, int>> acceptRequest({required String uuid}) async {
    return await postMethod(
      urlSpecific: 'parent/childs/requests/accept/$uuid',
      fromJson: (json) => 1,
      data: {},
    );
  }

  Future<Either<Failure, int>> denyRequest({required String uuid}) async {
    return await postMethod(
      urlSpecific: 'parent/childs/requests/deny/$uuid',
      fromJson: (json) => 2,
      data: {},
    );
  }
}
