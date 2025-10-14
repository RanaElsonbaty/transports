import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/core/storage/shared_prefs.dart';

class ThirdSplashView extends StatefulWidget {
  const ThirdSplashView({super.key});

  @override
  State<ThirdSplashView> createState() => _ThirdSplashViewState();
}

class _ThirdSplashViewState extends State<ThirdSplashView> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final sharedPrefs = getIt.get<SharedPrefs>();

    final String? token = await sharedPrefs.getToken();
    log("token :$token");
    Future.delayed(const Duration(seconds: 3), () {
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacementNamed(context, Routes.home);
      } else {
        Navigator.pushReplacementNamed(context, Routes.register);
      }
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
