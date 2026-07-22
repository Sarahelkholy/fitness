import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/core/localization/l10n/app_localizations_en.dart';
import 'package:fitness/core/values/app_strings.dart';
import 'package:fitness/features/auth/api/auth_api_client/auth_api_client.dart';
import 'package:fitness/features/auth/api/data_sources/remote/auth_remote_data_source_impl.dart';
import 'package:fitness/features/auth/data/models/requests/register_request.dart';
import 'package:fitness/features/auth/data/models/responses/auth_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockAuthApiClient mockAuthApiClient;
  late RegisterRequest registerRequest;
  late AuthResponse authResponse;

  setUpAll(() {
    AppStrings.current = AppLocalizationsEn();
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
    authResponse = AuthResponse(message: "Success", token: "token");
  });

  setUp(() {
    mockAuthApiClient = MockAuthApiClient();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockAuthApiClient);
  });

  group("AuthRemoteDataSourceImpl Test Group", () {
    group("register", () {
      test("should return Success when api call is successful", () async {
        when(
          mockAuthApiClient.register(any),
        ).thenAnswer((_) async => authResponse);

        final result = await authRemoteDataSourceImpl.register(registerRequest);

        expect(result, isA<Success<AuthResponse>>());
        expect((result as Success<AuthResponse>).data, authResponse);
        verify(mockAuthApiClient.register(registerRequest)).called(1);
      });

      test("should return Failure when api call throws exception", () async {
        when(mockAuthApiClient.register(any)).thenThrow(Exception());

        final result = await authRemoteDataSourceImpl.register(registerRequest);

        expect(result, isA<Failure<AuthResponse>>());
        verify(mockAuthApiClient.register(registerRequest)).called(1);
      });
    });
  });
}
