import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/theming/images.dart';

class ThirdSplashView extends StatefulWidget {
  const ThirdSplashView({super.key});

  @override
  State<ThirdSplashView> createState() => _ThirdSplashViewState();
}

class _ThirdSplashViewState extends State<ThirdSplashView> {
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
        child: Image.asset(
          'assets/images/third_splash.png',
          height: double.infinity,
          fit: BoxFit.fill,),
      ),
    );
  }
}
