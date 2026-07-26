import 'package:fitness/core/shared_widgets/custom_error_widget.dart';
import 'package:fitness/core/shared_widgets/custom_grid_item.dart';
import 'package:fitness/core/shared_widgets/custom_loading_indicator.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/shared_widgets/custom_tab_bar.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/values/keys_strings.dart';
import 'package:fitness/features/exercise/presentation/manager/muscles_cubit/muscles_cubit.dart';
import 'package:fitness/features/exercise/presentation/manager/muscles_cubit/muscles_event.dart';
import 'package:fitness/features/exercise/presentation/manager/muscles_cubit/muscles_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/route_manager/routes.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late AppLocalizations localizations;
  late final MusclesCubit _cubit;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MusclesCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.doEvents(
        GetAllMusclesEvent(
          language: Localizations.localeOf(context).languageCode,
        ),
      );
    });
  }

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final String language = Localizations.localeOf(context).languageCode;

    return CustomScaffold(
      backgroundImage: AppAssets.exercisesBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: AppColors.main,
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: AppColors.white,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(localizations.workouts),
      ),
      body: RefreshIndicator(
        key: const Key(KeysStrings.workoutRefreshIndicator),
        onRefresh: () async {
          _cubit.doEvents(GetAllMusclesEvent(language: language));
        },
        color: AppColors.main,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingHorizontal,
          ),
          child: Stack(
            children: [
              BlocBuilder<MusclesCubit, MusclesState>(
                builder: (context, state) {
                  if (state.musclesGroupsState.isLoading) {
                    return const CustomLoadingIndicator();
                  } else if (state.musclesGroupsState.errorMessage != null) {
                    return CustomErrorWidget(
                      errorMessage: state.musclesGroupsState.errorMessage!,
                      haveTryAgain: true,
                      onPressed: () => _cubit.doEvents(
                        GetAllMusclesEvent(language: language),
                      ),
                    );
                  }

                  final musclesGroups = state.musclesGroupsState.data ?? [];

                  if (musclesGroups.isEmpty) {
                    return CustomErrorWidget(
                      errorMessage: localizations.noMusclesFound,
                      haveTryAgain: true,
                      onPressed: () => _cubit.doEvents(
                        GetAllMusclesEvent(language: language),
                      ),
                    );
                  }

                  return SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        CustomTabBar(
                          key: const Key(KeysStrings.workoutTabBar),
                          tabs: musclesGroups.map((e) => e.name ?? "").toList(),
                          selectedIndex: state.selectedMuscleGroupIndex,
                          onTabChanged: (index) {
                            if (state.selectedMuscleGroupIndex == index) return;
                            selectedIndex = index;
                            _cubit.doEvents(
                              GetWorkoutsByMuscleGroupIdEvent(
                                language: language,
                                muscleGroupId: musclesGroups[index].id ?? "",
                                index: index,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (state.workoutsState.isLoading) {
                                return const CustomLoadingIndicator();
                              } else if (state.workoutsState.errorMessage !=
                                  null) {
                                return CustomErrorWidget(
                                  errorMessage:
                                      state.workoutsState.errorMessage!,
                                  haveTryAgain: true,
                                  onPressed: () => _cubit.doEvents(
                                    GetWorkoutsByMuscleGroupIdEvent(
                                      language: language,
                                      muscleGroupId:
                                          musclesGroups[state
                                                  .selectedMuscleGroupIndex]
                                              .id ??
                                          "",
                                      index: state.selectedMuscleGroupIndex,
                                    ),
                                  ),
                                );
                              } else if (state.workoutsState.data != null &&
                                  state.workoutsState.data!.isEmpty) {
                                return CustomErrorWidget(
                                  errorMessage: localizations.noWorkoutsFound,
                                );
                              } else if (state.workoutsState.data != null) {
                                return GridView.builder(
                                  key: const Key(KeysStrings.workoutGridView),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        childAspectRatio: 1,
                                      ),
                                  itemCount: state.workoutsState.data!.length,
                                  itemBuilder: (context, index) {
                                    final workout =
                                        state.workoutsState.data![index];
                                    return CustomGridItem(
                                      title: workout.name ?? "",
                                      imageUrl: workout.image ?? "",
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.exerciseRoute,
                                          arguments: {
                                            'primeMoverMuscleId': workout.id!,
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
