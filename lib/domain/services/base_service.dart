import 'package:dartz/dartz.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/services/app_api.dart';

abstract class BaseService extends CenterApi {
  Future<Either<Failure, T>> getMethod<T>({
    required String urlSpecific,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await get(
      urlSpecific: urlSpecific,
      fromJson: fromJson,
    );

    if (response.isSuccess) {
      return Right(response.result as T);
    }
    return Left(
      Failure(
        response.message ?? 'Error',
        code: response.statusCode,
      ),
    );
  }

  Future<Either<Failure, T>> postMethod<T>({
    required String urlSpecific,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response =
        await post(urlSpecific: urlSpecific, data: data, fromJson: fromJson);

    if (response.isSuccess) {
      return Right(response.result as T);
    }
    return Left(
      Failure(
        response.message ?? 'Error',
        code: response.statusCode,
      ),
    );
  }

  Future<Either<Failure, T>> putMethod<T>({
    required String urlSpecific,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await update(
      urlSpecific: urlSpecific,
      data: data,
      fromJson: fromJson,
    );

    if (response.isSuccess) {
      return Right(response.result as T);
    }
    return Left(
      Failure(
        response.message ?? 'Error',
        code: response.statusCode,
      ),
    );
  }
}
