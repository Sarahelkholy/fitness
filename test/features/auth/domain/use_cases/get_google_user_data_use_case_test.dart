import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/config/social_auth/social_user.dart';
import 'package:fitness/features/auth/domain/repositories/auth_repo.dart';
import 'package:fitness/features/auth/domain/use_cases/get_google_user_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_google_user_data_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late GetGoogleUserDataUseCase getGoogleUserDataUseCase;
  late MockAuthRepo mockAuthRepo;
  late SocialUser socialUser;

  setUpAll(() {
    socialUser = SocialUser(
      id: "1",
      email: "email@test.com",
      firstName: "firstName",
      lastName: "lastName",
    );
    provideDummy<Result<SocialUser>>(Success(data: socialUser));
  });

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    getGoogleUserDataUseCase = GetGoogleUserDataUseCase(mockAuthRepo);
  });

  group("GetGoogleUserDataUseCase Test Group", () {
    test("should call getGoogleUserData on repository", () async {
      when(
        mockAuthRepo.getGoogleUserData(),
      ).thenAnswer((_) async => Success(data: socialUser));

      final result = await getGoogleUserDataUseCase();

      expect(result, isA<Success<SocialUser>>());
      expect((result as Success<SocialUser>).data, socialUser);
      verify(mockAuthRepo.getGoogleUserData()).called(1);
    });
  });
}
