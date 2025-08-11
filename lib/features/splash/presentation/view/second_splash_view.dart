import 'package:flutter/material.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/theming/images.dart';

class SecondSplashView extends StatefulWidget {
  const SecondSplashView({super.key});

  @override
  State<SecondSplashView> createState() => _SecondSplashViewState();
}

class _SecondSplashViewState extends State<SecondSplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.register);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.splash,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppImages.logo,height: 300,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
