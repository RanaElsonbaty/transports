import 'package:flutter/material.dart';
import 'package:transports/core/theming/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.enabled,
  });
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? enabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            fontSize: 16, color: AppColors.lightBlackColor.withOpacity(.5)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        focusedBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
