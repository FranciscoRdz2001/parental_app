import 'package:parental_app/domain/models/auth/user_model.dart';

class RegisteredUserModel {
  final UserModel user;
  final String token;

  const RegisteredUserModel({
    required this.user,
    required this.token,
  });

  factory RegisteredUserModel.fromJson(Map<String, dynamic> json) {
    return RegisteredUserModel(
      user: UserModel.fromJson(json['data']),
      token: json['token'],
    );
  }
}
