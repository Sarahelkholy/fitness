import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class PopularTrainingCard extends StatelessWidget {
  final String? imagePath;
  final String? networkImage;
  final String title;
  final int taskCount;
  final String level;
  final Color levelTextColor;
  final VoidCallback? onTap;

  const PopularTrainingCard({
    super.key,
    this.imagePath,
    this.networkImage,
    required this.title,
    required this.taskCount,
    required this.level,
    this.levelTextColor = AppColors.main,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 180,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.jetBlack.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(child: _buildImage()),

            // Dark Overlay Gradient for text readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.jetBlack.withValues(alpha: 0.2),
                      AppColors.jetBlack.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
            ),

            // Card Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Text
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.semiBold14(context),
                  ),

                  const SizedBox(height: 12),

                  // Bottom Tags Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tasks Badge
                      _buildPillBadge(
                        context: context,
                        text: '$taskCount Tasks',
                        textColor: Colors.white,
                      ),

                      // Difficulty Badge
                      _buildPillBadge(
                        context: context,
                        text: level,
                        textColor: levelTextColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    final path = networkImage ?? imagePath;
    if (path != null && path.isNotEmpty) {
      if (path.startsWith('http://') || path.startsWith('https://')) {
        return Image.network(
          path,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Image.asset(AppAssets.exercisesBackground, fit: BoxFit.cover),
        );
      }
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Image.asset(AppAssets.exercisesBackground, fit: BoxFit.cover),
      );
    }
    return Image.asset(AppAssets.exercisesBackground, fit: BoxFit.cover);
  }

  Widget _buildPillBadge({
    required BuildContext context,
    required String text,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.darkCharcoal.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppTextStyles.regular12(context).copyWith(color: textColor),
      ),
    );
  }
}
