import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/features/splash/presentation/view/second_splash_view.dart';

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
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SecondSplashView(),
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
      body:
      FadeIn(

        child: Image.asset(
          AppImages.tigerLogo,
          height: double.infinity,
          fit: BoxFit.fill,),
      ),
    );
  }
}
