import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_icon_button.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';

class CustomBackButton extends CustomIconButton {
  const CustomBackButton({super.key})
      : super(
          icon: Icons.arrow_back_ios_new_outlined,
          color: AppColors.gray,
          size: 18,
          onPressed: NavigatorRouter.pop,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        super.build(context),
      ],
    );
  }
}
