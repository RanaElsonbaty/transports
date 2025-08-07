import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/icons.dart';
import 'package:transports/core/theming/styles.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          _buildLineRow(
            icon: AppIcons.upDown,
            label: "من",
          ),
          Divider(color: AppColors.dividerColor,),
          _buildLineRow(
            isFirstRow: false,
            icon: null,
            label: "الي",
          ),
          Divider(color: AppColors.dividerColor,),
          _buildLineRow(
            isFirstRow: false,
            icon: AppIcons.calendar,
            label: "اليوم",
          ),
          Divider(color: AppColors.dividerColor,),
          Row(
            children: [
              _buildLineRow(
                isFirstRow: false,
                icon: AppIcons.userCircle,
                label: "0",
                withoutDivider: true,
              ),
              SizedBox(width: 60.w,),
              Container(
                height: 24,
                width: 1,
                color: AppColors.dividerColor,
              ),
              SizedBox(width: 20.w,),
              _buildLineRow(
                isFirstRow: false,
                icon: AppIcons.clock,
                label: "الساعة",
                withoutDivider: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLineRow({ String ?icon, required String label, bool withoutDivider = false,bool isFirstRow=true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: isFirstRow? Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (icon != null)
          Text(
            label,
              style: TextStyles.font14CardColor500Weight,
          ),
           Spacer(),
          SvgPicture.asset(icon!,height: 15.h,width: 15.w,)
        ],
      ):Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (icon != null)
            SvgPicture.asset(icon,height: 15.h,width: 15.w,),
          if (icon != null) SizedBox(width: 12.w),
          Text(
            label,
            style: TextStyles.font14CardColor500Weight,
          ),
        ],
      ),
    );
  }
}
