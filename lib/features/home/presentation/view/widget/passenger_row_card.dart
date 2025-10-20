import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticker_text/ticker_text.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/core/storage/shared_prefs.dart'; // import your SharedPrefs

class AddPassengerCardsRow extends StatelessWidget {
  const AddPassengerCardsRow({
    super.key,
    required this.onMiniBusTap,
    required this.onBigBusTap,
    required this.miniBusData,
    required this.bigBusData,
  });

  final VoidCallback onMiniBusTap;
  final VoidCallback onBigBusTap;
  final String miniBusData;
  final String bigBusData;

  @override
  Widget build(BuildContext context) {
    // ✅ استخدمي ValueListenableBuilder بدل FutureBuilder
    return ValueListenableBuilder<String?>(
      valueListenable: SharedPrefs.vehicleTypeNotifier,
      builder: (context, vehicleType, _) {
        // أول مرة ممكن تكون القيمة null → نحملها يدويًا من shared prefs
        if (vehicleType == null) {
          _loadInitialType();
          return const Center(child: CircularProgressIndicator());
        }

        if (vehicleType == "bus") {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AddPassengerCard(
              isBigBus: true,
              onTap: onBigBusTap,
              maxPassengers: bigBusData,
            ),
          );
        } else if (vehicleType == "minibus") {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AddPassengerCard(
              isBigBus: false,
              onTap: onMiniBusTap,
              maxPassengers: miniBusData,
            ),
          );
        } else {
          return const Center(child: Text("Invalid vehicle type found"));
        }
      },
    );
  }

  /// 🔹 نحمل القيمة لأول مرة فقط
  Future<void> _loadInitialType() async {
    final prefs = SharedPrefs();
    final type = await prefs.getVehicleType();
    SharedPrefs.vehicleTypeNotifier.value = type;
  }
}


class AddPassengerCard extends StatelessWidget {
  const AddPassengerCard({
    super.key,
    required this.isBigBus,
    required this.onTap,
    required this.maxPassengers,
  });

  final bool isBigBus;
  final VoidCallback onTap;
  final String maxPassengers;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.primaryLightGradientColor,
              AppColors.primaryDarkGradientColor,
            ],
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            isBigBus
                ? Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                AppImages.realBigBus,
                width: 80.w,
                height: 80.h,
              ),
            )
                : Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                AppImages.realSmallBus,
                width: 70.w,
                height: 70.h,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isBigBus ? 'bus'.tr() : 'minibus'.tr(),
                    style: TextStyles.font16White500Weight,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: TickerText(
                      speed: 20,
                      primaryCurve: Curves.linear,
                      returnCurve: Curves.easeOut,
                      returnDuration: const Duration(milliseconds: 400),
                      startPauseDuration: const Duration(seconds: 1),
                      child: Text(
                        context.locale.languageCode == 'en'
                            ? '1 to $maxPassengers passenger${int.parse(maxPassengers) > 1 ? "s" : ""}'
                            : 'passenger_range'.tr(args: [maxPassengers]),
                        style: TextStyles.font20White700Weight,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
