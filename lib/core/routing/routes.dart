import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/features/auth/register/presentation/view/attachment_view.dart';
import 'package:transports/features/auth/register/presentation/view/register_view.dart';
import 'package:transports/features/auth/register/presentation/view/successview.dart';
import 'package:transports/features/auth/register/presentation/view/vehicle_info_view.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/sending_otp_cubit/sending_otp_cubit.dart';
import 'package:transports/features/home/presentation/view/home_view.dart';
import 'package:transports/features/home/presentation/view/profile_view.dart';
import 'package:transports/features/home/presentation/view_model/seats_cubit/seats_cubit.dart';
import 'package:transports/features/profile/presentation/view/my_profile_view.dart';
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
                  create: (context) => getIt.get<SendingOtpCubit>(),
                  child: RegisterView(),
                ));

      case Routes.attachmentInfo:
        return MaterialPageRoute(builder: (_) => AttachmentsView());


      case Routes.vehicleInfo:
        return MaterialPageRoute(builder: (_) => VehicleInfoView());
      case Routes.home:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt.get<SeatsCubit>(),
                  child: HomeView(),
                ));
      case Routes.success:
        return MaterialPageRoute(builder: (_) => SuccessView());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case Routes.myProfile:
        return MaterialPageRoute(builder: (_) => MyProfileView());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
