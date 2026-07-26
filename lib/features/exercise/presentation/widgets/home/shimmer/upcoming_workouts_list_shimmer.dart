import 'package:fitness/core/shared_widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class UpcomingWorkoutsListShimmer extends StatelessWidget {
  const UpcomingWorkoutsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: BaseShimmerLoading(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: ShimmerBox(width: 85, height: 120, borderRadius: 20),
            );
          },
        ),
      ),
    );
  }
}
