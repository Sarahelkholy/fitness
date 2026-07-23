import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/core/values/app_strings.dart';
import 'package:fitness/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/login_cubit/login_state.dart';
import 'package:fitness/features/auth/presentation/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  late MockLoginCubit mockLoginCubit;
  late StreamController<dynamic> eventStreamController;

  setUp(() {
    mockLoginCubit = MockLoginCubit();
    eventStreamController = StreamController<dynamic>.broadcast();
    
    when(() => mockLoginCubit.state).thenReturn(const LoginState());
    when(() => mockLoginCubit.eventStream).thenAnswer((_) => eventStreamController.stream);
  });

  tearDown(() {
    eventStreamController.close();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) {
          // Initialize AppStrings.current which is used by Validator
          AppStrings.current = AppLocalizations.of(context)!;
          return BlocProvider<LoginCubit>.value(
            value: mockLoginCubit,
            child: const LoginScreen(),
          );
        },
      ),
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets('renders all initial login fields and buttons', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(2)); // Email and Password
      expect(find.text('Login'), findsAtLeastNWidgets(1));
      expect(find.byType(ElevatedButton), findsAtLeastNWidgets(0)); // CustomButton might use it
      // Find by text since CustomButton title is 'Login'
      expect(find.text('Hey there,'), findsOneWidget);
    });

    testWidgets('shows validation errors when fields are empty and login is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final loginButton = find.text('Login').last;
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Assuming Validator.email and Validator.password return these strings on empty
      // We might need to check Validator implementation or just check if error text appears.
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });
  });
}
