import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';

class ChildLoginParams extends ScreenParams {
  final String name;
  final int syncCode;

  const ChildLoginParams({
    required this.name,
    required this.syncCode,
  });
}
