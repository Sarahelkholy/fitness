import 'dart:async';

import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/values/app_strings.dart';
import 'package:fitness/core/values/keys_strings.dart';
import 'package:fitness/features/auth/domain/entities/register_form_data.dart';
import 'package:fitness/features/auth/presentation/manager/register_form_cubit/register_form_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/register_form_cubit/register_form_event.dart';
import 'package:fitness/features/auth/presentation/manager/register_form_cubit/register_form_state.dart';
import 'package:fitness/features/auth/presentation/pages/register_form/register_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_form_screen_test.mocks.dart';

@GenerateMocks([RegisterFormCubit])
void main() {
  late MockRegisterFormCubit mockCubit;
  late StreamController<BaseEvent> eventController;
  late StreamController<RegisterFormState> stateController;

  setUp(() {
    mockCubit = MockRegisterFormCubit();
    eventController = StreamController<BaseEvent>();
    stateController = StreamController<RegisterFormState>.broadcast();

    when(mockCubit.state).thenReturn(const RegisterFormState());
    when(mockCubit.stream).thenAnswer((_) => stateController.stream);
    when(mockCubit.eventStream).thenAnswer((_) => eventController.stream);
  });

  tearDown(() async {
    await eventController.close();
    await stateController.close();
  });

  void emitState(RegisterFormState state) {
    when(mockCubit.state).thenReturn(state);
    stateController.add(state);
  }

  Future<void> pumpScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      BlocProvider<RegisterFormCubit>.value(
        value: mockCubit,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          builder: (context, child) {
            AppStrings.current = AppLocalizations.of(context)!;
            return child!;
          },
          home: const RegisterFormScreen(),
        ),
      ),
    );
  }

  group('RegisterFormScreen Widget Tests', () {
    testWidgets('should render initial gender selection step', (tester) async {
      await pumpScreen(tester);

      expect(find.text(AppStrings.current.tellUsAboutYourself), findsOneWidget);
      expect(
        find.byKey(const Key(KeysStrings.registerFormMaleButton)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(KeysStrings.registerFormFemaleButton)),
        findsOneWidget,
      );
    });

    testWidgets(
      'next button should be disabled initially (no gender selected)',
      (tester) async {
        await pumpScreen(tester);

        final nextButton = tester.widget<ElevatedButton>(
          find.descendant(
            of: find.byKey(const Key(KeysStrings.registerFormNextButtonStep1)),
            matching: find.byType(ElevatedButton),
          ),
        );
        expect(nextButton.enabled, isFalse);
      },
    );

    testWidgets('next button should be enabled when gender is selected', (
      tester,
    ) async {
      await pumpScreen(tester);

      emitState(
        const RegisterFormState(
          formData: RegisterFormData(gender: UserGender.male),
        ),
      );
      await tester.pump();

      final nextButton = tester.widget<ElevatedButton>(
        find.descendant(
          of: find.byKey(const Key(KeysStrings.registerFormNextButtonStep1)),
          matching: find.byType(ElevatedButton),
        ),
      );
      expect(nextButton.enabled, isTrue);
    });

    testWidgets('should call cubit events on gender selection', (tester) async {
      await pumpScreen(tester);

      await tester.tap(
        find.byKey(const Key(KeysStrings.registerFormMaleButton)),
      );
      verify(mockCubit.doEvents(any)).called(1);
    });

    testWidgets(
      'should navigate through all 6 steps and trigger final submission',
      (tester) async {
        // Gender
        await pumpScreen(tester);
        emitState(
          const RegisterFormState(
            formData: RegisterFormData(gender: UserGender.male),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(
          find.byKey(const Key(KeysStrings.registerFormNextButtonStep1)),
        );
        await tester.pumpAndSettle();

        // Age
        emitState(
          const RegisterFormState(
            formData: RegisterFormData(gender: UserGender.male, age: 25),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(const Key(KeysStrings.registerFormNextButtonStep2)),
        );
        await tester.pumpAndSettle();

        // Weight
        emitState(
          const RegisterFormState(
            formData: RegisterFormData(
              gender: UserGender.male,
              age: 25,
              weight: 70,
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(const Key(KeysStrings.registerFormNextButtonStep3)),
        );
        await tester.pumpAndSettle();

        // Height
        emitState(
          const RegisterFormState(
            formData: RegisterFormData(
              gender: UserGender.male,
              age: 25,
              weight: 70,
              height: 170,
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(const Key(KeysStrings.registerFormNextButtonStep4)),
        );
        await tester.pumpAndSettle();

        // Goal
        emitState(
          const RegisterFormState(
            formData: RegisterFormData(
              gender: UserGender.male,
              age: 25,
              weight: 70,
              height: 170,
              goal: UserGoal.loseWeight,
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(const Key(KeysStrings.registerFormNextButtonStep5)),
        );
        await tester.pumpAndSettle();

        // Activity Level
        emitState(
          const RegisterFormState(
            formData: RegisterFormData(
              gender: UserGender.male,
              age: 25,
              weight: 70,
              height: 170,
              goal: UserGoal.loseWeight,
              activityLevel: ActivityLevel.level1,
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(const Key(KeysStrings.registerFormNextButtonStep6)),
        );
        await tester.pumpAndSettle();

        verify(
          mockCubit.doEvents(argThat(isA<SubmitRegisterFormEvent>())),
        ).called(1);
      },
    );

    testWidgets('should show error snackbar on DisplayErrorEvent', (
      tester,
    ) async {
      await pumpScreen(tester);

      eventController.add(const DisplayErrorEvent(errorMsg: 'Update Failed'));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Update Failed'), findsOneWidget);
    });

    testWidgets('should navigate back when back button is pressed', (
      tester,
    ) async {
      await pumpScreen(tester);
      emitState(
        const RegisterFormState(
          formData: RegisterFormData(gender: UserGender.male, age: 25),
        ),
      );
      await tester.pump();

      await tester.tap(
        find.byKey(const Key(KeysStrings.registerFormNextButtonStep1)),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
      await tester.pumpAndSettle();

      // Should be back at Gender step
      expect(find.text(AppStrings.current.tellUsAboutYourself), findsOneWidget);
    });
  });
}
