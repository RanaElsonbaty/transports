import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transports/core/theming/colors.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Column(children: [
      Lottie.asset('assets/lottie/buses.json',fit:BoxFit.contain),
Text("select_bus_type".tr(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: AppColors.primaryColor),)
    ],);
  }
}