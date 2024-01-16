import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/app/widgets/custom_scaffold_widget.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';

enum _SyncStatus { loading, success, error }

class SyncStatusPage extends StatefulWidget {
  const SyncStatusPage({super.key});

  @override
  State<SyncStatusPage> createState() => _SyncStatusPageState();
}

class _SyncStatusPageState extends State<SyncStatusPage> {
  _SyncStatus _syncStatus = _SyncStatus.loading;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startTimer();
    });
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _syncStatus = _SyncStatus.success;
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: _syncStatus == _SyncStatus.success
                ? AppColors.secondaryColor
                : AppColors.red,
            statusBarIconBrightness: Brightness.light,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizer = ScreenSizer.of(context);
    return CustomScaffoldWidget(
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
                color: _syncStatus == _SyncStatus.error
                    ? AppColors.red
                    : _syncStatus == _SyncStatus.loading
                        ? AppColors.backgroundColor
                        : AppColors.secondaryColor,
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
                            _syncStatus == _SyncStatus.success
                                ? Icons.check_circle
                                : Icons.close,
                            color: AppColors.white,
                            size: 64,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _syncStatus == _SyncStatus.success
                                ? 'Sincronización exitosa'
                                : 'Error al sincronizar',
                            style: AppStyles.w600(16, AppColors.white),
                          ),
                          if (_syncStatus == _SyncStatus.error) ...[
                            const SizedBox(height: 16),
                            CustomButtonWidget(
                              text: 'Reintentar',
                              backgroundColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  _syncStatus = _SyncStatus.loading;
                                  SystemChrome.setSystemUIOverlayStyle(
                                    const SystemUiOverlayStyle(
                                      statusBarColor: Colors.transparent,
                                      statusBarIconBrightness: Brightness.dark,
                                    ),
                                  );
                                  startTimer();
                                });
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
    );
  }
}
