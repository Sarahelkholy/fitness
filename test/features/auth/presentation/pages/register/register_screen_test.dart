import 'dart:async';

import 'package:fitness/config/base_cubit/base_event.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/values/app_strings.dart';
import 'package:fitness/core/values/keys_strings.dart';
import 'package:fitness/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/register_cubit/register_event.dart';
import 'package:fitness/features/auth/presentation/manager/register_cubit/register_state.dart';
import 'package:fitness/features/auth/presentation/pages/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_screen_test.mocks.dart';

@GenerateMocks([RegisterCubit])
void main() {
  late MockRegisterCubit mockCubit;
  late StreamController<BaseEvent> eventController;

  setUp(() {
    mockCubit = MockRegisterCubit();
    eventController = StreamController<BaseEvent>();

    when(mockCubit.state).thenReturn(const RegisterState());
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.eventStream).thenAnswer((_) => eventController.stream);
  });

  tearDown(() async {
    await eventController.close();
  });

  Future<void> pumpScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      BlocProvider<RegisterCubit>.value(
        value: mockCubit,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          builder: (context, child) {
            AppStrings.current = AppLocalizations.of(context)!;
            return child!;
          },
          home: const RegisterScreen(),
        ),
      ),
    );
  }

  group('RegisterScreen Widget Tests', () {
    testWidgets('should render initial widgets', (tester) async {
      await pumpScreen(tester);

      expect(
        find.byKey(const Key(KeysStrings.registerFirstNameField)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(KeysStrings.registerLastNameField)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(KeysStrings.registerEmailField)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(KeysStrings.registerPasswordField)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(KeysStrings.registerNextButton)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(KeysStrings.registerGoogleButton)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(KeysStrings.registerFacebookButton)),
        findsOneWidget,
      );
    });

    testWidgets(
      'should show validation errors when fields are empty and next is pressed',
      (tester) async {
        await pumpScreen(tester);

        await tester.tap(find.byKey(const Key(KeysStrings.registerNextButton)));
        await tester.pump();

        expect(
          find.text(AppStrings.current.emptyField),
          findsAtLeastNWidgets(2),
        ); // first and last name
        expect(find.text(AppStrings.current.emailRequired), findsOneWidget);
        expect(find.text(AppStrings.current.passwordRequired), findsOneWidget);
      },
    );

    testWidgets(
      'should show loading indicator on button when state is loading',
      (tester) async {
        when(mockCubit.state).thenReturn(
          const RegisterState(registerState: BaseState(isLoading: true)),
        );

        await pumpScreen(tester);

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets('should disable fields when loading', (tester) async {
      when(mockCubit.state).thenReturn(
        const RegisterState(registerState: BaseState(isLoading: true)),
      );

      await pumpScreen(tester);

      final firstNameField = tester.widget<TextFormField>(
        find.byKey(const Key(KeysStrings.registerFirstNameField)),
      );
      expect(firstNameField.enabled, isFalse);
    });

    testWidgets('should call cubit events on social button taps', (
      tester,
    ) async {
      await pumpScreen(tester);

      await tester.tap(find.byKey(const Key(KeysStrings.registerGoogleButton)));
      await tester.pump();
      verify(mockCubit.doEvents(argThat(isA<GoogleRegisterEvent>()))).called(1);

      await tester.tap(
        find.byKey(const Key(KeysStrings.registerFacebookButton)),
      );
      await tester.pump();
      verify(
        mockCubit.doEvents(argThat(isA<FacebookRegisterEvent>())),
      ).called(1);
    });

    testWidgets(
      'should call cubit SubmitRegisterEvent when all fields are valid and next is pressed',
      (tester) async {
        await pumpScreen(tester);

        await tester.enterText(
          find.byKey(const Key(KeysStrings.registerFirstNameField)),
          'John',
        );
        await tester.enterText(
          find.byKey(const Key(KeysStrings.registerLastNameField)),
          'Doe',
        );
        await tester.enterText(
          find.byKey(const Key(KeysStrings.registerEmailField)),
          'john@doe.com',
        );
        await tester.enterText(
          find.byKey(const Key(KeysStrings.registerPasswordField)),
          'Password@123',
        );

        await tester.tap(find.byKey(const Key(KeysStrings.registerNextButton)));
        await tester.pump();

        verify(
          mockCubit.doEvents(argThat(isA<SubmitRegisterEvent>())),
        ).called(1);
      },
    );

    testWidgets('should toggle password visibility', (tester) async {
      await pumpScreen(tester);

      Finder findPasswordField() => find.descendant(
        of: find.byKey(const Key(KeysStrings.registerPasswordField)),
        matching: find.byType(TextField),
      );

      expect(tester.widget<TextField>(findPasswordField()).obscureText, isTrue);

      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pump();

      expect(
        tester.widget<TextField>(findPasswordField()).obscureText,
        isFalse,
      );
    });

    testWidgets(
      'should show error snackbar when DisplayErrorEvent is emitted',
      (tester) async {
        await pumpScreen(tester);

        eventController.add(
          const DisplayErrorEvent(errorMsg: 'Registration Failed'),
        );
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Registration Failed'), findsOneWidget);
      },
    );
  });
}
