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

import '../../core/helpers/url_launcher_helper.dart' as _i220;
import '../../core/local_cubit/locale_cubit.dart' as _i65;
import '../module/api_module.dart' as _i235;
import '../module/storage_module.dart' as _i487;
import '../secure_cache/secure_cache/secure_cache.dart' as _i23;
import '../secure_cache/secure_cache/secure_cache_helper.dart' as _i987;

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
    gh.lazySingleton<_i220.UrlLauncherHelper>(() => _i220.UrlLauncherHelper());
    gh.lazySingleton<_i23.SecureCache>(
      () => _i987.SecureCacheImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => apiModule.provideFcmDio(gh<_i528.PrettyDioLogger>()),
      instanceName: 'fcmDio',
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
    return this;
  }
}

class _$ApiModule extends _i235.ApiModule {}

class _$StorageModule extends _i487.StorageModule {}
