import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';

class RegisterParams extends ScreenParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}
