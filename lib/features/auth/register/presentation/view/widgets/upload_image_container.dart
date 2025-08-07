import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';

class ImageUploadBox extends StatelessWidget {
  final String label;
  final File? image;
  final VoidCallback onTap;

  const ImageUploadBox({
    super.key,
    required this.label,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: AppColors.primaryColor,
          strokeWidth: 2,
          dashPattern: List.filled(5, 4), radius: Radius.circular(12),
        ),
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: image != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(image!, fit: BoxFit.cover),
          )
              : Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.gallery,height: 24,width: 24,color: AppColors.primaryColor,),
                  SizedBox(height: 8,),
                  Text(label, textAlign: TextAlign.center,style: TextStyles.font14Black500Weight,),
                ],
              )),
        ),
      ),
    );
  }
}
