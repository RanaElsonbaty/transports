import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/features/auth/data/repos/otp_repo.dart';
import 'package:transports/features/auth/register/presentation/view/attachment_view.dart';
import 'package:transports/features/auth/register/presentation/view/driver_info_view.dart';
import 'package:transports/features/auth/register/presentation/view/otp_view.dart';
import 'package:transports/features/auth/register/presentation/view/register_view.dart';
import 'package:transports/features/auth/register/presentation/view/successview.dart';
import 'package:transports/features/auth/register/presentation/view/vehicle_info_view.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/sending_otp_cubit/sending_otp_cubit.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/verify_otp/verifying_otp_cubit.dart';
import 'package:transports/features/home/presentation/view/home_view.dart';
import 'package:transports/features/home/presentation/view/profile_view.dart';
import 'package:transports/features/splash/presentation/view/second_splash_view.dart';
import 'package:transports/features/splash/presentation/view/splash_view.dart';

class AppRoutes {
  Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.secondSplash:
        return MaterialPageRoute(builder: (_) => SecondSplashView());
      case Routes.register:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                  getIt.get <SendingOtpCubit>()   ,
                  child: RegisterView(),
                ));

      case Routes.driverInfo:
        return MaterialPageRoute(builder: (_) => DriverInfoScreen());
    
      case Routes.vehicleInfo:
        return MaterialPageRoute(builder: (_) => VehicleInfoView());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.success:
        return MaterialPageRoute(builder: (_) => SuccessView());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
