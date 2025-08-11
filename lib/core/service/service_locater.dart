import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:transports/core/service/service_impl.dart.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/auth/data/repos/driver/driver_info_repo.dart';
import 'package:transports/features/auth/data/repos/driver/driver_info_repo_impl.dart';
import 'package:transports/features/auth/data/repos/otp_repo.dart';
import 'package:transports/features/auth/data/repos/otp_repo_impl.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/driver_info/driver_info_cubit.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/resend_otp/resend_otp_cubit.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/sending_otp_cubit/sending_otp_cubit.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/verify_otp/verifying_otp_cubit.dart';

import 'api_service.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(
      () => ApiServiceImpl(getIt.get<Dio>()));
      getIt.registerLazySingleton<SharedPrefs>(()=>SharedPrefs());
      getIt.registerLazySingleton<OtpRepo>(()=>OtpRepoImpl(apiService: getIt.get<ApiService>(), sharedPrefService: getIt.get<SharedPrefs>()));
      getIt.registerFactory<SendingOtpCubit>(()=>SendingOtpCubit(otpRepo:getIt.get<OtpRepo>() ));
      getIt.registerFactory<VerifyingOtpCubit>(()=>VerifyingOtpCubit(otpRepo:getIt.get<OtpRepo>() ));
      getIt.registerFactory<ResendOtpCubit>(()=>ResendOtpCubit(getIt.get<OtpRepo>() ));
            getIt.registerLazySingleton<DriverInfoRepo>(()=>DriverInfoRepoImpl( getIt.get<ApiService>()));

      getIt.registerFactory<DriverInfoCubit>(()=>DriverInfoCubit( driverInfoRepo: getIt.get<DriverInfoRepo>(), ));
  
}
