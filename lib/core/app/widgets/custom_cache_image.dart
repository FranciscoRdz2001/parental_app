import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_shimmer.dart';

class CustomCacheImage extends StatelessWidget {
  const CustomCacheImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.memHeight,
    this.memWidth,
  }) : super(key: key);

  final String? imageUrl;
  final BoxFit fit;
  final double? height;
  final double? width;
  final int? memHeight;
  final int? memWidth;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: ValueKey<String>(imageUrl ?? ''),
      imageUrl: imageUrl ?? '',
      cacheKey: imageUrl,
      memCacheHeight: memHeight,
      memCacheWidth: memWidth,
      height: height,
      width: width,
      fit: fit,
      progressIndicatorBuilder: (context, url, progress) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return CustomShimmer(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
            );
          },
        );
      },
      errorWidget: (context, url, error) {
        return const Center(
          child: Icon(
            Icons.broken_image,
            color: AppColors.lightGray,
          ),
        );
      },
    );
  }
}
