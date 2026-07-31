import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/shared_widgets/custom_bottom_nav.dart';
import 'package:fitness/core/shared_widgets/svg_wrapper.dart';
import 'package:fitness/core/utils/app_assets.dart';
import 'package:fitness/features/chat_screen.dart';
import 'package:fitness/features/exercise/presentation/pages/home_screen.dart';
import 'package:fitness/features/exercise/presentation/pages/workout_screen.dart';
import 'package:fitness/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('ar')],
      home: CustomBottomNavBar(),
    );
  }

  testWidgets('test navbar structure and initial state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(ChatScreen), findsNothing);
    expect(find.byType(WorkoutScreen), findsNothing);
    expect(find.byType(ProfileScreen), findsNothing);

    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Smart coach'), findsNothing);
    expect(find.text('Workouts'), findsNothing);
    expect(find.text('Profile'), findsNothing);
  });

  testWidgets('test navigation to ChatScreen (Smart coach)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final chatIconFinder = find.byWidgetPredicate(
      (widget) => widget is SvgWrapper && widget.path == AppAssets.chatIcon,
    );
    await tester.tap(chatIconFinder);
    await tester.pump();

    expect(find.byType(ChatScreen), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);

    expect(find.text('Smart coach'), findsOneWidget);
    expect(find.text('Explore'), findsNothing);
  });

  testWidgets('test navigation to WorkoutScreen (Workouts)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final workoutIconFinder = find.byWidgetPredicate(
      (widget) => widget is SvgWrapper && widget.path == AppAssets.workoutIcon,
    );
    await tester.tap(workoutIconFinder);
    await tester.pump();

    expect(find.byType(WorkoutScreen), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);

    expect(find.text('Workouts'), findsOneWidget);
    expect(find.text('Explore'), findsNothing);
  });

  testWidgets('test navigation to ProfileScreen (Profile)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final profileIconFinder = find.byWidgetPredicate(
      (widget) => widget is SvgWrapper && widget.path == AppAssets.personIcon,
    );
    await tester.tap(profileIconFinder);
    await tester.pump();

    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Explore'), findsNothing);
  });
}
