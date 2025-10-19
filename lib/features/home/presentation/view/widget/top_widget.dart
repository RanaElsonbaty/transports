import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transports/core/theming/icons.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/home/presentation/view/widget/language_drop_down.dart';
import 'package:transports/features/home/presentation/view/widget/passenger_row_card.dart';
import 'package:transports/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({
    super.key,
    required this.onMiniBusTap,
    required this.onBigBusTap,
    required this.miniBusMaxPassengers,
    required this.bigBusMaxPassengers,
  });

  final VoidCallback onMiniBusTap;
  final VoidCallback onBigBusTap;
  final String miniBusMaxPassengers;
  final String bigBusMaxPassengers;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(AppImages.maps),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
          child: Row(
            children: [
              LanguageRowSelector()
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 65.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'hello'.tr(),
                    style: TextStyles.font12Black500Weight,
                  ),
                  Builder(
                    builder: (context) {
                      final state = context.watch<ProfileCubit>().state;

                      if (state is ProfileSuccess) {
                        final profile = state.profile.data?.user;
                        return Text(
                          profile?.name ?? "",
                          style: TextStyles.font14Black700Weight,
                        );
                      }
                      return Text(
                        "",
                        style: TextStyles.font14Black700Weight,
                      );
                    },
                  ),
                ],
              ),
              const Spacer(),
              Builder(
                builder: (context) => GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppIcons.drawer,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: AddPassengerCardsRow(
            onMiniBusTap: onMiniBusTap,
            onBigBusTap: onBigBusTap,
            miniBusData: miniBusMaxPassengers,
            bigBusData: bigBusMaxPassengers,
          ),
        ),
      ],
    );
  }
}
