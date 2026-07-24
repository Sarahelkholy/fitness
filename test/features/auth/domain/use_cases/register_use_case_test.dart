import 'package:fitness/config/error_handling/result.dart';
import 'package:fitness/config/user/domain/entities/user_entity.dart';
import 'package:fitness/features/auth/data/models/requests/register_request.dart';
import 'package:fitness/features/auth/domain/repositories/auth_repo.dart';
import 'package:fitness/features/auth/domain/use_cases/register_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late RegisterUseCase registerUseCase;
  late MockAuthRepo mockAuthRepo;
  late RegisterRequest registerRequest;
  late UserEntity userEntity;

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

    provideDummy<Result<UserEntity>>(Success(data: userEntity));
  });

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    registerUseCase = RegisterUseCase(mockAuthRepo);
  });

  group("RegisterUseCase Test Group", () {
    test("should call register on repository", () async {
      when(
        mockAuthRepo.register(any),
      ).thenAnswer((_) async => Success(data: userEntity));

      final result = await registerUseCase(registerRequest);

      expect(result, isA<Success<UserEntity>>());
      expect((result as Success<UserEntity>).data, userEntity);
      verify(mockAuthRepo.register(registerRequest)).called(1);
    });
  });
}
