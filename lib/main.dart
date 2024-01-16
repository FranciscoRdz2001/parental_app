import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parental_app/core/app/theme/app_theme.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/navigator/app_routes.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parental App',
      theme: AppTheme.lightThemeData,
      darkTheme: AppTheme.darkThemeData,
      navigatorKey: NavigatorRouter.navigatorKey,
      themeMode: ThemeMode.system,
      initialRoute: NavigatorRouter.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
