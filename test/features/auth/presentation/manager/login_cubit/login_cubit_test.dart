import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/config/user/domain/entities/user_entity.dart';
import 'package:fitness/features/auth/data/models/requests/login_request.dart';
import 'package:fitness/features/auth/domain/use_cases/get_facebook_user_data_use_case.dart';
import 'package:fitness/features/auth/domain/use_cases/get_google_user_data_use_case.dart';
import 'package:fitness/features/auth/domain/use_cases/login_use_case.dart';
import 'package:fitness/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/login_cubit/login_event.dart';
import 'package:fitness/features/auth/presentation/manager/login_cubit/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockGetGoogleUserDataUseCase extends Mock implements GetGoogleUserDataUseCase {}
class MockGetFacebookUserDataUseCase extends Mock implements GetFacebookUserDataUseCase {}

void main() {
  late LoginCubit loginCubit;
  late MockLoginUseCase mockLoginUseCase;
  late MockGetGoogleUserDataUseCase mockGetGoogleUserDataUseCase;
  late MockGetFacebookUserDataUseCase mockGetFacebookUserDataUseCase;

  setUpAll(() {
    registerFallbackValue(LoginRequest(email: '', password: ''));
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockGetGoogleUserDataUseCase = MockGetGoogleUserDataUseCase();
    mockGetFacebookUserDataUseCase = MockGetFacebookUserDataUseCase();
    loginCubit = LoginCubit(
      mockGetGoogleUserDataUseCase,
      mockLoginUseCase,
      mockGetFacebookUserDataUseCase,
    );
  });

  tearDown(() {
    loginCubit.close();
  });

  final tLoginRequest = LoginRequest(email: 'test@example.com', password: 'password123');
  final tUserEntity = UserEntity(
    firstName: 'John',
    lastName: 'Doe',
    email: 'test@example.com',
    gender: 'male',
    age: 25,
    weight: 70,
    height: 175,
    activityLevel: 'active',
    goal: 'gain muscle',
    photo: 'photo_url',
    id: '123',
    createdAt: DateTime.now(),
  );

  group('LoginCubit', () {
    test('initial state should be LoginState', () {
      expect(loginCubit.state.loginWithApi?.isLoading, false);
      expect(loginCubit.state.loginWithGoogle?.isLoading, false);
      expect(loginCubit.state.loginWithFacebook?.isLoading, false);
    });

    blocTest<LoginCubit, LoginState>(
      'emits [isLoading: true] and then [isSuccess: true] when login is successful',
      build: () {
        when(() => mockLoginUseCase(any())).thenAnswer((_) async => Success(data: tUserEntity));
        return loginCubit;
      },
      act: (cubit) => cubit.doIntent(LoginWithApi(tLoginRequest)),
      expect: () => [
        isA<LoginState>().having((s) => s.loginWithApi?.isLoading, 'isLoading', true),
        isA<LoginState>()
            .having((s) => s.loginWithApi?.isSuccess, 'isSuccess', true)
            .having((s) => s.loginWithApi?.data, 'data', tUserEntity),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [isLoading: true] and then [errorMessage] when login fails',
      build: () {
        when(() => mockLoginUseCase(any())).thenAnswer((_) async => Failure(errorMessage: 'Invalid credentials'));
        return loginCubit;
      },
      act: (cubit) => cubit.doIntent(LoginWithApi(tLoginRequest)),
      expect: () => [
        isA<LoginState>().having((s) => s.loginWithApi?.isLoading, 'isLoading', true),
        isA<LoginState>().having((s) => s.loginWithApi?.errorMessage, 'errorMessage', 'Invalid credentials'),
      ],
    );
  });
}
