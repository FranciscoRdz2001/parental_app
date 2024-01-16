import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';

enum ApButtonType {
  small,
  medium,
  large,
}

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({
    super.key,
    required this.text,
    this.textColor,
    this.loadingText = 'Cargando...',
    this.isLoading = false,
    this.type = ApButtonType.medium,
    this.center = true,
    this.onTap,
    this.prefixIcon,
    this.customStyle,
    this.borderColor,
    this.suffixIcon,
    this.customPadding,
    this.radius = 16,
    this.iconsSpace = 16,
    this.maxLines,
    this.customChildPadding,
    this.backgroundColor = AppColors.primaryColor,
  })  : style = type == ApButtonType.small
            ? AppStyles.w500(14)
            : type == ApButtonType.medium
                ? AppStyles.w500(14)
                : type == ApButtonType.large
                    ? AppStyles.w500(14)
                    : AppStyles.w500(14),
        padding = customChildPadding ??
            (type == ApButtonType.small
                ? 2
                : type == ApButtonType.medium
                    ? 4
                    : 8);
  final void Function()? onTap;
  final String text;
  final String loadingText;
  final bool isLoading;
  final ApButtonType type;
  final Color backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool center;

  final double padding;
  final double radius;
  final TextStyle style;
  final TextStyle? customStyle;
  final double iconsSpace;
  final EdgeInsets? customPadding;
  final int? maxLines;
  final double? customChildPadding;

  @override
  Widget build(BuildContext context) {
    final label = Text(
      isLoading ? loadingText : text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: customStyle ??
          style.copyWith(
            color: textColor ?? Colors.white,
          ),
      textAlign: TextAlign.center,
    );
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.5,
        backgroundColor: backgroundColor,
        padding: customPadding ??
            EdgeInsets.symmetric(horizontal: padding, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: borderColor != null
              ? BorderSide(
                  color: borderColor!,
                )
              : BorderSide.none,
        ),
      ),
      onPressed: isLoading ? null : onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: Row(
          mainAxisSize: center ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment:
              center ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              SizedBox(width: iconsSpace),
            ],
            Flexible(child: label),
            const SizedBox(height: 8),
            if (isLoading)
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            if (suffixIcon != null) ...[
              SizedBox(width: iconsSpace),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
