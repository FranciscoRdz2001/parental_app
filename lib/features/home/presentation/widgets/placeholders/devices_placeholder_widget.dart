import 'package:flutter/material.dart';
import 'package:parental_app/core/app/widgets/custom_shimmer.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';

class DevicesPlaceholderWidget extends StatelessWidget {
  const DevicesPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sizer = ScreenSizer.of(context);

    return SizedBox(
      height: 120,
      child: ListView.separated(
        clipBehavior: Clip.none,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, x) {
          return CustomShimmer(
            height: 120,
            width: sizer.wp(70),
            color: Colors.red,
          );
        },
        separatorBuilder: (_, x) {
          return const SizedBox(width: 16);
        },
      ),
    );
  }
}
