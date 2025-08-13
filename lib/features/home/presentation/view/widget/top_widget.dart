import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/theming/icons.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/home/presentation/view/widget/passenger_row_card.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({super.key, required this.onMiniBusTap, required this.onBigBusTap});
 final VoidCallback onMiniBusTap;
  final VoidCallback onBigBusTap;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Image.asset(AppImages.maps,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 85.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'يسعد صباحك',
                    style: TextStyles.font12Black500Weight,
                  ),
                  InkWell(
                    onTap: (){
                     context.pushNamed(Routes.profile);
                    },
                    child: Text(
                      'ابو نواف المصري',
                      style: TextStyles.font14Black700Weight,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
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
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        AppIcons.notification,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                    Positioned(
                      top: -8,
                      right: -6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '12',
                          style: TextStyles.font8White500Weight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
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
          bottom: 0,

          child:AddPassengerCardsRow(onMiniBusTap: onMiniBusTap, onBigBusTap:onBigBusTap ,),
        ),
      ],
    );
  }
}
