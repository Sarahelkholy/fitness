import 'package:fitness/core/shared_widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class TabsShimmer extends StatelessWidget {
  const TabsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseShimmerLoading(
      child: Row(
        children: [
          ShimmerBox(width: 80, height: 35, borderRadius: 20),
          SizedBox(width: 10),
          ShimmerBox(width: 100, height: 35, borderRadius: 20),
          SizedBox(width: 10),
          ShimmerBox(width: 90, height: 35, borderRadius: 20),
        ],
      ),
    );
  }
}
