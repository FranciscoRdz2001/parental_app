import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';

class LoginParams extends ScreenParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}
