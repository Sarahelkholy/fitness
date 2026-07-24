import 'package:fitness/features/auth/api/auth_api_client/auth_api_client.dart';
import 'package:fitness/features/auth/api/data_sources/remote/auth_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockAuthApiClient mockAuthApiClient;

  setUp(() {
    mockAuthApiClient = MockAuthApiClient();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockAuthApiClient);
  });

  test('login should return a successful result', () async {
    //
  });
}
