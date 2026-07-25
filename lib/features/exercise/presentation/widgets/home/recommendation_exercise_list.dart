import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_entity.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'recommendation_card.dart';

class RecommendationExerciseList extends StatelessWidget {
  final List<RandomExerciseEntity> exercises;

  const RecommendationExerciseList({super.key, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          final videoId = YoutubePlayer.convertUrlToId(
            exercise.shortYoutubeDemonstrationLink ?? '',
          );
          final thumbnailUrl = videoId != null
              ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
              : null;

          return GestureDetector(
            onTap: () {
              final muscleId =
                  (exercise.primeMoverMuscleId != null &&
                          exercise.primeMoverMuscleId!.isNotEmpty)
                      ? exercise.primeMoverMuscleId!
                      : '69d982ef85f6bfa972bf2248';
              Navigator.pushNamed(
                context,
                Routes.exerciseRoute,
                arguments: {
                  'primeMoverMuscleId': muscleId,
                  'initialExercise': exercise.toExercise(),
                  if (exercise.id != null && exercise.id!.isNotEmpty)
                    'exerciseId': exercise.id,
                  if (exercise.exercise != null && exercise.exercise!.isNotEmpty)
                    'exerciseName': exercise.exercise,
                  if (exercise.difficultyLevel != null &&
                      exercise.difficultyLevel!.isNotEmpty)
                    'difficultyLevel': exercise.difficultyLevel,
                },
              );
            },
            child: RecommendationCard(
              title: exercise.exercise,
              networkImage: thumbnailUrl,
            ),
          );
        },
      ),
    );
  }
}
