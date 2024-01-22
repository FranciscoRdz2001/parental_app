import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/app/widgets/custom_scaffold_widget.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';
import 'package:parental_app/domain/models/childs/child_info_status_model.dart';
import 'package:parental_app/domain/services/apps_history_service.dart';
import 'package:parental_app/features/auth/presentation/blocs/child_activity/child_activity_bloc.dart';
import 'package:parental_app/features/auth/presentation/blocs/child_activity/params/child_activity_params.dart';
import 'package:parental_app/features/auth/presentation/blocs/child_status/child_status_bloc.dart';

enum _SyncStatus { loading, accepted, error, pending }

// @pragma('vm:entry-point')
// void startCallback() {
//   // The setTaskHandler function must be called to handle the task in the background.
//   FlutterForegroundTask.setTaskHandler(
//     FirstTaskHandler(),
//   );
// }

// class FirstTaskHandler extends TaskHandler {
//   SendPort? _sendPort;

//   FirstTaskHandler();

//   // Called when the task is started.
//   @override
//   void onStart(DateTime timestamp, SendPort? sendPort) async {
//     _sendPort = sendPort;

//     // You can use the getData function to get the stored data.
//     //
//   }

//   // Called every [interval] milliseconds in [ForegroundTaskOptions].
//   @override
//   void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
//     final apps = await AppsHistoryService.getAppsHistory();
//     // final context = NavigatorRouter.currentContext;
//     // context.read<ChildActivityBloc>().add(
//     //       CallAction(
//     //         params: ChildActivityParams(
//     //           apps: apps,
//     //         ),
//     //       ),
//     //     );
//     sendPort?.send(timestamp);
//   }

//   // Called when the notification button on the Android platform is pressed.
//   @override
//   void onDestroy(DateTime timestamp, SendPort? sendPort) async {}
// }

class SyncStatusPage extends StatefulWidget {
  const SyncStatusPage({super.key});

  @override
  State<SyncStatusPage> createState() => _SyncStatusPageState();
}

class _SyncStatusPageState extends State<SyncStatusPage> {
  _SyncStatus _syncStatus = _SyncStatus.loading;

  String? label;
  Color? color;
  Color? textColor;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChildStatusBloc>().add(const CallAction());
    });
  }

  @override
  void dispose() {
    // FlutterForegroundTask.stopService();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizer = ScreenSizer.of(context);
    return BlocListener<ChildStatusBloc, BaseScreenState<ChildInfoStatusModel>>(
      listener: (context, state) async {
        if (state.status.isLoaded) {
          switch (state.value!.status) {
            case 0:
              setState(() {
                _syncStatus = _SyncStatus.pending;
                label = 'Aun no se ha aceptado la solicitud';
                color = AppColors.orange;
                textColor = AppColors.white;
                SystemChrome.setSystemUIOverlayStyle(
                  const SystemUiOverlayStyle(
                    statusBarColor: AppColors.orange,
                    statusBarIconBrightness: Brightness.light,
                  ),
                );
              });
              break;
            case 1:
              setState(() {
                _syncStatus = _SyncStatus.accepted;
                label = 'Sincronización exitosa';
                color = AppColors.secondaryColor;
                textColor = AppColors.white;
                SystemChrome.setSystemUIOverlayStyle(
                  const SystemUiOverlayStyle(
                    statusBarColor: AppColors.secondaryColor,
                    statusBarIconBrightness: Brightness.light,
                  ),
                );
              });
              FlutterForegroundTask.init(
                androidNotificationOptions: AndroidNotificationOptions(
                  channelId: 'foreground_service',
                  channelName: 'Foreground Service Notification',
                  channelDescription:
                      'This notification appears when the foreground service is running.',
                  channelImportance: NotificationChannelImportance.LOW,
                  priority: NotificationPriority.LOW,
                  iconData: const NotificationIconData(
                    resType: ResourceType.mipmap,
                    resPrefix: ResourcePrefix.ic,
                    name: 'launcher',
                  ),
                ),
                iosNotificationOptions: const IOSNotificationOptions(
                  showNotification: true,
                  playSound: false,
                ),
                foregroundTaskOptions: const ForegroundTaskOptions(
                  interval: 5000,
                  isOnceEvent: false,
                  autoRunOnBoot: true,
                  allowWakeLock: true,
                  allowWifiLock: true,
                ),
              );
              _timer = Timer.periodic(
                const Duration(seconds: 5),
                (timer) async {
                  final apps = await AppsHistoryService.getAppsHistory();
                  if (context.mounted) {
                    context.read<ChildActivityBloc>().add(
                          CallAction(
                            params: ChildActivityParams(
                              apps: apps,
                            ),
                          ),
                        );
                  }
                },
              );
              // FlutterForegroundTask.startService(
              //   notificationTitle: 'Parental App - Monitoreo activo',
              //   notificationText: 'Presiona para abrir la app',
              //   callback: startCallback,
              // );

              // Timer-

              break;
            case 2:
              setState(() {
                _syncStatus = _SyncStatus.error;
                label = 'Error al sincronizar';
                color = AppColors.red;
                textColor = AppColors.white;
                SystemChrome.setSystemUIOverlayStyle(
                  const SystemUiOverlayStyle(
                    statusBarColor: AppColors.red,
                    statusBarIconBrightness: Brightness.light,
                  ),
                );
              });
              break;
          }
        } else {
          setState(() {
            color = Theme.of(context).colorScheme.background;
            textColor = Theme.of(context).textTheme.labelSmall?.color;
          });
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).colorScheme.background,
              statusBarIconBrightness: Brightness.light,
            ),
          );
        }
      },
      child: CustomScaffoldWidget(
        padding: EdgeInsets.zero,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_syncStatus == _SyncStatus.loading) ...[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        'Sincronizando datos...',
                        style: AppStyles.w400(16),
                      ),
                    ],
                  ),
                ),
              ],
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: _syncStatus != _SyncStatus.loading ? sizer.height : 0,
                width: sizer.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color,
                  shape: _syncStatus != _SyncStatus.loading
                      ? BoxShape.rectangle
                      : BoxShape.circle,
                ),
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 250),
                  scale: _syncStatus != _SyncStatus.loading ? 1 : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: _syncStatus != _SyncStatus.loading ? 1 : 0,
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _syncStatus == _SyncStatus.pending
                                  ? Icons.access_time_outlined
                                  : _syncStatus == _SyncStatus.accepted
                                      ? Icons.check_circle
                                      : Icons.close,
                              color: AppColors.white,
                              size: 64,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              label ?? 'Cargando',
                              style: AppStyles.w600(16, textColor),
                            ),
                            if (_syncStatus != _SyncStatus.accepted) ...[
                              const SizedBox(height: 16),
                              CustomButtonWidget(
                                text: 'Reintentar',
                                backgroundColor: Colors.transparent,
                                textColor: textColor,
                                onTap: () {
                                  setState(() {
                                    _syncStatus = _SyncStatus.loading;
                                  });
                                  context
                                      .read<ChildStatusBloc>()
                                      .add(const CallAction());
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
