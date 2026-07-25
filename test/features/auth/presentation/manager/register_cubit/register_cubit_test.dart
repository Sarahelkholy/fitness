import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/config/base_state/base_state.dart';
import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/config/social_auth/social_user.dart';
import 'package:fitness/config/user/domain/entities/user_entity.dart';
import 'package:fitness/config/user/manager/user_cubit.dart';
import 'package:fitness/features/auth/domain/use_cases/get_facebook_user_data_use_case.dart';
import 'package:fitness/features/auth/domain/use_cases/get_google_user_data_use_case.dart';
import 'package:fitness/features/auth/domain/use_cases/register_use_case.dart';
import 'package:fitness/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'package:fitness/features/auth/presentation/manager/register_cubit/register_event.dart';
import 'package:fitness/features/auth/presentation/manager/register_cubit/register_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_cubit_test.mocks.dart';

@GenerateMocks([
  RegisterUseCase,
  GetGoogleUserDataUseCase,
  GetFacebookUserDataUseCase,
  UserCubit,
])
void main() {
  late RegisterCubit registerCubit;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockGetGoogleUserDataUseCase mockGetGoogleUserDataUseCase;
  late MockGetFacebookUserDataUseCase mockGetFacebookUserDataUseCase;
  late MockUserCubit mockUserCubit;
  late UserEntity userEntity;
  late SocialUser socialUser;

  setUpAll(() {
    userEntity = UserEntity(
      id: "1",
      firstName: "firstName",
      lastName: "lastName",
      email: "email@test.com",
      gender: "male",
      age: 25,
      weight: 75,
      height: 175,
      activityLevel: "level1",
      goal: "Lose Weight",
      photo: "",
      createdAt: DateTime.now(),
    );
    socialUser = SocialUser(
      id: "1",
      email: "email@test.com",
      firstName: "firstName",
      lastName: "lastName",
    );

    provideDummy<Result<UserEntity>>(Success(data: userEntity));
    provideDummy<Result<SocialUser>>(Success(data: socialUser));
  });

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    mockGetGoogleUserDataUseCase = MockGetGoogleUserDataUseCase();
    mockGetFacebookUserDataUseCase = MockGetFacebookUserDataUseCase();
    mockUserCubit = MockUserCubit();

    // Setup GetIt
    final getIt = GetIt.instance;
    if (getIt.isRegistered<UserCubit>()) {
      getIt.unregister<UserCubit>();
    }
    getIt.registerSingleton<UserCubit>(mockUserCubit);

    registerCubit = RegisterCubit(
      mockRegisterUseCase,
      mockGetGoogleUserDataUseCase,
      mockGetFacebookUserDataUseCase,
    );
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  group("RegisterCubit Test Group", () {
    test("initial state should be RegisterState", () {
      expect(registerCubit.state, const RegisterState());
    });

    blocTest<RegisterCubit, RegisterState>(
      "should emit loading then success when registration succeeds",
      setUp: () {
        when(
          mockRegisterUseCase.call(any),
        ).thenAnswer((_) async => Success(data: userEntity));
      },
      build: () => registerCubit,
      act: (cubit) => cubit.doEvents(
        SubmitRegisterEvent(
          firstName: "firstName",
          lastName: "lastName",
          email: "email@test.com",
          password: "password",
        ),
      ),
      expect: () => [
        const RegisterState(registerState: BaseState(isLoading: true)),
        RegisterState(
          registerState: BaseState(isSuccess: true, data: userEntity),
        ),
      ],
      verify: (_) {
        verify(mockRegisterUseCase.call(any)).called(1);
        verify(mockUserCubit.doEvent(any)).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      "should emit loading then failure when registration fails",
      setUp: () {
        when(
          mockRegisterUseCase.call(any),
        ).thenAnswer((_) async => Failure(errorMessage: "Error"));
      },
      build: () => registerCubit,
      act: (cubit) => cubit.doEvents(
        SubmitRegisterEvent(
          firstName: "firstName",
          lastName: "lastName",
          email: "email@test.com",
          password: "password",
        ),
      ),
      expect: () => [
        const RegisterState(registerState: BaseState(isLoading: true)),
        const RegisterState(registerState: BaseState(errorMessage: "Error")),
      ],
      verify: (_) {
        verify(mockRegisterUseCase.call(any)).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      "should emit loading then success when Google registration succeeds",
      setUp: () {
        when(
          mockGetGoogleUserDataUseCase.call(),
        ).thenAnswer((_) async => Success(data: socialUser));
        when(
          mockRegisterUseCase.call(any),
        ).thenAnswer((_) async => Success(data: userEntity));
      },
      build: () => registerCubit,
      act: (cubit) => cubit.doEvents(GoogleRegisterEvent()),
      expect: () => [
        const RegisterState(registerState: BaseState(isLoading: true)),
        RegisterState(
          registerState: BaseState(isSuccess: true, data: userEntity),
        ),
      ],
      verify: (_) {
        verify(mockGetGoogleUserDataUseCase.call()).called(1);
        verify(mockRegisterUseCase.call(any)).called(1);
        verify(mockUserCubit.doEvent(any)).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      "should emit loading then failure when Google sign in fails",
      setUp: () {
        when(
          mockGetGoogleUserDataUseCase.call(),
        ).thenAnswer((_) async => Failure(errorMessage: "Google Error"));
      },
      build: () => registerCubit,
      act: (cubit) => cubit.doEvents(GoogleRegisterEvent()),
      expect: () => [
        const RegisterState(registerState: BaseState(isLoading: true)),
        const RegisterState(
          registerState: BaseState(errorMessage: "Google Error"),
        ),
      ],
      verify: (_) {
        verify(mockGetGoogleUserDataUseCase.call()).called(1);
        verifyNever(mockRegisterUseCase.call(any));
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      "should emit loading then success when Facebook registration succeeds",
      setUp: () {
        when(
          mockGetFacebookUserDataUseCase.call(),
        ).thenAnswer((_) async => Success(data: socialUser));
        when(
          mockRegisterUseCase.call(any),
        ).thenAnswer((_) async => Success(data: userEntity));
      },
      build: () => registerCubit,
      act: (cubit) => cubit.doEvents(FacebookRegisterEvent()),
      expect: () => [
        const RegisterState(registerState: BaseState(isLoading: true)),
        RegisterState(
          registerState: BaseState(isSuccess: true, data: userEntity),
        ),
      ],
      verify: (_) {
        verify(mockGetFacebookUserDataUseCase.call()).called(1);
        verify(mockRegisterUseCase.call(any)).called(1);
        verify(mockUserCubit.doEvent(any)).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      "should emit loading then failure when Facebook sign in fails",
      setUp: () {
        when(
          mockGetFacebookUserDataUseCase.call(),
        ).thenAnswer((_) async => Failure(errorMessage: "Facebook Error"));
      },
      build: () => registerCubit,
      act: (cubit) => cubit.doEvents(FacebookRegisterEvent()),
      expect: () => [
        const RegisterState(registerState: BaseState(isLoading: true)),
        const RegisterState(
          registerState: BaseState(errorMessage: "Facebook Error"),
        ),
      ],
      verify: (_) {
        verify(mockGetFacebookUserDataUseCase.call()).called(1);
        verifyNever(mockRegisterUseCase.call(any));
      },
    );
  });
}
