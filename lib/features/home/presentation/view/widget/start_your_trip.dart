import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({super.key, this.onPressed, required this.text});
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).copyWith(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return null; // Use decoration
          }),
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.primaryLightGradientColor,
                AppColors.primaryDarkGradientColor
              ],
            ),
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
             text,
              style: TextStyles.font14White700Weight,
            ),
          ),
        ),
      ),
    );
  }
}
