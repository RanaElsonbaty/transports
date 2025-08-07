import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/camera_banner.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';

class PassengerDataView extends StatelessWidget {
  const PassengerDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButtonWidget(),
                const SizedBox(height: 16),
                CameraBanner(isPassengerText: true,),
                const SizedBox(height: 30),
                const Text(
                  'بيانات الراكب',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                buildInput('الاسم'),
                buildInput('رقم الهوايه'),
                buildInput('الجنسيه'),
                SizedBox(height: 60.h,),
                CustomPrimaryButton( text: 'تأكيد',
                  onPressed: (){
                    context.pushNamed(Routes.home);
                  },),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInput(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyles.font14Black700Weight,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.borderColor)
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.greyColor)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.greyColor)
            )
        ),
      ),
    );
  }
}
