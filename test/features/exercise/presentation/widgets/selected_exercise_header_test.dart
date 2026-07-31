import 'package:fitness/features/exercise/domain/entities/exercise.dart';
import 'package:fitness/features/exercise/presentation/widgets/selected_exercise_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  const tExercise = Exercise(
    exercise: 'Push Up',
    shortYoutubeDemonstrationLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  );

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: Scaffold(
        body: SelectedExerciseHeader(exercise: tExercise),
      ),
    );
  }

  testWidgets('should display exercise name', (WidgetTester tester) async {
    // act
    await mockNetworkImages(() async {
      await tester.pumpWidget(createWidgetUnderTest());
    });

    // assert
    expect(find.text('Push Up'), findsOneWidget);
  });
}
