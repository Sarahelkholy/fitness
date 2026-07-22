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

  ImageProvider _getImageProvider() {
    if (networkImage != null && networkImage!.isNotEmpty) {
      return NetworkImage(networkImage!);
    }
    return AssetImage(image ?? AppAssets.exercisesBackground);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: _getImageProvider(), fit: BoxFit.cover),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.darkCharcoal.withOpacity(0.5),
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
    );
  }
}
