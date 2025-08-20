
import 'package:flutter/material.dart';
import 'package:transports/core/theming/colors.dart';

class CustomOutLineButton extends StatelessWidget {
  const CustomOutLineButton({super.key, required this.onPressed, required this.title, required this.radius, required this.verticalPadding,  });
final void Function() onPressed;
final String title;
final double radius;
final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed:onPressed,
      style: OutlinedButton.styleFrom(
        padding:  EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 16),
        side: const BorderSide(
          color: AppColors.primaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child:  FittedBox(
          fit: BoxFit.scaleDown,
        child: Text(
                  textAlign: TextAlign.end,
        
                title,
        ),
      ),
    );
  }
}
