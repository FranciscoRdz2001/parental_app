import 'package:parental_app/core/entities/session/save_session_data_entity.dart';
import 'package:parental_app/core/types/session_type.dart';
import 'package:parental_app/core/utils/app_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalDataUtil {
  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveSession({
    required String email,
    required String password,
    required SessionType type,
    required String token,
  }) async {
    Future.wait([
      _prefs.setString(VariablesKeys.email, email),
      _prefs.setString(VariablesKeys.password, password),
      _prefs.setString(VariablesKeys.sessionType, type.getType),
      _prefs.setString(VariablesKeys.token, token),
    ]);
  }

  static Future<void> clearSession() async {
    Future.wait([
      _prefs.remove(VariablesKeys.email),
      _prefs.remove(VariablesKeys.password),
      _prefs.remove(VariablesKeys.sessionType),
      _prefs.remove(VariablesKeys.token),
    ]);
  }

  static String? get getToken => _prefs.getString(VariablesKeys.token);

  static SavedSessionDataEntity? get getSessionData {
    final email = _prefs.getString(VariablesKeys.email);
    final password = _prefs.getString(VariablesKeys.password);
    final type = _prefs.getString(VariablesKeys.sessionType);
    if (email == null || password == null || type == null) {
      return null;
    }
    return SavedSessionDataEntity(
      email: email,
      password: password,
      sessionType: type.getSessionType ?? SessionType.parent,
    );
  }
}

class VariablesKeys {
  static const String email = 'email';
  static const String password = 'password';
  static const String sessionType = 'sessionType';
  static const String token = 'token';
}
