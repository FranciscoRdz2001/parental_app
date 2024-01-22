import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';

class RequestActionParams extends ScreenParams {
  final String uuid;
  final bool isAccept;

  const RequestActionParams({required this.uuid, required this.isAccept});
}
