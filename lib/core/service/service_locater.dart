import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:transports/core/service/service_impl.dart.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/auth/data/repos/driver/driver_info_repo.dart';
import 'package:transports/features/auth/data/repos/driver/driver_info_repo_impl.dart';
import 'package:transports/features/auth/data/repos/otp/otp_repo.dart';
import 'package:transports/features/auth/data/repos/otp/otp_repo_impl.dart';
import 'package:transports/features/auth/data/repos/vehicle/vehicle_repo.dart';
import 'package:transports/features/auth/data/repos/vehicle/vehicle_repo_impl.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/driver_info/driver_info_cubit.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/resend_otp/resend_otp_cubit.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/sending_otp_cubit/sending_otp_cubit.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/vehicle_info/vehicle_info_cubit.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/verify_otp/verifying_otp_cubit.dart';
import 'package:transports/features/home/data/repos/city/city_repo.dart';
import 'package:transports/features/home/data/repos/city/city_repo_impl.dart';
import 'package:transports/features/home/data/repos/create_trip/create_trip_repo.dart';
import 'package:transports/features/home/data/repos/create_trip/create_trip_repo_impl.dart';
import 'package:transports/features/home/data/repos/profile/profile_repo.dart';
import 'package:transports/features/home/data/repos/profile/profile_repo_impl.dart';
import 'package:transports/features/home/data/repos/seats/seats_repo.dart';
import 'package:transports/features/home/data/repos/seats/seats_repo_impl.dart';
import 'package:transports/features/home/presentation/view_model/city_cubit/city_cubit.dart';
import 'package:transports/features/home/presentation/view_model/create_trip/creating_trip_cubit.dart';
import 'package:transports/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:transports/features/home/presentation/view_model/seats_cubit/seats_cubit.dart';

import 'api_service.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(
      () => ApiServiceImpl(getIt.get<Dio>()));
  getIt.registerLazySingleton<SharedPrefs>(() => SharedPrefs());
  getIt.registerLazySingleton<OtpRepo>(() => OtpRepoImpl(
      apiService: getIt.get<ApiService>(),
      sharedPrefService: getIt.get<SharedPrefs>()));
  getIt.registerFactory<SendingOtpCubit>(
      () => SendingOtpCubit(otpRepo: getIt.get<OtpRepo>()));
  getIt.registerFactory<VerifyingOtpCubit>(
      () => VerifyingOtpCubit(otpRepo: getIt.get<OtpRepo>()));
  getIt.registerFactory<ResendOtpCubit>(
      () => ResendOtpCubit(getIt.get<OtpRepo>()));
  getIt.registerLazySingleton<DriverInfoRepo>(() =>
      DriverInfoRepoImpl(getIt.get<ApiService>(), getIt.get<SharedPrefs>()));
  getIt.registerLazySingleton<VehicleRepo>(
      () => VehicleRepoImpl(getIt.get<ApiService>(), getIt.get<SharedPrefs>()));

  getIt.registerFactory<DriverInfoCubit>(() => DriverInfoCubit(
        driverInfoRepo: getIt.get<DriverInfoRepo>(),
      ));
getIt.registerLazySingleton<SeatsRepo>(
      () => SeatsRepoImpl(getIt.get<ApiService>(), getIt.get<SharedPrefs>()));

        getIt.registerFactory<SeatsCubit>(() => SeatsCubit(
         getIt.get<SeatsRepo>(),
      ));
  getIt.registerFactory<VehicleInfoCubit>(
      () => VehicleInfoCubit(getIt.get<VehicleRepo>()));
      getIt.registerLazySingleton<CityRepo>(
      () => CityRepoImpl(  apiService: getIt.get<ApiService>(), sharedPrefs: getIt.get<SharedPrefs>()));

       getIt.registerFactory<CityCubit>(
      () => CityCubit(getIt.get<CityRepo>()));
      
       getIt.registerFactory<CreatingTripCubit>(
      () => CreatingTripCubit(getIt.get<CreateTripRepo>()));
      getIt.registerLazySingleton<CreateTripRepo>(
      () => CreateTripRepoImpl(getIt.get<ApiService>(), getIt.get<SharedPrefs>()));
    getIt.registerFactory<ProfileCubit>(
      () => ProfileCubit(getIt.get<ProfileRepo>()));
            getIt.registerLazySingleton<ProfileRepo>(
      () => ProfileRepoImpl(getIt.get<ApiService>(), getIt.get<SharedPrefs>()));

}
