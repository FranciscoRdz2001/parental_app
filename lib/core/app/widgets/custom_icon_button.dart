import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
    this.backgroundColor,
    this.size = 24,
    this.padding = 6,
  });
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double size;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final button = InkWell(
      onTap: onPressed,
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        shape: BoxShape.circle,
      ),
      child: button,
    );
  }
}
