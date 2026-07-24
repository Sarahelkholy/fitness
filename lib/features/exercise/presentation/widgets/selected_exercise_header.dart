import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/exercise.dart';
import 'info_chip.dart';

class SelectedExerciseHeader extends StatelessWidget {
  final Exercise exercise;

  const SelectedExerciseHeader({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final videoId = _extractYoutubeId(exercise.shortYoutubeDemonstrationLink ?? '');
    final thumbnailUrl = videoId != null
        ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
        : 'https://via.placeholder.com/400x300';

    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(thumbnailUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.5),
            BlendMode.darken,
          ),
          onError: (exception, stackTrace) {
            debugPrint('Error loading image: $exception');
          },
        ),
      ),
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
