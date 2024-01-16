import 'package:flutter/widgets.dart';
import 'package:parental_app/core/navigator/app_router.dart';
import 'package:parental_app/features/auth/presentation/pages/login_page.dart';
import 'package:parental_app/features/auth/presentation/pages/register_page.dart';
import 'package:parental_app/features/auth/presentation/pages/sync_status_page.dart';
import 'package:parental_app/features/auth/presentation/routes/auth_routes.dart';

class AuthRouter extends AppRouter {
  @override
  Map<String, Widget Function(BuildContext context)> get routes {
    return {
      AuthRoutes.login: (context) => const LoginPage(),
      AuthRoutes.register: (context) => const RegisterPage(),
      AuthRoutes.syncStatus: (context) => const SyncStatusPage(),
    };
  }
}
