import 'package:flutter/material.dart';
import 'package:parental_app/core/app/widgets/custom_shimmer.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';

class AllUserAppsPlaceholder extends StatelessWidget {
  final int items;
  const AllUserAppsPlaceholder({super.key, this.items = 5});

  @override
  Widget build(BuildContext context) {
    final sizer = ScreenSizer.of(context);
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: items,
      itemBuilder: (context, x) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const ClipOval(
                child: CustomShimmer(height: 48, width: 48),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomShimmer(height: 14),
                    const SizedBox(height: 8),
                    CustomShimmer(
                      height: 12,
                      width: sizer.wp(25),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, x) {
        return const SizedBox(height: 16);
      },
    );
  }
}
