import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';

class CustomAppName extends StatelessWidget {
  const CustomAppName({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppStyles.w700(16, Theme.of(context).textTheme.bodyLarge?.color),
        text: 'Parental ',
        children: [
          TextSpan(
            text: 'App',
            style: AppStyles.w700(16, AppColors.secondaryColor),
          ),
        ],
      ),
    );
  }
}
