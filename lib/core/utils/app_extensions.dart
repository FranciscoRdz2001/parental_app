import 'package:parental_app/core/types/session_type.dart';

extension SessionTypeX on SessionType {
  String get getType {
    switch (this) {
      case SessionType.parent:
        return 'parent';
      case SessionType.child:
        return 'child';
      default:
        return '';
    }
  }
}

extension Stringx on String {
  SessionType? get getSessionType {
    switch (this) {
      case 'parent':
        return SessionType.parent;
      case 'child':
        return SessionType.child;
      default:
        return null;
    }
  }
}
