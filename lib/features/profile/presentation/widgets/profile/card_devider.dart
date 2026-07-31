import 'package:fitness/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CardDivider extends StatelessWidget {
  const CardDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.gray3A,
      height: 1,
      thickness: 0.8,
      indent: 16,
      endIndent: 16,
    );
  }
}
