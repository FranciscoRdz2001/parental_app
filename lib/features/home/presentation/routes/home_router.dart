import 'package:flutter/widgets.dart';
import 'package:parental_app/core/navigator/app_router.dart';
import 'package:parental_app/features/home/presentation/pages/home_page.dart';
import 'package:parental_app/features/home/presentation/routes/home_routes.dart';

class HomeRouter extends AppRouter {
  @override
  Map<String, Widget Function(BuildContext context)> get routes {
    return {
      HomeRoutes.home: (context) => const HomePage(),
    };
  }
}
