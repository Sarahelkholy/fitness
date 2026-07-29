import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class UpcomingWorkoutCard extends StatelessWidget {
  final String? image;
  final String title;
  const UpcomingWorkoutCard({super.key, this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    const String defaultImageUrl =
        'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=300';

    return Container(
      width: 85,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(image ?? defaultImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 25,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.darkCharcoal.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: AppTextStyles.regular12(context),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
