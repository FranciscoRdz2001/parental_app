import 'package:flutter/widgets.dart';

abstract class AppRouter {
  Map<String, Widget Function(BuildContext context)> get routes;
}
