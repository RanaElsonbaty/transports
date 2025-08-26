//assets\lottie\empty.json
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transports/core/theming/colors.dart';

class PreviousEmptyTrip extends StatelessWidget {
  const PreviousEmptyTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Column(children: [
      Lottie.asset('assets/lottie/buses.json',fit:BoxFit.contain),
Text("no_trips".tr(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: AppColors.primaryColor),)
    ],);
  }
}