import 'package:fitness/config/di/di.dart';
import 'package:fitness/config/route_manager/routes.dart';
import 'package:fitness/config/user/domain/entities/user_entity.dart';
import 'package:fitness/config/user/manager/user_cubit.dart';
import 'package:fitness/config/user/manager/user_events.dart';
import 'package:fitness/config/user/manager/user_state.dart';
import 'package:fitness/core/local_cubit/locale_cubit.dart';
import 'package:fitness/core/localization/l10n/app_localizations.dart';
import 'package:fitness/features/auth/presentation/manager/logout_cubit/logout_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/logout_cubit/logout_events.dart';
import 'package:fitness/features/profile/presentation/pages/profile_screen.dart';
import 'package:fitness/features/profile/presentation/widgets/profile/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'profile_screen_test.mocks.dart';

UserEntity _testUser() => UserEntity(
  id: '1',
  firstName: 'John',
  lastName: 'Doe',
  email: 'john@example.com',
  gender: 'male',
  age: 25,
  weight: 80,
  height: 180,
  activityLevel: 'intermediate',
  goal: 'lose_weight',
  photo: 'https://example.com/avatar.png',
  createdAt: DateTime(2025, 1, 1),
);

@GenerateMocks([LocaleCubit, UserCubit, LogoutCubit])
void main() {
  late MockLocaleCubit mockLocaleCubit;
  late MockUserCubit mockUserCubit;
  late MockLogoutCubit mockLogoutCubit;

  setUpAll(() {
    provideDummy<LogoutState>(LogoutInitial());
  });

  setUp(() {
    mockLocaleCubit = MockLocaleCubit();
    mockUserCubit = MockUserCubit();
    mockLogoutCubit = MockLogoutCubit();

    when(mockLocaleCubit.state).thenReturn(const Locale('en'));
    when(mockLocaleCubit.stream).thenAnswer((_) => const Stream.empty());

    when(
      mockUserCubit.state,
    ).thenReturn(UserState(isLoading: false, user: _testUser()));
    when(mockUserCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockLogoutCubit.state).thenReturn(LogoutInitial());
    when(mockLogoutCubit.stream).thenAnswer((_) => const Stream.empty());

    if (getIt.isRegistered<LogoutCubit>()) {
      getIt.unregister<LogoutCubit>();
    }
    getIt.registerFactory<LogoutCubit>(() => mockLogoutCubit);
  });

  tearDown(() {
    if (getIt.isRegistered<LogoutCubit>()) {
      getIt.unregister<LogoutCubit>();
    }
  });

  Future<void> pumpProfileScreen(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
    Route<dynamic>? Function(RouteSettings)? onGenerateRoute,
  }) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<LocaleCubit>.value(value: mockLocaleCubit),
          BlocProvider<UserCubit>.value(value: mockUserCubit),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale,
          home: const ProfileScreen(),
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );

    await tester.pump();
    await tester.pump();
  }

  group('ProfileScreen Widget Tests', () {
    testWidgets('renders profile title correctly', (tester) async {
      await mockNetworkImages(() async {
        await pumpProfileScreen(tester);
        expect(find.text('Profile'), findsOneWidget);
      });
    });

    testWidgets('renders user info and name from UserCubit state', (
      tester,
    ) async {
      await mockNetworkImages(() async {
        await pumpProfileScreen(tester);
        expect(find.text('John Doe'), findsOneWidget);
      });
    });

    testWidgets('shows loading indicator when user data is loading', (
      tester,
    ) async {
      when(mockUserCubit.state).thenReturn(UserState(isLoading: true));

      await mockNetworkImages(() async {
        await pumpProfileScreen(tester);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    testWidgets('triggers GetUserDataEvent on init', (tester) async {
      await mockNetworkImages(() async {
        await pumpProfileScreen(tester);
        verify(
          mockUserCubit.doEvent(argThat(isA<GetUserDataEvent>())),
        ).called(1);
      });
    });

    testWidgets('renders all profile option titles', (tester) async {
      await mockNetworkImages(() async {
        await pumpProfileScreen(tester);

        expect(find.text('Edit Profile'), findsOneWidget);
        expect(find.text('Change Password'), findsOneWidget);
        expect(find.text('Security'), findsOneWidget);
        expect(find.text('Privacy Policy'), findsOneWidget);
        expect(find.text('Help'), findsOneWidget);
        expect(find.text('Logout'), findsOneWidget);
      });
    });

    testWidgets('renders all expected menu icons', (tester) async {
      await mockNetworkImages(() async {
        await pumpProfileScreen(tester);

        expect(find.byIcon(Icons.person_outline), findsOneWidget);
        expect(find.byIcon(Icons.refresh), findsOneWidget);
        expect(find.byIcon(Icons.language), findsOneWidget);
        expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
        expect(find.byIcon(Icons.shield_outlined), findsOneWidget);
        expect(find.byIcon(Icons.support_agent_outlined), findsOneWidget);
        expect(find.byIcon(Icons.logout), findsOneWidget);
      });
    });

    testWidgets('renders language switch in English mode', (tester) async {
      await mockNetworkImages(() async {
        await pumpProfileScreen(tester);

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is RichText &&
                widget.text.toPlainText().contains('English'),
          ),
          findsOneWidget,
        );
        expect(find.byType(Switch), findsOneWidget);

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.value, isTrue);
      });
    });

    testWidgets('renders language switch showing Arabic in Arabic mode', (
      tester,
    ) async {
      when(mockLocaleCubit.state).thenReturn(const Locale('ar'));

      await mockNetworkImages(() async {
        await pumpProfileScreen(tester, locale: const Locale('ar'));

        expect(find.byType(Switch), findsOneWidget);
        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.value, isFalse);
      });
    });

    testWidgets('tapping language switch calls toggleLanguage on LocaleCubit', (
      tester,
    ) async {
      await mockNetworkImages(() async {
        await pumpProfileScreen(tester);

        await tester.tap(find.byType(Switch));
        await tester.pump();

        verify(mockLocaleCubit.toggleLanguage()).called(1);
      });
    });

    testWidgets('tapping Edit Profile navigates to editProfileRoute', (
      tester,
    ) async {
      String? pushedRoute;

      await mockNetworkImages(() async {
        await pumpProfileScreen(
          tester,
          onGenerateRoute: (settings) {
            pushedRoute = settings.name;
            return MaterialPageRoute(builder: (_) => const SizedBox());
          },
        );

        await tester.tap(find.text('Edit Profile'));
        await tester.pump();

        expect(pushedRoute, Routes.editProfileRoute);
      });
    });

    testWidgets('tapping Change Password navigates to changPasswordRoute', (
      tester,
    ) async {
      String? pushedRoute;

      await mockNetworkImages(() async {
        await pumpProfileScreen(
          tester,
          onGenerateRoute: (settings) {
            pushedRoute = settings.name;
            return MaterialPageRoute(builder: (_) => const SizedBox());
          },
        );

        await tester.tap(find.text('Change Password'));
        await tester.pump();

        expect(pushedRoute, Routes.changPasswordRoute);
      });
    });

    testWidgets('tapping Security navigates to profileSecurityRoute', (
      tester,
    ) async {
      String? pushedRoute;

      await mockNetworkImages(() async {
        await pumpProfileScreen(
          tester,
          onGenerateRoute: (settings) {
            pushedRoute = settings.name;
            return MaterialPageRoute(builder: (_) => const SizedBox());
          },
        );

        await tester.tap(find.text('Security'));
        await tester.pump();

        expect(pushedRoute, Routes.profileSecurityRoute);
      });
    });

    testWidgets('tapping Privacy Policy navigates to profilePrivacyRoute', (
      tester,
    ) async {
      String? pushedRoute;

      await mockNetworkImages(() async {
        await pumpProfileScreen(
          tester,
          onGenerateRoute: (settings) {
            pushedRoute = settings.name;
            return MaterialPageRoute(builder: (_) => const SizedBox());
          },
        );

        await tester.tap(find.text('Privacy Policy'));
        await tester.pump();

        expect(pushedRoute, Routes.profilePrivacyRoute);
      });
    });

    testWidgets('tapping Help navigates to profileHelpRoute', (tester) async {
      String? pushedRoute;

      await mockNetworkImages(() async {
        await pumpProfileScreen(
          tester,
          onGenerateRoute: (settings) {
            pushedRoute = settings.name;
            return MaterialPageRoute(builder: (_) => const SizedBox());
          },
        );

        await tester.tap(find.text('Help'));
        await tester.pump();

        expect(pushedRoute, Routes.profileHelpRoute);
      });
    });

    testWidgets('tapping Logout opens LogoutDialog and shows options', (
      tester,
    ) async {
      await mockNetworkImages(() async {
        await pumpProfileScreen(tester);

        await tester.tap(find.text('Logout'));
        await tester.pumpAndSettle();

        expect(find.byType(LogoutDialog), findsOneWidget);
        expect(
          find.text('Are you sure to close the application?'),
          findsOneWidget,
        );
        expect(find.text('No'), findsOneWidget);
        expect(find.text('Yes'), findsOneWidget);
      });
    });

    testWidgets('tapping Yes in LogoutDialog dispatches LogoutEvent', (
      tester,
    ) async {
      await mockNetworkImages(() async {
        await pumpProfileScreen(tester);

        await tester.tap(find.text('Logout'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Yes'));
        await tester.pump();

        verify(mockLogoutCubit.doEvents(argThat(isA<LogoutEvent>()))).called(1);
      });
    });

    testWidgets('tapping No in LogoutDialog dismisses dialog', (tester) async {
      await mockNetworkImages(() async {
        await pumpProfileScreen(tester);

        await tester.tap(find.text('Logout'));
        await tester.pumpAndSettle();

        expect(find.byType(LogoutDialog), findsOneWidget);

        await tester.tap(find.text('No'));
        await tester.pumpAndSettle();

        expect(find.byType(LogoutDialog), findsNothing);
      });
    });
  });
}
