import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final double size;
  const CircleImageWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: BoxShape.circle,
      ),
    );
  }
}
