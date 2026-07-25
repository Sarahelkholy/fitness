import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:fitness/config/social_auth/social_auth_service.dart';
import 'package:fitness/config/social_auth/social_user.dart';
import 'package:fitness/config/user/data/models/responses/get_user_response/user_response.dart';
import 'package:fitness/config/user/domain/entities/user_entity.dart';
import 'package:fitness/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:fitness/features/auth/data/models/requests/register_request.dart';
import 'package:fitness/features/auth/data/models/responses/auth_response.dart';
import 'package:fitness/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, SecureCache, SocialAuthService])
void main() {
  late AuthRepoImpl authRepoImpl;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockSecureCache mockSecureCache;
  late MockSocialAuthService mockSocialAuthService;
  late RegisterRequest registerRequest;
  late AuthResponse authResponse;
  late UserResponse userResponse;
  late SocialUser socialUser;

  setUpAll(() {
    registerRequest = RegisterRequest(
      firstName: "firstName",
      lastName: "lastName",
      email: "email@test.com",
      password: "password",
      rePassword: "password",
      gender: "male",
      height: 175,
      weight: 75,
      age: 25,
      goal: "Lose Weight",
      activityLevel: "level1",
    );
    userResponse = UserResponse(
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
      createdAt: DateTime.now(),
    );
    authResponse = AuthResponse(
      message: "Success",
      token: "token",
      user: userResponse,
    );
    socialUser = SocialUser(
      id: "1",
      email: "email@test.com",
      firstName: "firstName",
      lastName: "lastName",
    );

    provideDummy<Result<AuthResponse>>(Success(data: authResponse));
    provideDummy<Result<SocialUser>>(Success(data: socialUser));
  });

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockSecureCache = MockSecureCache();
    mockSocialAuthService = MockSocialAuthService();
    authRepoImpl = AuthRepoImpl(
      mockAuthRemoteDataSource,
      mockSecureCache,
      mockSocialAuthService,
    );
  });

  group("AuthRepoImpl Test Group", () {
    group("register", () {
      test(
        "should return Success<UserEntity> and save token when registration is successful",
        () async {
          when(
            mockAuthRemoteDataSource.register(any),
          ).thenAnswer((_) async => Success(data: authResponse));
          when(
            mockSecureCache.saveData(
              key: anyNamed('key'),
              value: anyNamed('value'),
            ),
          ).thenAnswer((_) async => {});

          final result = await authRepoImpl.register(registerRequest);

          expect(result, isA<Success<UserEntity>>());
          verify(mockAuthRemoteDataSource.register(registerRequest)).called(1);
          verify(
            mockSecureCache.saveData(key: anyNamed('key'), value: "token"),
          ).called(1);
        },
      );

      test("should return Failure when registration fails", () async {
        when(
          mockAuthRemoteDataSource.register(any),
        ).thenAnswer((_) async => Failure(errorMessage: "Error"));

        final result = await authRepoImpl.register(registerRequest);

        expect(result, isA<Failure<UserEntity>>());
        expect((result as Failure<UserEntity>).errorMessage, "Error");
        verify(mockAuthRemoteDataSource.register(registerRequest)).called(1);
        verifyNever(
          mockSecureCache.saveData(
            key: anyNamed('key'),
            value: anyNamed('value'),
          ),
        );
      });
    });

    group("getGoogleUserData", () {
      test(
        "should return Success<SocialUser> when service returns success",
        () async {
          when(
            mockSocialAuthService.getGoogleUserData(),
          ).thenAnswer((_) async => Success(data: socialUser));

          final result = await authRepoImpl.getGoogleUserData();

          expect(result, isA<Success<SocialUser>>());
          expect((result as Success<SocialUser>).data, socialUser);
          verify(mockSocialAuthService.getGoogleUserData()).called(1);
        },
      );

      test("should return Failure when service returns failure", () async {
        when(
          mockSocialAuthService.getGoogleUserData(),
        ).thenAnswer((_) async => Failure(errorMessage: "Google Error"));

        final result = await authRepoImpl.getGoogleUserData();

        expect(result, isA<Failure<SocialUser>>());
        expect((result as Failure<SocialUser>).errorMessage, "Google Error");
        verify(mockSocialAuthService.getGoogleUserData()).called(1);
      });
    });

    group("getFacebookUserData", () {
      test(
        "should return Success<SocialUser> when service returns success",
        () async {
          when(
            mockSocialAuthService.getFacebookUserData(),
          ).thenAnswer((_) async => Success(data: socialUser));

          final result = await authRepoImpl.getFacebookUserData();

          expect(result, isA<Success<SocialUser>>());
          expect((result as Success<SocialUser>).data, socialUser);
          verify(mockSocialAuthService.getFacebookUserData()).called(1);
        },
      );

      test("should return Failure when service returns failure", () async {
        when(
          mockSocialAuthService.getFacebookUserData(),
        ).thenAnswer((_) async => Failure(errorMessage: "Facebook Error"));

        final result = await authRepoImpl.getFacebookUserData();

        expect(result, isA<Failure<SocialUser>>());
        expect((result as Failure<SocialUser>).errorMessage, "Facebook Error");
        verify(mockSocialAuthService.getFacebookUserData()).called(1);
      });
    });
  });
}
