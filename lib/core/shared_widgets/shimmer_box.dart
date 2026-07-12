import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/app_colors.dart';

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const ShimmerBox({
    super.key,
    required this.height,
    this.width = double.infinity,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grayD3,
      highlightColor: AppColors.white,

      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.grayD3,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
