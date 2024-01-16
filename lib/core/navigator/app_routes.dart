import 'package:flutter/widgets.dart';
import 'package:parental_app/features/all_apps/presentation/routes/all_apps_router.dart';
import 'package:parental_app/features/auth/presentation/routes/auth_router.dart';
import 'package:parental_app/features/home/presentation/routes/home_router.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> get routes => _routes;

  static final Map<String, Widget Function(BuildContext)> _routes = {
    ...AuthRouter().routes,
    ...HomeRouter().routes,
    ...AllAppsRouter().routes,
  };
}
