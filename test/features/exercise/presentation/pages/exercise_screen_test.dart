import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/features/exercise/domain/entities/difficulty_level.dart';
import 'package:fitness/features/exercise/domain/entities/exercise.dart';
import 'package:fitness/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:fitness/features/exercise/presentation/manager/exercise_cubit/exercise_event.dart';
import 'package:fitness/features/exercise/presentation/manager/exercise_cubit/exercise_state.dart';
import 'package:fitness/features/exercise/presentation/pages/exercise_screen.dart';
import 'package:fitness/features/exercise/presentation/widgets/exercise_list_item.dart';
import 'package:fitness/features/exercise/presentation/widgets/selected_exercise_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockExerciseCubit extends MockCubit<ExerciseState> implements ExerciseCubit {}

void main() {
  late MockExerciseCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(const ExerciseState());
    registerFallbackValue(GetDifficultyLevelsEvent(primeMoverMuscleId: '1'));
  });

  setUp(() {
    mockCubit = MockExerciseCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ExerciseCubit>.value(
        value: mockCubit,
        child: const ExerciseScreen(primeMoverMuscleId: '1'),
      ),
    );
  }

  testWidgets('should display loading indicator when state is loading', (WidgetTester tester) async {
    // arrange
    when(() => mockCubit.state).thenReturn(
      const ExerciseState(difficultyLevelsState: BaseState(isLoading: true)),
    );

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display exercises when state is success', (WidgetTester tester) async {
    // arrange
    const tDifficultyLevels = [DifficultyLevel(id: '1', name: 'Beginner')];
    const tExercises = [Exercise(id: '1', exercise: 'Push Up')];
    
    when(() => mockCubit.state).thenReturn(
      ExerciseState(
        difficultyLevelsState: const BaseState(isSuccess: true, data: tDifficultyLevels),
        exercisesState: const BaseState(isSuccess: true, data: tExercises),
        selectedDifficultyLevel: tDifficultyLevels[0],
        selectedExercise: tExercises[0],
      ),
    );

    // act
    await mockNetworkImages(() async {
      await tester.pumpWidget(createWidgetUnderTest());
    });

    // assert
    expect(find.byType(SelectedExerciseHeader), findsOneWidget);
    expect(find.byType(ExerciseListItem), findsOneWidget);
    expect(find.text('Push Up'), findsOneWidget);
  });

  testWidgets('should call SelectExerciseEvent when an exercise is tapped', (WidgetTester tester) async {
    // arrange
    const tDifficultyLevels = [DifficultyLevel(id: '1', name: 'Beginner')];
    const tExercises = [Exercise(id: '1', exercise: 'Push Up')];
    
    when(() => mockCubit.state).thenReturn(
      ExerciseState(
        difficultyLevelsState: const BaseState(isSuccess: true, data: tDifficultyLevels),
        exercisesState: const BaseState(isSuccess: true, data: tExercises),
        selectedDifficultyLevel: tDifficultyLevels[0],
      ),
    );

    // act
    await mockNetworkImages(() async {
      await tester.pumpWidget(createWidgetUnderTest());
    });
    await tester.tap(find.byType(ExerciseListItem));

    // assert
    verify(() => mockCubit.doIntent(any(that: isA<SelectExerciseEvent>()))).called(1);
  });
}
