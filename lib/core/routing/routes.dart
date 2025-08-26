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
import 'package:transports/features/home/presentation/view/previous_trips_view.dart';
import 'package:transports/features/home/presentation/view/profile_view.dart';
import 'package:transports/features/home/presentation/view/widget/language.dart';
import 'package:transports/features/home/presentation/view_model/city_cubit/city_cubit.dart';
import 'package:transports/features/home/presentation/view_model/distance/distance_cubit.dart';
import 'package:transports/features/home/presentation/view_model/logout_cubit/log_out_cubit.dart';
import 'package:transports/features/home/presentation/view_model/pick_data/extract_image_cubit.dart';
import 'package:transports/features/home/presentation/view_model/previouse_trip/previous_trips_cubit.dart';
import 'package:transports/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:transports/features/home/presentation/view_model/reserve_cubit/cubit/reserve_seat_cubit.dart';
import 'package:transports/features/home/presentation/view_model/seats_cubit/seats_cubit.dart';
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
      case Routes.changeLanguage:
        return MaterialPageRoute(builder: (_) => ChangeLanguageView());

      case Routes.attachmentInfo:
        return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (context) => ExtractImageCubit(),
            child: AttachmentsView()));

      case Routes.vehicleInfo:
        return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (context) => ExtractImageCubit(),
            child: VehicleInfoView()));
      case Routes.home:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt.get<LogOutCubit>(),
                    ),
                    BlocProvider(
                      create: (context) =>
                          getIt.get<CityCubit>()..fetchCities(),
                    ),
                    BlocProvider(create: (context) => getIt.get<SeatsCubit>()),
                    BlocProvider(
                        create: (context) => getIt.get<ReserveSeatCubit>()),
                    BlocProvider(
                        create: (context) => ExtractImageCubit()),
                    BlocProvider(
                        create: (context) => DistanceCubit()),
                  ],
                  child: HomeView(),
                ));
      case Routes.previousTrip:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>getIt.get<PreviousTripsCubit>()..getTrips(),
                  child: PreviousTripsView(),
                ));
      case Routes.success:
        return MaterialPageRoute(builder: (_) => SuccessView());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case Routes.myProfile:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      getIt.get<ProfileCubit>()..getProfileInfo(),
                  child: ProfileView(),
                ));
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
