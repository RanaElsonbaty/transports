import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/home/data/models/seats_model.dart';
import 'package:transports/features/home/presentation/view/widget/custom_drawer.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';
import 'package:transports/features/home/presentation/view_model/city_cubit/city_cubit.dart';
import 'package:transports/features/home/presentation/view_model/create_trip/creating_trip_cubit.dart';

class TripDetailsWidget extends StatefulWidget {
  const TripDetailsWidget(
      {super.key,required this.passengersData });
  final List<Map<String, dynamic>> passengersData;

  @override
  State<TripDetailsWidget> createState() => _TripDetailsWidgetState();
}

class _TripDetailsWidgetState extends State<TripDetailsWidget> {
  String? fromCity;
  String? toCity;
  bool tripStarted = false;
   int maxPassengers=50;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: AppColors.whiteColor,
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'tripdetails'.tr(),
                        style: TextStyles.font18MainBlack500Weight,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("from".tr()),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted
                                ? AppColors.primaryStateColor
                                : AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted
                                ? AppColors.primaryStateColor
                                : AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted
                                ? AppColors.primaryStateColor
                                : AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted
                                ? AppColors.primaryStateColor
                                : AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted
                                ? AppColors.primaryStateColor
                                : AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted
                                ? AppColors.primaryStateColor
                                : AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted
                                ? AppColors.primaryStateColor
                                : AppColors.greyColor,
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: tripStarted
                                ? AppColors.primaryStateColor
                                : AppColors.greyColor,
                            size: 40,
                          ),
                          const SizedBox(width: 10),
                          Text("to".tr()),
                        ],
                      ),
                    ],
                  ),
             Row(
  children: [
 
    Expanded(
      child: BlocBuilder<CityCubit, CityState>(
        builder: (context, state) {
          final List<String> cities;

          if (state is CitySuccess) {
            cities = state.cities
                .map((e) => context.locale.languageCode == 'ar'
                    ? e.nameAr
                    : e.nameEn)
                .whereType<String>()
                .toSet()
                .toList();
          } else if (state is CityFailure) {
            cities = ["⚠ ${state.errorMessage}"];
          } else {
            cities = [];
          }

          final dropdownItems = cities.isEmpty
              ? ["⚠ لا توجد مدن تحقق من الا تصال"]
              : cities;

          return DropdownButton<String>(
            isExpanded: true,
            value: dropdownItems.contains(fromCity) ? fromCity : null,
            hint: Text(
              'from'.tr(),
              style: TextStyles.font12SecondaryBlack500Weight,
            ),
            onTap: () {
              if (cities.isEmpty || cities.first.startsWith("⚠")) {
                context.read<CityCubit>().fetchCities();
              }
            },
            onChanged: (value) {
              if (value != null && !value.startsWith("⚠")) {
                setState(() {
                  fromCity = value;
                });
              } else {
                context.read<CityCubit>().fetchCities();
              }
            },
            items: dropdownItems.map<DropdownMenuItem<String>>((city) {
              final isError = city.startsWith("⚠");
              return DropdownMenuItem<String>(
                value: city,
                child: Text(
                  city,
                  style: TextStyle(color: isError ? Colors.red : Colors.black),
                ),
              );
            }).toList(),
          );
        },
      ),
    ),
    const Spacer(),
    Expanded(
      child: BlocBuilder<CityCubit, CityState>(
        builder: (context, state) {
          final List<String> cities;

          if (state is CitySuccess) {
            cities = state.cities
                .map((e) => context.locale.languageCode == 'ar'
                    ? e.nameAr
                    : e.nameEn)
                .whereType<String>()
                .toSet()
                .toList();
          } else if (state is CityFailure) {
            cities = ["⚠ ${state.errorMessage}"];
          } else {
            cities = [];
          }

          final dropdownItems = cities.isEmpty
              ? ["⚠ لا توجد مدن تحقق من الا تصال"]
              : cities;

          return DropdownButton<String>(
            isExpanded: true,
            value: dropdownItems.contains(toCity) ? toCity : null,
            hint: Text(
              'to'.tr(),
              style: TextStyles.font12SecondaryBlack500Weight,
            ),
            onTap: () {
              if (cities.isEmpty || cities.first.startsWith("⚠")) {
                context.read<CityCubit>().fetchCities();
              }
            },
            onChanged: (value) {
              if (value != null && !value.startsWith("⚠")) {
                setState(() {
                  toCity = value;
                });
              } else {
                context.read<CityCubit>().fetchCities();
              }
            },
            items: dropdownItems.map<DropdownMenuItem<String>>((city) {
              final isError = city.startsWith("⚠");
              return DropdownMenuItem<String>(
                value: city,
                child: Text(
                  city,
                  style: TextStyle(color: isError ? Colors.red : Colors.black),
                ),
              );
            }).toList(),
          );
        },
      ),
    ),


  ],
)

                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 200),
 BlocConsumer<CreatingTripCubit, CreatingTripState>(
  listener: (context, state) {
    if (state is CreatingTripSuccess) {
      Navigator.of(context).pop(); 
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('trip_started_success'.tr())),
      );
    } else if (state is CreatingTripFailure) {
      Navigator.of(context).pop(); 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${"trip_creation_error".tr()}: ${state.errorMessage}')),
      );
    }
  },
  builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CustomPrimaryButton(
        text: 'startTrip'.tr(),
        onPressed: () {
          if (fromCity != null && toCity != null && widget.passengersData.isNotEmpty) {
            showModalBottomSheet(
              context: context,
              isDismissible: false,
              isScrollControlled: false,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/loading.json',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                         Text(
"wait_for_admin_approval".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            );

            context.read<CreatingTripCubit>().createTrip(departureLocation: toCity.toString(), 
            destinationLocation:fromCity.toString() ,
             maxPassengers: maxPassengers, 
             passengers: widget.passengersData);

          }else if(widget.passengersData.isEmpty){
               showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: '',
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, animation1, animation2) {
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pop();
                });
                return const SizedBox();
              },
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                final curvedValue =
                    Curves.easeInOut.transform(animation.value);
                return Opacity(
                  opacity: curvedValue,
                  child: Transform.scale(
                    scale: curvedValue,
                    child: Center(
                      child: Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 30),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                        "select_seat_fill_passenger".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyles.font14White700Weight.copyWith(
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          
          }
          
          else {
             

            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: '',
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, animation1, animation2) {
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pop();
                });
                return const SizedBox();
              },
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                final curvedValue =
                    Curves.easeInOut.transform(animation.value);
                return Opacity(
                  opacity: curvedValue,
                  child: Transform.scale(
                    scale: curvedValue,
                    child: Center(
                      child: Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 30),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'يرجى اختيار المدينتين أولاً!',
                          textAlign: TextAlign.center,
                          style: TextStyles.font14White700Weight.copyWith(
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  },
)

      ],
    );
  }
}
