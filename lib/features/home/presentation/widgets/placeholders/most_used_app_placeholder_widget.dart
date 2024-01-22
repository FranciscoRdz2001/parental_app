import 'package:flutter/material.dart';
import 'package:parental_app/core/app/widgets/custom_shimmer.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';

class MostUsedAppPlaceholderWidget extends StatelessWidget {
  const MostUsedAppPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sizer = ScreenSizer.of(context);

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 4,
      itemBuilder: (context, x) {
        return CustomShimmer(
          height: 100,
          width: sizer.width,
          color: Colors.red,
        );
      },
      separatorBuilder: (_, x) {
        return const SizedBox(height: 16);
      },
    );
  }
}
