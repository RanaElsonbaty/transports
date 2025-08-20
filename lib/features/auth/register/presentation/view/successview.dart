import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/success.json',
                width: 250,
                height: 250,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 30.h,),
              Text('success'.tr(),style: TextStyles.font20Black700Weight,),
              SizedBox(height: 80.h,),
              CustomPrimaryButton(text: 'home_page'.tr(),
                onPressed: (){
                context.pushNamed(Routes.home);
              },
              )
            ],
          ),
        ),
      ),
    );
  }
}
