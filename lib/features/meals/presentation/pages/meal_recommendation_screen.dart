import 'package:fitness/core/helpers/event_handler_mixin.dart';
import 'package:fitness/core/shared_widgets/custom_error_widget.dart';
import 'package:fitness/core/shared_widgets/custom_grid_item.dart';
import 'package:fitness/core/shared_widgets/custom_loading_indicator.dart';
import 'package:fitness/core/shared_widgets/custom_scaffold.dart';
import 'package:fitness/core/shared_widgets/custom_tab_bar.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_cubit.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_event.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';

class MealRecommendationScreen extends StatefulWidget {
  const MealRecommendationScreen({super.key});

  @override
  State<MealRecommendationScreen> createState() =>
      _MealRecommendationScreenState();
}

class _MealRecommendationScreenState extends State<MealRecommendationScreen>
    with EventHandlerMixin {
  late AppLocalizations localizations;
  late final MealRecommendationCubit _cubit;
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MealRecommendationCubit>();

    _cubit.eventStream.listen((event) {
      if (!mounted) return;
      handleEvent(event);
    });
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
        onRefresh: () async {
          setState(() {
            _selectedCategoryIndex = 0;
          });
          _cubit.doEvents(GetCategoriesEvent());
        },
        color: AppColors.main,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingHorizontal,
          ),
          child: Stack(
            children: [
              ListView(physics: const AlwaysScrollableScrollPhysics()),
              BlocBuilder<MealRecommendationCubit, MealRecommendationState>(
                builder: (context, state) {
                  // Case 1: Categories Loading
                  if (state.categoriesState.isLoading) {
                    return const CustomLoadingIndicator();
                  }

                  // Case 2: Categories Error
                  if (state.categoriesState.errorMessage != null) {
                    return CustomErrorWidget(
                      errorMessage: state.categoriesState.errorMessage!,
                      haveTryAgain: true,
                      onPressed: () => _cubit.doEvents(GetCategoriesEvent()),
                    );
                  }

                  final categories = state.categoriesState.data ?? [];

                  // Case 3: Categories Empty
                  if (categories.isEmpty) {
                    return CustomErrorWidget(
                      errorMessage: localizations.noCategoriesFound,
                      haveTryAgain: true,
                      onPressed: () => _cubit.doEvents(GetCategoriesEvent()),
                    );
                  }

                  // Trigger first category fetch if needed
                  if (_selectedCategoryIndex == 0 &&
                      state.mealsState.data == null &&
                      !state.mealsState.isLoading) {
                    _cubit.doEvents(
                      GetMealsByCategoryEvent(category: categories[0].name),
                    );
                  }

                  return SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        CustomTabBar(
                          tabs: categories.map((e) => e.name).toList(),
                          selectedIndex: _selectedCategoryIndex,
                          onTabChanged: (index) {
                            if (_selectedCategoryIndex == index) return;
                            setState(() {
                              _selectedCategoryIndex = index;
                            });
                            _cubit.doEvents(
                              GetMealsByCategoryEvent(
                                category: categories[index].name,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              // Case 4: Meals Loading
                              if (state.mealsState.isLoading) {
                                return const CustomLoadingIndicator();
                              }

                              // Case 5: Meals Error
                              if (state.mealsState.errorMessage != null) {
                                return CustomErrorWidget(
                                  errorMessage: state.mealsState.errorMessage!,
                                  haveTryAgain: true,
                                  onPressed: () => _cubit.doEvents(
                                    GetMealsByCategoryEvent(
                                      category:
                                          categories[_selectedCategoryIndex]
                                              .name,
                                    ),
                                  ),
                                );
                              }

                              final meals = state.mealsState.data ?? [];

                              // Case 6: Meals Empty
                              if (meals.isEmpty) {
                                return CustomErrorWidget(
                                  errorMessage: localizations.noMealsFound,
                                );
                              }

                              // Case 7: Meals Success (Grid)
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: 1,
                                    ),
                                itemCount: meals.length,
                                itemBuilder: (context, index) {
                                  final meal = meals[index];
                                  return CustomGridItem(
                                    title: meal.name,
                                    imageUrl: meal.image,
                                    onTap: () {
                                      // Navigate to details
                                    },
                                  );
                                },
                              );
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
