import 'package:fitness/core/shared_widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

/// Popular Training Card Shimmer
class PopularTrainingSectionShimmer extends StatelessWidget {
  const PopularTrainingSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: BaseShimmerLoading(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: ShimmerBox(width: 200, height: 180, borderRadius: 20),
            );
          },
        ),
      ),
    );
  }
}
