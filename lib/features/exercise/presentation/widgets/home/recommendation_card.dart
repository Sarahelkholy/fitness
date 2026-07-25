import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  final String? networkImage;
  final String? image;
  final String? title;

  const RecommendationCard({
    super.key,
    this.networkImage,
    this.title,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(
              child: _buildImage(),
            ),
            Container(
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.darkCharcoal.withValues(alpha: 0.6),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              child: Center(
                child: Text(
                  title ?? '',
                  style: AppTextStyles.regular12(context),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    final path = networkImage ?? image;
    if (path != null && path.isNotEmpty) {
      if (path.startsWith('http://') || path.startsWith('https://')) {
        return Image.network(
          path,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            AppAssets.exercisesBackground,
            fit: BoxFit.cover,
          ),
        );
      }
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          AppAssets.exercisesBackground,
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(
      AppAssets.exercisesBackground,
      fit: BoxFit.cover,
    );
  }
}
