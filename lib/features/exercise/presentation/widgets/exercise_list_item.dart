import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/exercise.dart';

class ExerciseListItem extends StatelessWidget {
  final Exercise exercise;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onPlay;

  const ExerciseListItem({
    super.key,
    required this.exercise,
    required this.isSelected,
    required this.onTap,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final videoId = _extractYoutubeId(exercise.shortYoutubeDemonstrationLink ?? '');
    final thumbnailUrl = videoId != null
        ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
        : 'https://via.placeholder.com/80';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gray3A : AppColors.darkCharcoal,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                thumbnailUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.gray3A,
                  child: const Icon(Icons.error, color: AppColors.main),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.exercise ?? 'N/A',
                    style: AppTextStyles.bold16(
                      context,
                    ).copyWith(color: AppColors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '3 Groups * 15 Times', // Hardcoded as requested by design
                    style: AppTextStyles.regular12(
                      context,
                    ).copyWith(color: AppColors.grayA7),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: AppTextStyles.regular12(
                      context,
                    ).copyWith(color: AppColors.gray91),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onPlay,
              icon: const Icon(
                Icons.play_circle_fill,
                color: AppColors.main,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _extractYoutubeId(String url) {
    if (url.isEmpty) return null;
    final regExp = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
    );
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }
}
