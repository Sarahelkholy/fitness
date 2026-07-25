import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_error_widget.dart';
import 'package:fitness/core/shared_widgets/custom_loading_indicator.dart';
import 'package:fitness/core/shared_widgets/custom_tab_bar.dart';
import 'package:fitness/core/values/keys_strings.dart';
import 'package:fitness/features/meals/domain/entities/category_entity.dart';
import 'package:fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_cubit.dart';
import 'package:fitness/features/meals/presentation/manager/meal_recommendation_cubit/meal_recommendation_state.dart';
import 'package:fitness/features/meals/presentation/pages/meal_recommendation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meal_recommendation_screen_test.mocks.dart';

@GenerateMocks([MealRecommendationCubit])
void main() {
  late MockMealRecommendationCubit mockCubit;

  setUp(() {
    mockCubit = MockMealRecommendationCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: BlocProvider<MealRecommendationCubit>.value(
        value: mockCubit,
        child: const MealRecommendationScreen(),
      ),
    );
  }

  const category = CategoryEntity(
    id: '1',
    name: 'Beef',
    image: 'image',
    description: 'description',
  );

  const meal = MealEntity(
    id: '52874',
    name: 'Beef and Mustard Pie',
    image: 'image',
    area: 'British',
    country: 'UK',
  );

  testWidgets('renders CustomLoadingIndicator when categories are loading', (
    tester,
  ) async {
    when(mockCubit.state).thenReturn(
      const MealRecommendationState(
        categoriesState: BaseState(isLoading: true),
      ),
    );
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CustomLoadingIndicator), findsOneWidget);
  });

  testWidgets('renders CustomErrorWidget when categories loading fails', (
    tester,
  ) async {
    when(mockCubit.state).thenReturn(
      const MealRecommendationState(
        categoriesState: BaseState(errorMessage: 'Error Message'),
      ),
    );
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CustomErrorWidget), findsOneWidget);
    expect(find.text('Error Message'), findsOneWidget);
  });

  testWidgets('renders categories and meals when data is loaded successfully', (
    tester,
  ) async {
    when(mockCubit.state).thenReturn(
      const MealRecommendationState(
        categoriesState: BaseState(data: [category], isSuccess: true),
        mealsState: BaseState(data: [meal], isSuccess: true),
        selectedCategoryIndex: 0,
      ),
    );
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CustomTabBar), findsOneWidget);
    expect(find.text('Beef'), findsOneWidget);
    expect(
      find.byKey(const Key(KeysStrings.mealRecommendationGridView)),
      findsOneWidget,
    );
    expect(find.text('Beef and Mustard Pie'), findsOneWidget);
  });
}
