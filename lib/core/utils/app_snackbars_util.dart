import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';

class AppSnackbars {
  static warn(
    BuildContext context, {
    required String message,
    String? description,
    bool removeCurrent = false,
    EdgeInsetsGeometry? margin,
    Duration? duration,
  }) {
    _showSnackBar(
      icon: Icons.warning_amber,
      title: message,
      color: Colors.white,
      removeCurrent: removeCurrent,
      margin: margin,
      duration: duration,
      context: context,
      description: description,
    );
  }

  static error(
    BuildContext context, {
    required String message,
    String? description,
    bool removeCurrent = false,
    EdgeInsetsGeometry? margin,
    Duration? duration,
  }) {
    _showSnackBar(
      icon: Icons.close,
      title: message,
      color: Colors.red[400]!,
      removeCurrent: removeCurrent,
      margin: margin,
      duration: duration,
      context: context,
      description: description,
    );
  }

  static success(
    BuildContext context, {
    required String message,
    String? description,
    bool removeCurrent = false,
    EdgeInsetsGeometry? margin,
    Duration? duration,
  }) {
    _showSnackBar(
      icon: Icons.check_circle_outline,
      title: message,
      color: AppColors.green,
      removeCurrent: removeCurrent,
      margin: margin,
      duration: duration,
      context: context,
      description: description,
    );
  }

  static void _showSnackBar({
    required IconData icon,
    required String title,
    required Color color,
    required bool removeCurrent,
    required BuildContext context,
    required EdgeInsetsGeometry? margin,
    required Duration? duration,
    required String? description,
  }) {
    if (removeCurrent) ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.vertical,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: duration ?? const Duration(milliseconds: 3000),
        backgroundColor: Colors.transparent,
        content: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(icon, color: AppColors.black),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppStyles.w600(
                        14,
                        Theme.of(context).textTheme.labelLarge?.color,
                      ),
                    ),
                    SizedBox(height: description != null ? 4 : 0),
                    if (description != null)
                      Text(
                        description,
                        style: AppStyles.w400(
                          12,
                          Theme.of(context).textTheme.labelLarge?.color,
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
