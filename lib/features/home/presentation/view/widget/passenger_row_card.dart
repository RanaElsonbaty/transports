import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/home/data/models/seats_model.dart';

class AddPassengerCardsRow extends StatelessWidget {
  const AddPassengerCardsRow({super.key, required this.onMiniBusTap, required this.onBigBusTap});
  final VoidCallback onMiniBusTap;
  final VoidCallback onBigBusTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(child: AddPassengerCard(isBigBus: false, onTap:onMiniBusTap,  )),
          SizedBox(width: 10.w),
          Expanded(child: AddPassengerCard(isBigBus: true, onTap: onBigBusTap)),
        ],
      ),
    );
  }
}

class AddPassengerCard extends StatelessWidget {
  const AddPassengerCard({super.key, required this.isBigBus, required this.onTap, });
  final bool isBigBus;
  final void Function() onTap;


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
            isBigBus?Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(AppImages.bigBus, width: 80.w, height: 80.h))
            :Positioned(
                top: 0,
                right: 0,
                child: Image.asset(AppImages.smallBus, width: 40.w, height: 40.h)),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  isBigBus?  'باص':'ميني باص',
                    style: TextStyles.font16White500Weight,
                  ),
                  Text(
                    isBigBus? 'من 1 لـ 50 راكب':'من 1 لـ 13 راكب',
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
