import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:parental_app/core/app/data/global_data.dart';
import 'package:parental_app/domain/failures/failure.dart';
import 'package:parental_app/domain/models/auth/child_auth_model.dart';
import 'package:parental_app/domain/models/auth/registered_user_model.dart';
import 'package:parental_app/domain/models/auth/user_model.dart';
import 'package:parental_app/domain/services/base_service.dart';

class AuthService extends BaseService {
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  }) async {
    final response = await postMethod<String>(
      urlSpecific: 'login',
      data: {
        'email': email,
        'password': password,
      },
      fromJson: (json) => json['token'],
    );

    return response;
  }

  Future<Either<Failure, bool>> logout() async {
    final response = await postMethod<bool>(
      urlSpecific: 'auth/logout',
      data: {},
      fromJson: (json) => true,
    );

    return response;
  }

  Future<Either<Failure, RegisteredUserModel>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final response = await postMethod<RegisteredUserModel>(
      urlSpecific: 'auth/register',
      data: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      },
      fromJson: (json) => RegisteredUserModel.fromJson(json),
    );

    return response;
  }

  Future<Either<Failure, ChildAuthModel>> childLogin({
    required String name,
    required int syncCode,
  }) async {
    final response = await postMethod<ChildAuthModel>(
      urlSpecific: 'auth/child/login',
      data: {
        'name': name,
        'syncCode': syncCode,
        if (GlobalData.instance.deviceName != null)
          'deviceName': GlobalData.instance.deviceName,
      },
      fromJson: (json) => ChildAuthModel.fromJson(json),
    );

    return response;
  }

  Future<Either<Failure, UserModel>> parentInfo() async {
    final response = await getMethod<UserModel>(
      urlSpecific: 'parent/info',
      fromJson: (json) => UserModel.fromJson(json['user']),
    );
    if (GlobalData.instance.fcmToken != null) {
      try {
        if (response.isRight()) {
          await sendFMC(fmc: GlobalData.instance.fcmToken!);
        }
      } catch (e) {
        log('Error saving token: $e');
      }
    }
    return response;
  }

  Future<Either<Failure, bool>> sendFMC({required String fmc}) async {
    final response = await putMethod<bool>(
      urlSpecific: 'parent/fcm/$fmc',
      data: {},
      fromJson: (p0) => true,
    );
    return response;
  }
}
