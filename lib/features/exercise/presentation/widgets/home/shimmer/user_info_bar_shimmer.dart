import 'package:fitness/core/shared_widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class UserInfoBarShimmer extends StatelessWidget {
  const UserInfoBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseShimmerLoading(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerBox(width: 100, height: 16, borderRadius: 4),
              SizedBox(height: 8),
              ShimmerBox(width: 150, height: 20, borderRadius: 4),
            ],
          ),
          ShimmerBox(width: 50, height: 50, borderRadius: 25),
        ],
      ),
    );
  }
}
