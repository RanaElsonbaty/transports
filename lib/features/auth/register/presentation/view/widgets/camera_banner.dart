import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/icons.dart';

class CameraBanner extends StatelessWidget {
  const CameraBanner({super.key, this.isPassengerText,  this.title});
  final bool? isPassengerText;
  final String ?title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryLightGradientColor,
            AppColors.primaryDarkGradientColor
          ],
        ),
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Row(
        children: [
           Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title??"اضافة بيانات ركاب",
                  // isPassengerText==true?'إضافة بيانات ركاب':'إضافة بيانات السائق',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  isPassengerText==true? "يمكنك إضافة بينات ركاب الي الحافلة\n الخاصه بك عن طريق الكاميرا":'بإمكانك إضافة بيانات سائق الحافلة\n الخاصة بك عن طريق الكاميرا',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          Stack(
            children: [
             SvgPicture.asset(AppIcons.bigCamera,colorFilter: ColorFilter.mode(AppColors.cameraColor, BlendMode.srcIn),),
             Positioned(
                 left: 0,
                 right: 0,
                 top: 15,
                 child: SvgPicture.asset(AppIcons.smallCamera)),
            ],
          )
        ],
      ),
    );
  }
}
