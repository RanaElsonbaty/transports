import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/images.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.register);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      FadeIn(
        duration: const Duration(milliseconds: 300),
        child: Center(
          child: Shimmer.fromColors(
            baseColor: AppColors.greenColor,
            highlightColor: AppColors.greyColor,
            child: Image.asset(
              AppImages.logo,
              height: 350.h,
              fit: BoxFit.contain,),
          ),),
      ),
    );
  }
}
