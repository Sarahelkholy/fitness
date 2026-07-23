import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final Radius? bottomLeft;
  final Radius? bottomRight;
  final Radius? topLeft;
  final Radius? topRight;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  const GlassContainer({
    super.key,
    required this.child,
    this.bottomLeft,
    this.bottomRight,
    this.topLeft,
    this.topRight,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          borderRadius ??
          BorderRadius.only(
            bottomLeft: bottomLeft ?? const Radius.circular(30),
            bottomRight: bottomRight ?? const Radius.circular(30),
            topLeft: topLeft ?? const Radius.circular(30),
            topRight: topRight ?? const Radius.circular(30),
          ),
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 34, sigmaY: 34),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: AppColors.surfaceOverlayLow),
          child: child,
        ),
      ),
    );
  }
}
