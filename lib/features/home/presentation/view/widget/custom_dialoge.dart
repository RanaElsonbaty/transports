
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/upload_image.dart';
import 'package:transports/features/home/presentation/view/widget/custom_Button.dart';
import 'package:transports/features/home/presentation/view/widget/custom_outline.dart';

class CustomDialog  extends StatelessWidget{
const CustomDialog({super.key, required this.title, required this.content, required this.onOkPressed,  this.textButton,});
 final String title;
  final Widget content;
  final VoidCallback onOkPressed;
final String ?textButton;
  @override
  Widget build(BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 5),
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(child: Text(title,))),
          ),
          content: content,
          actions: [
           Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
   Expanded(
          child: CustomOutLineButton(        
       title: 'cancel_button'.tr(), onPressed: () { (context).pop(); }, radius: 8, verticalPadding: 5, 
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CustomButton(
            borderRadius: 10,
            text: textButton??"",
            onPressed: onOkPressed,
            backgroundColor: AppColors.primaryColor,
          ),
        ),   
      ],
    ),
          ],
        );
  }
}

