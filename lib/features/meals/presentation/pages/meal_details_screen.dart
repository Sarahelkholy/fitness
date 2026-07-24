import 'package:fitness/core/shared_widgets/cached_network_image_wrapper.dart';
import 'package:fitness/core/shared_widgets/custom_error_widget.dart';
import 'package:fitness/core/shared_widgets/custom_loading_indicator.dart';
import 'package:fitness/features/meals/presentation/manager/meal_details_cubit/meal_details_cubit.dart';
import 'package:fitness/features/meals/presentation/manager/meal_details_cubit/meal_details_event.dart';
import 'package:fitness/features/meals/presentation/manager/meal_details_cubit/meal_details_state.dart';
import 'package:fitness/features/meals/presentation/widgets/meal_info_badge.dart';
import 'package:fitness/features/meals/presentation/widgets/meal_ingredients_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/custom_scaffold.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_text_styles.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({super.key, required this.mealId});

  final String mealId;

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  late AppLocalizations localizations;
  late final MealDetailsCubit _cubit;

  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MealDetailsCubit>();
  }

  void _initYoutubeController(String url) {
    if (_controller != null) return;

    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppAssets.mealsBackground,
      body: SafeArea(
        child: BlocBuilder<MealDetailsCubit, MealDetailsState>(
          builder: (context, state) {
            if (state.mealDetailsState.isLoading) {
              return const CustomLoadingIndicator();
            } else if (state.mealDetailsState.errorMessage != null) {
              return CustomErrorWidget(
                errorMessage: state.mealDetailsState.errorMessage!,
                haveTryAgain: true,
                onPressed: () =>
                    _cubit.doEvents(GetMealDetailsEvent(mealId: widget.mealId)),
              );
            }

            final meal = state.mealDetailsState.data;
            if (meal == null) return const SizedBox.shrink();

            if (meal.youtubeUrl.isNotEmpty) {
              _initYoutubeController(meal.youtubeUrl);
            }

            final scrollableContent = Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingHorizontal,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meal.name,
                            style: AppTextStyles.medium24(
                              context,
                            ).copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            meal.instructions,
                            style: AppTextStyles.regular16(
                              context,
                            ).copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MealInfoBadge(
                                label: localizations.category,
                                value: meal.category,
                              ),
                              MealInfoBadge(
                                label: localizations.area,
                                value: meal.area,
                              ),
                              MealInfoBadge(
                                label: localizations.country,
                                value: meal.country,
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Text(
                            localizations.ingredients,
                            style: AppTextStyles.bold20(
                              context,
                            ).copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingHorizontal,
                      ),
                      child: MealIngredientsList(ingredients: meal.ingredients),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );

            if (_controller != null) {
              return YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: AppColors.main,
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          if (state.showYoutubePlayer)
                            SizedBox(
                              height: 350,
                              width: double.infinity,
                              child: player,
                            )
                          else
                            CachedNetworkImageWrapper(
                              imagePath: meal.image,
                              height: 350,
                              width: double.infinity,
                            ),
                          if (!state.showYoutubePlayer &&
                              meal.youtubeUrl.isNotEmpty)
                            Positioned.fill(
                              child: Center(
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.play_circle_fill,
                                    color: AppColors.white,
                                    size: 64,
                                  ),
                                  onPressed: () {
                                    _cubit.doEvents(PlayVideoEvent());
                                  },
                                ),
                              ),
                            ),
                          PositionedDirectional(
                            top: 20,
                            start: 16,
                            child: IconButton(
                              icon: const CircleAvatar(
                                backgroundColor: AppColors.main,
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 16,
                                  color: AppColors.white,
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                      scrollableContent,
                    ],
                  );
                },
              );
            }

            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImageWrapper(
                      imagePath: meal.image,
                      height: 350,
                      width: double.infinity,
                    ),
                    PositionedDirectional(
                      top: 20,
                      start: 16,
                      child: IconButton(
                        icon: const CircleAvatar(
                          backgroundColor: AppColors.main,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 16,
                            color: AppColors.white,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                scrollableContent,
              ],
            );
          },
        ),
      ),
    );
  }
}
