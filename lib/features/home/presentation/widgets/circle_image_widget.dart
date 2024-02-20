import 'package:flutter/material.dart';
import 'package:parental_app/core/app/widgets/custom_cache_image.dart';

class CircleImageWidget extends StatelessWidget {
  final double size;
  final Widget? child;
  final String? imageUrl;
  const CircleImageWidget({
    super.key,
    required this.size,
    this.child,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: (imageUrl?.isEmpty ?? true
            ? child ?? const SizedBox()
            : CustomCacheImage(imageUrl: imageUrl)),
      ),
    );
  }
}
