import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, Routes.secondSplash);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/bus.json',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              'أتوبيسي',
              textAlign: TextAlign.center,
              style: TextStyles.font35BlueDark900Weight,
            ),
          ],
        ),
      ),
    );
  }
}
