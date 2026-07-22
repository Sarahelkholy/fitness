import 'package:flutter/material.dart';
import 'package:fitness/features/exercise/domain/entities/home/random_exercises_entity.dart';
import 'recommendation_card.dart'; // تأكد من استيراد الكارت

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
          return RecommendationCard(title: exercises[index].exercise);
        },
      ),
    );
  }
}
