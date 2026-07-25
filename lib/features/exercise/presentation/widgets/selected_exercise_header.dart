import 'package:fitness/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/exercise.dart';
import 'info_chip.dart';

class SelectedExerciseHeader extends StatelessWidget {
  final Exercise exercise;

  const SelectedExerciseHeader({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(
      exercise.shortYoutubeDemonstrationLink ?? '',
    );
    final thumbnailUrl = videoId != null
        ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
        : null;

    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          Positioned.fill(
            child: thumbnailUrl != null
                ? Image.network(
                    thumbnailUrl,
                    fit: BoxFit.cover,
                    color: Colors.black.withValues(alpha: 0.5),
                    colorBlendMode: BlendMode.darken,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      AppAssets.exercisesBackground,
                      fit: BoxFit.cover,
                      color: Colors.black.withValues(alpha: 0.5),
                      colorBlendMode: BlendMode.darken,
                    ),
                  )
                : Image.asset(
                    AppAssets.exercisesBackground,
                    fit: BoxFit.cover,
                    color: Colors.black.withValues(alpha: 0.5),
                    colorBlendMode: BlendMode.darken,
                  ),
          ),
          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
          ),
          // Exercise Info
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.exercise ?? 'N/A',
                    style: AppTextStyles.bold24(
                      context,
                    ).copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tempus volutpat ut nisi morbi.',
                    style: AppTextStyles.regular14(
                      context,
                    ).copyWith(color: AppColors.grayD3),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      InfoChip(label: '30 MIN'),
                      SizedBox(width: 8),
                      InfoChip(label: '130 Cal', isHighlight: true),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
