import 'package:flutter/material.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/features/splash/presentation/view/third_splash_view.dart';

class SecondSplashView extends StatefulWidget {
  const SecondSplashView({super.key});

  @override
  State<SecondSplashView> createState() => _SecondSplashViewState();
}

class _SecondSplashViewState extends State<SecondSplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (_, __, ___) => const ThirdSplashView(),
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ));
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
                Image.asset(AppImages.logo,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
