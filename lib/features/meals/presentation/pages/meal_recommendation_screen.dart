import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/core/shared_widgets/custom_error_widget.dart';
import 'package:fitness/core/shared_widgets/custom_grid_item.dart';
import 'package:fitness/core/shared_widgets/custom_loading_indicator.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/shared_widgets/custom_tab_bar.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/core/values/keys_strings.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_cubit.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_event.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';

class MealRecommendationScreen extends StatefulWidget {
  final int initialIndex;

  const MealRecommendationScreen({super.key, this.initialIndex = 0});

  @override
  State<MealRecommendationScreen> createState() =>
      _MealRecommendationScreenState();
}

class _MealRecommendationScreenState extends State<MealRecommendationScreen> {
  late AppLocalizations localizations;
  late final MealRecommendationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MealRecommendationCubit>();
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
        title: Text(localizations.foodRecommendation),
      ),
      body: RefreshIndicator(
        key: const Key(KeysStrings.mealRecommendationRefreshIndicator),
        onRefresh: () async {
          _cubit.doEvents(GetCategoriesEvent());
        },
        color: AppColors.main,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingHorizontal,
          ),
          child: Stack(
            children: [
              BlocBuilder<MealRecommendationCubit, MealRecommendationState>(
                builder: (context, state) {
                  if (state.categoriesState.isLoading) {
                    return const CustomLoadingIndicator();
                  } else if (state.categoriesState.errorMessage != null) {
                    return CustomErrorWidget(
                      errorMessage: state.categoriesState.errorMessage!,
                      haveTryAgain: true,
                      onPressed: () => _cubit.doEvents(GetCategoriesEvent()),
                    );
                  }

                  final categories = state.categoriesState.data ?? [];

                  if (categories.isEmpty) {
                    return CustomErrorWidget(
                      errorMessage: localizations.noCategoriesFound,
                      haveTryAgain: true,
                      onPressed: () => _cubit.doEvents(GetCategoriesEvent()),
                    );
                  }

                  return SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        CustomTabBar(
                          key: const Key(KeysStrings.mealRecommendationTabBar),
                          tabs: categories.map((e) => e.name).toList(),
                          selectedIndex: state.selectedCategoryIndex,
                          onTabChanged: (index) {
                            if (state.selectedCategoryIndex == index) return;
                            _cubit.doEvents(
                              GetMealsByCategoryEvent(
                                category: categories[index].name,
                                index: index,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (state.mealsState.isLoading) {
                                return const CustomLoadingIndicator();
                              } else if (state.mealsState.errorMessage !=
                                  null) {
                                return CustomErrorWidget(
                                  errorMessage: state.mealsState.errorMessage!,
                                  haveTryAgain: true,
                                  onPressed: () => _cubit.doEvents(
                                    GetMealsByCategoryEvent(
                                      category:
                                          categories[state
                                                  .selectedCategoryIndex]
                                              .name,
                                      index: state.selectedCategoryIndex,
                                    ),
                                  ),
                                );
                              } else if (state.mealsState.data != null &&
                                  state.mealsState.data!.isEmpty) {
                                return CustomErrorWidget(
                                  errorMessage: localizations.noMealsFound,
                                );
                              } else if (state.mealsState.data != null) {
                                return GridView.builder(
                                  key: const Key(
                                    KeysStrings.mealRecommendationGridView,
                                  ),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        childAspectRatio: 1,
                                      ),
                                  itemCount: state.mealsState.data!.length,
                                  itemBuilder: (context, index) {
                                    final meal = state.mealsState.data![index];
                                    return CustomGridItem(
                                      title: meal.name,
                                      imageUrl: meal.image,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.mealDetailsRoute,
                                          arguments: meal.id,
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
