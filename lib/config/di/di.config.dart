// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../core/local_cubit/locale_cubit.dart' as _i65;
import '../../features/auth/api/auth_api_client/auth_api_client.dart' as _i474;
import '../../features/auth/api/data_sources/remote/auth_remote_data_source_impl.dart'
    as _i411;
import '../../features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i432;
import '../../features/auth/data/repositories/auth_repo_impl.dart' as _i662;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i723;
import '../../features/auth/domain/use_cases/forget_password_use_case.dart'
    as _i483;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/register_use_case.dart' as _i1010;
import '../../features/auth/domain/use_cases/reset_password_use_case.dart'
    as _i169;
import '../../features/auth/domain/use_cases/verify_reset_otp_use_case.dart'
    as _i40;
import '../module/api_module.dart' as _i235;
import '../module/storage_module.dart' as _i487;
import '../secure_cache/secure_cache/secure_cache.dart' as _i23;
import '../secure_cache/secure_cache/secure_cache_helper.dart' as _i987;
import '../user/api/data_sources/remote/user_remote_data_source_impl.dart'
    as _i694;
import '../user/api/user_api_client/user_api_client.dart' as _i1062;
import '../user/data/data_sources/remote/user_remote_data_source.dart' as _i806;
import '../user/data/repositories/user_repo_impl.dart' as _i419;
import '../user/domain/repositories/user_repo.dart' as _i632;
import '../user/domain/use_cases/get_user_data_use_case.dart' as _i180;
import '../user/manager/user_cubit.dart' as _i720;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    final storageModule = _$StorageModule();
    gh.lazySingleton<_i361.BaseOptions>(() => apiModule.providerOption());
    gh.lazySingleton<_i528.PrettyDioLogger>(
      () => apiModule.providerDioLogger(),
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.provideSecureCacheStorage(),
    );
    gh.lazySingleton<_i23.SecureCache>(
      () => _i987.SecureCacheImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i65.LocaleCubit>(
      () => _i65.LocaleCubit(gh<_i23.SecureCache>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => apiModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i528.PrettyDioLogger>(),
        gh<_i23.SecureCache>(),
      ),
    );
    gh.factory<_i1062.UserApiClient>(
      () => _i1062.UserApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i474.AuthApiClient>(() => _i474.AuthApiClient(gh<_i361.Dio>()));
    gh.factory<_i432.AuthRemoteDataSource>(
      () => _i411.AuthRemoteDataSourceImpl(gh<_i474.AuthApiClient>()),
    );
    gh.factory<_i806.UserRemoteDataSource>(
      () => _i694.UserRemoteDataSourceImpl(gh<_i1062.UserApiClient>()),
    );
    gh.factory<_i723.AuthRepo>(
      () => _i662.AuthRepoImpl(
        gh<_i432.AuthRemoteDataSource>(),
        gh<_i23.SecureCache>(),
      ),
    );
    gh.factory<_i483.ForgetPasswordUseCase>(
      () => _i483.ForgetPasswordUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i1038.LoginUseCase>(
      () => _i1038.LoginUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i1010.RegisterUseCase>(
      () => _i1010.RegisterUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i169.ResetPasswordUseCase>(
      () => _i169.ResetPasswordUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i40.VerifyResetOtpUseCase>(
      () => _i40.VerifyResetOtpUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i632.UserRepo>(
      () => _i419.UserRepoImpl(gh<_i806.UserRemoteDataSource>()),
    );
    gh.factory<_i180.GetUserDataUseCase>(
      () => _i180.GetUserDataUseCase(gh<_i632.UserRepo>()),
    );
    gh.lazySingleton<_i720.UserCubit>(
      () => _i720.UserCubit(gh<_i180.GetUserDataUseCase>()),
    );
    return this;
  }
}

class _$ApiModule extends _i235.ApiModule {}

class _$StorageModule extends _i487.StorageModule {}
