import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_error_widget.dart';
import 'package:fitness/core/shared_widgets/custom_loading_indicator.dart';
import 'package:fitness/core/values/keys_strings.dart';
import 'package:fitness/features/meals/domain/entities/meal_details_entity.dart';
import 'package:fitness/features/meals/presentation/manager/meal_details_cubit/meal_details_cubit.dart';
import 'package:fitness/features/meals/presentation/manager/meal_details_cubit/meal_details_state.dart';
import 'package:fitness/features/meals/presentation/pages/meal_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meal_details_screen_test.mocks.dart';

@GenerateMocks([MealDetailsCubit])
void main() {
  late MockMealDetailsCubit mockCubit;

  setUp(() {
    mockCubit = MockMealDetailsCubit();
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
      home: BlocProvider<MealDetailsCubit>.value(
        value: mockCubit,
        child: const MealDetailsScreen(mealId: '1'),
      ),
    );
  }

  const mealDetails = MealDetailsEntity(
    id: '1',
    name: 'Test Meal',
    mealAlternate: '',
    category: 'Test Category',
    area: 'Test Area',
    country: 'Test Country',
    instructions: 'Test Instructions',
    image: 'test_image',
    tags: '',
    youtubeUrl: 'https://www.youtube.com/watch?v=test',
    sourceUrl: '',
    imageSource: '',
    creativeCommonsConfirmed: '',
    dateModified: '',
    ingredients: [IngredientEntity(name: 'Ingredient 1', measure: 'Measure 1')],
  );

  testWidgets('renders CustomLoadingIndicator when meal details are loading', (
    tester,
  ) async {
    when(mockCubit.state).thenReturn(
      const MealDetailsState(mealDetailsState: BaseState(isLoading: true)),
    );
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CustomLoadingIndicator), findsOneWidget);
  });

  testWidgets('renders CustomErrorWidget when meal details loading fails', (
    tester,
  ) async {
    when(mockCubit.state).thenReturn(
      const MealDetailsState(
        mealDetailsState: BaseState(errorMessage: 'Error Message'),
      ),
    );
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CustomErrorWidget), findsOneWidget);
    expect(find.text('Error Message'), findsOneWidget);
  });

  testWidgets('renders meal details when data is loaded successfully', (
    tester,
  ) async {
    when(mockCubit.state).thenReturn(
      const MealDetailsState(
        mealDetailsState: BaseState(data: mealDetails, isSuccess: true),
      ),
    );
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byKey(const Key(KeysStrings.mealDetailsName)), findsOneWidget);
    expect(find.text('Test Meal'), findsOneWidget);
    expect(
      find.byKey(const Key(KeysStrings.mealDetailsInstructions)),
      findsOneWidget,
    );
    expect(find.text('Test Instructions'), findsOneWidget);
    expect(find.text('Ingredient 1'), findsOneWidget);
    expect(find.text('Measure 1'), findsOneWidget);
  });
}
