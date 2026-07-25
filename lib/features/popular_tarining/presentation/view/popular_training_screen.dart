import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_cubit.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_intents.dart';
import 'package:fitness/features/popular_tarining/presentation/view_model/popular_training_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTrainingScreen extends StatelessWidget {
  const PopularTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PopularTrainingCubit>(
      create: (context) =>
          getIt<PopularTrainingCubit>()
            ..doEvents(const LoadPopularTrainingIntent()),
      child: CustomScaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Popular Training'),
        ),
        body: BlocBuilder<PopularTrainingCubit, PopularTrainingStates>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PopularTrainingCubit>().doEvents(
                          const LoadPopularTrainingIntent(),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final items = state.data ?? [];
            if (items.isEmpty) {
              return const Center(
                child: Text('No popular training exercises found.'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () {
                    final muscleId = item.exercise.primeMoverMuscle ??
                        '69d982ef85f6bfa972bf2248';
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
                  borderRadius: BorderRadius.circular(12),
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.exercise.exercise ?? 'Unknown Exercise',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.fitness_center,
                                size: 16,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Muscle: ${item.exercise.targetMuscleGroup ?? 'N/A'}',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.bar_chart,
                                size: 16,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Level: ${item.displayLevel}',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.format_list_numbered,
                                size: 16,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Exercises Available: ${item.exerciseCount}',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
