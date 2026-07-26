import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_entity.dart';
import 'package:flutter/material.dart';
import 'recommendation_card.dart';

class RecommendationExerciseList extends StatelessWidget {
  final List<RandomExerciseEntity> muscles;

  const RecommendationExerciseList({super.key, required this.muscles});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: muscles.length,
        itemBuilder: (context, index) {
          final muscle = muscles[index];

          return GestureDetector(
            onTap: () {
              String muscleId = '';
              if (muscle.id != null && muscle.id!.isNotEmpty) {
                muscleId = muscle.id!;
              } else if (muscle.name != null && muscle.name!.isNotEmpty) {
                muscleId = muscle.name!;
              }
              Navigator.pushNamed(
                context,
                Routes.exerciseRoute,
                arguments: {'primeMoverMuscleId': muscleId},
              );
            },
            child: RecommendationCard(
              title: muscle.name,
              networkImage: muscle.image is String
                  ? muscle.image as String
                  : null,
            ),
          );
        },
      ),
    );
  }
}
