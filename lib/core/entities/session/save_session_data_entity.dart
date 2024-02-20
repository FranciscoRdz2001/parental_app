import 'package:parental_app/core/types/session_type.dart';

class SavedSessionDataEntity {
  final String email;
  final String password;
  final SessionType sessionType;

  const SavedSessionDataEntity({
    required this.email,
    required this.password,
    required this.sessionType,
  });
}
