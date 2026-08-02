import 'package:fitness/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      AppAssets.loadingLottie,
      width: 200,
      height: 100,
      fit: BoxFit.contain,
    );
  }
}
