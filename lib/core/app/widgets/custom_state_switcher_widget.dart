import 'package:flutter/material.dart';

class CustomStateSwitcher extends StatelessWidget {
  const CustomStateSwitcher({
    super.key,
    required this.isLoading,
    required this.childWidget,
    required this.loadingWidget,
    this.errorWidget,
    this.hasError = false,
  });
  final bool isLoading;
  final bool hasError;

  final Widget childWidget;
  final Widget loadingWidget;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isLoading
          ? loadingWidget
          : hasError
              ? errorWidget ?? loadingWidget
              : childWidget,
    );
  }
}
