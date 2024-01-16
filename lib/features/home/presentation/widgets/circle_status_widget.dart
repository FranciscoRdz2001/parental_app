import 'package:flutter/material.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';

class CircleStatusWidget extends StatelessWidget {
  const CircleStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 16,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
