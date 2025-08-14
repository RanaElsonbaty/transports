import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/home/data/models/seats_model.dart';
import 'package:transports/features/home/presentation/view/widget/custom_drawer.dart';

// class AddPassengerCardsRow extends StatelessWidget {
//   const AddPassengerCardsRow({super.key, required this.onMiniBusTap, required this.onBigBusTap});
//   final VoidCallback onMiniBusTap;
//   final VoidCallback onBigBusTap;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Expanded(child: AddPassengerCard(isBigBus: false, onTap:onMiniBusTap,  )),
//           SizedBox(width: 10.w),
//           Expanded(child: AddPassengerCard(isBigBus: true, onTap: onBigBusTap)),
//         ],
//       ),
//     );
//   }
// }

// class AddPassengerCard extends StatelessWidget {
//   const AddPassengerCard({super.key, required this.isBigBus, required this.onTap, });
//   final bool isBigBus;
//   final void Function() onTap;


//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 100.h,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               AppColors.primaryLightGradientColor,
//               AppColors.primaryDarkGradientColor,
//             ],
//           ),
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: Stack(
//           children: [
//             isBigBus?Positioned(
//                 bottom: 0,
//                 left: 0,
//                 child: Image.asset(AppImages.bigBus, width: 80.w, height: 80.h))
//             :Positioned(
//                 top: 0,
//                 right: 0,
//                 child: Image.asset(AppImages.smallBus, width: 40.w, height: 40.h)),
//             Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                   isBigBus?  'باص':'ميني باص',
//                     style: TextStyles.font16White500Weight,
//                   ),
//                   Text(
//                     isBigBus? 'من 1 لـ 50 راكب':'من 1 لـ 13 راكب',
//                     style: TextStyles.font20White700Weight,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


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
  final   String miniBusData;
  final String  bigBusData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: AddPassengerCard(
              isBigBus: false,
              onTap: onMiniBusTap,
              maxPassengers: miniBusData,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: AddPassengerCard(
              isBigBus: true,
              onTap: onBigBusTap,
              maxPassengers: bigBusData,
            ),
          ),
        ],
      ),
    );
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
                    child: Image.asset(AppImages.bigBus, width: 80.w, height: 80.h))
                : Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(AppImages.smallBus, width: 40.w, height: 40.h)),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isBigBus ? 'bus'.tr() : 'minibus'.tr(),
                    style: TextStyles.font16White500Weight,
                  ),
                  Text(
                    'من 1 لـ $maxPassengers راكب', // الرقم ديناميك
                    style: TextStyles.font20White700Weight,
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
