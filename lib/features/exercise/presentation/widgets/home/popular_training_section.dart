import 'package:fitness/config/di/di.dart';
import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/shimmer/popular_training_section_shimmer.dart';
import 'package:fitness/features/exercise/presentation/widgets/home/popular_training_card.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_cubit.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_intents.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PopularTrainingSection extends StatelessWidget {
  const PopularTrainingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<PopularTrainingCubit>()
            ..doEvents(const LoadPopularTrainingIntent()),
      child: BlocBuilder<PopularTrainingCubit, PopularTrainingStates>(
        builder: (context, state) {
          if (state.isLoading) {
            return const PopularTrainingSectionShimmer();
          }

          if (state.errorMessage != null) {
            return SizedBox(
              height: 180,
              child: Center(
                child: Text(
                  state.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            );
          }

          final items = state.data ?? [];
          if (items.isEmpty) {
            return const SizedBox.shrink();
          }

          return SizedBox(
            height: 190,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length > 3 ? 3 : items.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                final videoId = YoutubePlayer.convertUrlToId(
                  item.exercise.shortYoutubeDemonstrationLink ?? '',
                );
                final thumbnailUrl = videoId != null
                    ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
                    : null;

                return PopularTrainingCard(
                  title: item.exercise.exercise ?? 'Training',
                  taskCount: item.exerciseCount,
                  level: item.displayLevel,
                  networkImage: thumbnailUrl,
                  onTap: () {
                    final muscleId =
                        (item.exercise.primeMoverMuscle != null &&
                            item.exercise.primeMoverMuscle!.isNotEmpty)
                        ? item.exercise.primeMoverMuscle!
                        : (item.exercise.targetMuscleGroup != null &&
                              item.exercise.targetMuscleGroup!.isNotEmpty)
                        ? item.exercise.targetMuscleGroup!
                        : '69d982ef85f6bfa972bf2248';

                    Navigator.pushNamed(
                      context,
                      Routes.exerciseRoute,
                      arguments: {
                        'primeMoverMuscleId': muscleId,
                        'initialExercise': item.exercise,
                        if (item.exercise.id != null &&
                            item.exercise.id!.isNotEmpty)
                          'exerciseId': item.exercise.id,
                        if (item.exercise.exercise != null &&
                            item.exercise.exercise!.isNotEmpty)
                          'exerciseName': item.exercise.exercise,
                        if (item.exercise.difficultyLevel != null &&
                            item.exercise.difficultyLevel!.isNotEmpty)
                          'difficultyLevel': item.exercise.difficultyLevel,
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
