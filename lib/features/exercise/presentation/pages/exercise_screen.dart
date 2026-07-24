import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/shared_widgets/custom_tab_bar.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/utils/app_colors.dart';
import 'package:fitness/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../manager/exercise_cubit/exercise_cubit.dart';
import '../manager/exercise_cubit/exercise_event.dart';
import '../manager/exercise_cubit/exercise_state.dart';
import '../widgets/exercise_list_item.dart';
import '../widgets/selected_exercise_header.dart';

class ExerciseScreen extends StatefulWidget {
  final String primeMoverMuscleId;

  const ExerciseScreen({super.key, required this.primeMoverMuscleId});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late ExerciseCubit _cubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ExerciseCubit>();
    _cubit.doIntent(
      GetDifficultyLevelsEvent(primeMoverMuscleId: widget.primeMoverMuscleId),
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = _cubit.state;
      if (!state.exercisesState.isLoading &&
          state.currentPage < state.totalPages) {
        _cubit.doIntent(GetExercisesEvent(page: state.currentPage + 1));
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _showVideoDialog(String? videoUrl) {
    if (videoUrl == null || videoUrl.isEmpty) return;
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId == null) return;

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black,
                border: Border.all(
                  color: AppColors.main.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: videoId,
                  flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
                ),
                showVideoProgressIndicator: true,
                progressIndicatorColor: AppColors.main,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.main,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppAssets.exerciseBackgroundBlur,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Exercise',
          style: AppTextStyles.bold18(context).copyWith(color: AppColors.white),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<ExerciseCubit, ExerciseState>(
        builder: (context, state) {
          if (state.difficultyLevelsState.isLoading &&
              state.difficultyLevelsState.data == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.main),
            );
          }

          return Column(
            children: [
              // Upper Section: Selected Exercise Info
              BlocBuilder<ExerciseCubit, ExerciseState>(
                buildWhen: (previous, current) =>
                    previous.selectedExercise != current.selectedExercise ||
                    previous.exercisesState.isLoading !=
                        current.exercisesState.isLoading,
                builder: (context, state) {
                  if (state.exercisesState.isLoading &&
                      state.currentPage == 1) {
                    return const SizedBox(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(color: AppColors.main),
                      ),
                    );
                  }
                  final exercise = state.selectedExercise;
                  if (exercise == null) return const SizedBox.shrink();

                  return SelectedExerciseHeader(exercise: exercise);
                },
              ),

              const SizedBox(height: 16),

              // Tab Bar: Difficulty Levels
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: state.difficultyLevelsState.data != null
                    ? CustomTabBar(
                        tabs: state.difficultyLevelsState.data!
                            .map((e) => e.name ?? '')
                            .toList(),
                        selectedIndex: state.difficultyLevelsState.data!
                            .indexWhere(
                              (e) => e.id == state.selectedDifficultyLevel?.id,
                            ),
                        onTabChanged: (index) {
                          final selectedLevel =
                              state.difficultyLevelsState.data![index];
                          _cubit.doIntent(
                            SelectDifficultyLevelEvent(selectedLevel),
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 16),

              // Exercise List
              Expanded(
                child:
                    state.exercisesState.isLoading &&
                        state.exercisesState.data == null
                    ? const Center(
                        child: CircularProgressIndicator(color: AppColors.main),
                      )
                    : state.exercisesState.errorMessage != null &&
                          (state.exercisesState.data == null ||
                              state.exercisesState.data!.isEmpty)
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            state.exercisesState.errorMessage!,
                            style: AppTextStyles.regular14(
                              context,
                            ).copyWith(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : ListView.separated(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount:
                            (state.exercisesState.data?.length ?? 0) +
                            (state.exercisesState.isLoading ? 1 : 0),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          if (index <
                              (state.exercisesState.data?.length ?? 0)) {
                            final exercise = state.exercisesState.data![index];
                            return ExerciseListItem(
                              exercise: exercise,
                              isSelected:
                                  state.selectedExercise?.id == exercise.id,
                              onTap: () {
                                _cubit.doIntent(SelectExerciseEvent(exercise));
                              },
                              onPlay: () {
                                _showVideoDialog(
                                  exercise.shortYoutubeDemonstrationLink,
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.main,
                              ),
                            );
                          }
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
