import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';
import 'package:transports/features/home/presentation/view_model/city_cubit/city_cubit.dart';
import 'package:transports/features/home/presentation/view_model/create_trip/creating_trip_cubit.dart';
import 'package:transports/features/home/presentation/view_model/distance/distance_cubit.dart';

class TripDetailsWidget extends StatefulWidget {
  const TripDetailsWidget({super.key, required this.passengersData});
  final List<Map<String, dynamic>> passengersData;

  @override
  State<TripDetailsWidget> createState() => _TripDetailsWidgetState();
}

class _TripDetailsWidgetState extends State<TripDetailsWidget> {
  String? fromCity;
  String? toCity;
  int? fromCityId;
  int? toCityId;
  bool tripStarted = false;
  int maxPassengers = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: AppColors.whiteColor,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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

                  /// Distance Display
                  BlocBuilder<DistanceCubit, DistanceState>(
                    builder: (context, state) {
                      if (state is DistanceLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is DistanceSuccess) {
                        final km = state.distanceModel.data?.distance?.kilometers ?? 0;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'المسافة: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black, // اللون الافتراضي
                                  ),
                                ),
                                TextSpan(
                                  text: '${km.toInt()}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' كم',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        ;
                      } else if (state is DistanceFailure) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'خطأ: ${state.error}',
                            style: const TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  /// Route Line
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("from".tr()),
                          const SizedBox(width: 10),
                          ...List.generate(
                            7,
                                (index) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                width: 20,
                                height: 2,
                                color: tripStarted
                                    ? AppColors.primaryStateColor
                                    : AppColors.greyColor,
                              ),
                            ),
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

                  /// Dropdowns for cities
                  Row(
                    children: [
                      /// From City Dropdown
                      Expanded(
                        child: BlocBuilder<CityCubit, CityState>(
                          builder: (context, state) {
                            final cubit = context.read<CityCubit>();
                            final cities = (state is CitySuccess)
                                ? state.cities
                                : [];

                            final cityNames = cities
                                .map((e) => context.locale.languageCode == 'ar'
                                ? e.nameAr
                                : e.nameEn)
                                .whereType<String>()
                                .toSet()
                                .toList();

                            final dropdownItems = cityNames.isEmpty
                                ? ["⚠ لا توجد مدن تحقق من الاتصال"]
                                : cityNames;

                            return DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownItems.contains(fromCity) ? fromCity : null,
                              hint: Text(
                                'from'.tr(),
                                style: TextStyles.font12SecondaryBlack500Weight,
                              ),
                              onTap: () {
                                if (cities.isEmpty) cubit.fetchCities();
                              },
                              onChanged: (value) {
                                if (value != null && !value.startsWith("⚠")) {
                                  final cityId = cities.firstWhere(
                                        (city) =>
                                    (context.locale.languageCode == 'ar'
                                        ? city.nameAr
                                        : city.nameEn) ==
                                        value,
                                  ).id;
                                  setState(() {
                                    fromCity = value;
                                    fromCityId = cityId;
                                  });
                                  if (fromCityId != null && toCityId != null) {
                                    context.read<DistanceCubit>().calculateDistance(
                                      fromCityId: fromCityId!,
                                      toCityId: toCityId!,
                                    );
                                  }
                                }
                              },
                              items: dropdownItems.map((city) {
                                final isError = city.startsWith("⚠");
                                return DropdownMenuItem<String>(
                                  value: city,
                                  child: Text(
                                    city,
                                    style: TextStyle(
                                        color: isError ? Colors.red : Colors.black),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),

                      /// To City Dropdown
                      Expanded(
                        child: BlocBuilder<CityCubit, CityState>(
                          builder: (context, state) {
                            final cubit = context.read<CityCubit>();
                            final cities = (state is CitySuccess)
                                ? state.cities
                                : [];

                            final cityNames = cities
                                .map((e) => context.locale.languageCode == 'ar'
                                ? e.nameAr
                                : e.nameEn)
                                .whereType<String>()
                                .toSet()
                                .toList();

                            final dropdownItems = cityNames.isEmpty
                                ? ["⚠ لا توجد مدن تحقق من الاتصال"]
                                : cityNames;

                            return DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownItems.contains(toCity) ? toCity : null,
                              hint: Text(
                                'to'.tr(),
                                style: TextStyles.font12SecondaryBlack500Weight,
                              ),
                              onTap: () {
                                if (cities.isEmpty) cubit.fetchCities();
                              },
                              onChanged: (value) {
                                if (value != null && !value.startsWith("⚠")) {
                                  final cityId = cities.firstWhere(
                                        (city) =>
                                    (context.locale.languageCode == 'ar'
                                        ? city.nameAr
                                        : city.nameEn) ==
                                        value,
                                  ).id;
                                  setState(() {
                                    toCity = value;
                                    toCityId = cityId;
                                  });
                                  if (fromCityId != null && toCityId != null) {
                                    context.read<DistanceCubit>().calculateDistance(
                                      fromCityId: fromCityId!,
                                      toCityId: toCityId!,
                                    );
                                  }
                                }
                              },
                              items: dropdownItems.map((city) {
                                final isError = city.startsWith("⚠");
                                return DropdownMenuItem<String>(
                                  value: city,
                                  child: Text(
                                    city,
                                    style: TextStyle(
                                        color: isError ? Colors.red : Colors.black),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 200),

        /// Start Trip Button
        BlocConsumer<CreatingTripCubit, CreatingTripState>(
          listener: (context, state) {
            // Navigator.of(context).pop();
            if (state is CreatingTripSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('trip_started_success'.tr())),
              );
            } else if (state is CreatingTripFailure) {
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
                  if (fromCityId != null &&
                      toCityId != null &&
                      widget.passengersData.isNotEmpty) {
                    setState(() {
                      tripStarted = true; // هنا يبدأ التغيير
                    });
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
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    // Close the bottom sheet after 2 seconds
                    Future.delayed(const Duration(seconds: 2), () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    });
                    context.read<CreatingTripCubit>().createTrip(
                      departureLocation: toCity.toString(),
                      destinationLocation: fromCity.toString(),
                      maxPassengers: maxPassengers,
                      passengers: widget.passengersData,
                    );
                  } else if (widget.passengersData.isEmpty) {
                    _showErrorDialog(context, "select_seat_fill_passenger".tr());
                  } else {
                    _showErrorDialog(context, 'يرجى اختيار المدينتين أولاً!');
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
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
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue = Curves.easeInOut.transform(animation.value);
        return Opacity(
          opacity: curvedValue,
          child: Transform.scale(
            scale: curvedValue,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  message,
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
}

class TripArrowAnimation extends StatefulWidget {
  final bool tripStarted;

  const TripArrowAnimation({super.key, required this.tripStarted});

  @override
  State<TripArrowAnimation> createState() => _TripArrowAnimationState();
}

class _TripArrowAnimationState extends State<TripArrowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // تكرار الحركة ذهابًا وإيابًا

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.3, 0), // تحريك السهم لليسار
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant TripArrowAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tripStarted) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("from"),
        const SizedBox(width: 10),
        ...List.generate(
          7,
              (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: 20,
              height: 2,
              color: widget.tripStarted
                  ? Colors.blue
                  : Colors.grey,
            ),
          ),
        ),
        SlideTransition(
          position: _offsetAnimation,
          child: Icon(
            Icons.arrow_right,
            color: widget.tripStarted ? Colors.blue : Colors.grey,
            size: 40,
          ),
        ),
        const SizedBox(width: 10),
        Text("to"),
      ],
    );
  }
}
