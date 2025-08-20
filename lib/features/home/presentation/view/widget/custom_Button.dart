
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:transports/core/theming/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
 final double ?top;
  final double? bottom;
   final double ?right;
  final double? left;
final bool ?isFullWidth;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    this.textColor = AppColors.whiteColor,
    this.borderRadius = 16,
    this.fontSize = 18,  this.top=9,  this.bottom=9, this.right, this.left,  this.isFullWidth=true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
        padding:  EdgeInsets.only(top: top??9,right: right??10,bottom:bottom??9,left: left??10),
        backgroundColor: backgroundColor,
        minimumSize: isFullWidth??true?const  Size(double.infinity, 30): const Size (30, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: fontSize,fontWeight: FontWeight.bold),
      ),
    );
  }
}
