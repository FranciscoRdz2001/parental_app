import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:parental_app/core/app/data/global_data.dart';
import 'package:parental_app/core/app/theme/app_theme.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/navigator/app_routes.dart';
import 'package:parental_app/domain/services/push_notifications_service.dart';
import 'package:parental_app/features/all_apps/presentation/blocs/child_most_used_apps/child_most_used_apps_bloc.dart';
import 'package:parental_app/features/auth/presentation/blocs/child_activity/child_activity_bloc.dart';
import 'package:parental_app/features/auth/presentation/blocs/child_login/child_login_bloc.dart';
import 'package:parental_app/features/auth/presentation/blocs/child_status/child_status_bloc.dart';
import 'package:parental_app/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:parental_app/features/auth/presentation/blocs/user/user_bloc.dart';
import 'package:parental_app/features/home/presentation/blocs/childs/childs_bloc.dart';
import 'package:parental_app/features/home/presentation/blocs/childs_by_package/childs_by_package_bloc.dart';
import 'package:parental_app/features/home/presentation/blocs/most_used_apps/most_used_apps_bloc.dart';
import 'package:parental_app/features/home/presentation/blocs/requests/request_actions_bloc.dart';
import 'package:parental_app/features/home/presentation/blocs/requests/requests_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyC6eMBKU9othtw6_BKwnGkkHTRXr11AlXQ',
      appId: '1:445889983679:android:0dc7d005e25aa9d5c4820a',
      messagingSenderId: '445889983679',
      projectId: 'parental-app-3409d',
    ),
  );
  FlutterForegroundTask.stopService();

  await Future.wait([
    PushNotificationService.instance.initToken(),
    GlobalData.instance.getDeviceName(),
  ]);
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => RequestsBloc()),
        BlocProvider(create: (_) => ChildsBloc()),
        BlocProvider(create: (_) => MostUsedAppsBloc()),
        BlocProvider(create: (_) => ChildMostUsedAppsBloc()),
        BlocProvider(create: (_) => ChildsByPackageBloc()),
        BlocProvider(create: (_) => RequestActionsBloc()),
        BlocProvider(create: (_) => ChildLoginBloc()),
        BlocProvider(create: (_) => ChildStatusBloc()),
        BlocProvider(create: (_) => ChildActivityBloc()),
      ],
      child: MaterialApp(
        title: 'Parental App',
        theme: AppTheme.lightThemeData,
        darkTheme: AppTheme.darkThemeData,
        navigatorKey: NavigatorRouter.navigatorKey,
        themeMode: ThemeMode.system,
        initialRoute: NavigatorRouter.initialRoute,
        routes: AppRoutes.routes,
      ),
    );
  }
}
