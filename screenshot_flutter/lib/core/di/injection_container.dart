import 'package:get_it/get_it.dart';
import 'package:screenshot_flutter/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:screenshot_flutter/features/auth/data/datasources/auth_local_datasource_impl.dart';
import 'package:screenshot_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:screenshot_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:screenshot_flutter/features/auth/domain/usecases/get_location_usecase.dart';
import 'package:screenshot_flutter/features/auth/domain/usecases/save_security_data_usecase.dart';
import 'package:screenshot_flutter/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:screenshot_flutter/features/auth/presentation/cubit/login_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth

  // Cubit
  sl.registerFactory(
    () => LoginCubit(
      verifyOTPUseCase: sl(),
      getLocationUseCase: sl(),
      saveSecurityDataUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => VerifyOTPUseCase(sl()));
  sl.registerLazySingleton(() => GetLocationUseCase(sl()));
  sl.registerLazySingleton(() => SaveSecurityDataUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
}
