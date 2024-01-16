import 'package:flutter/widgets.dart';
import 'package:parental_app/core/navigator/app_router.dart';
import 'package:parental_app/features/all_apps/presentation/pages/all_apps_page.dart';
import 'package:parental_app/features/all_apps/presentation/routes/all_apps_routes.dart';

class AllAppsRouter extends AppRouter {
  @override
  Map<String, Widget Function(BuildContext context)> get routes {
    return {
      AllAppsRoutes.home: (context) => const AllAppsPage(),
    };
  }
}
