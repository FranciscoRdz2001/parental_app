import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class CustomPlaceholderWidget extends StatelessWidget {
  const CustomPlaceholderWidget({
    super.key,
    this.height,
    this.width,
  });
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.placeHolderColor,
      highlightColor: AppColors.placeHolderHighlighColor,
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: AppColors.placeHolderColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
