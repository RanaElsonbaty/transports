import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/theming/colors.dart';
import 'dart:ui' as ui;

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:context.locale.languageCode == 'ar'
    ? ui.TextDirection.rtl
    :ui.TextDirection.ltr,
 
      child: GestureDetector(
        onTap: (){
          context.pop();
        },
        child: Container(
          height: 32.h,
          width: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.dividerColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.blackColor.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Icon(
            context.locale.languageCode == "ar"
                  ? Icons.arrow_forward  
      : Icons.arrow_back,  
            size: 18,
            color: Colors.black,
          ),
          ),
        ),
      ),
    );
  }
}
