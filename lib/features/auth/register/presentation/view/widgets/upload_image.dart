import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/upload_image_container.dart';
class UploadPhotosView extends StatefulWidget {
  const UploadPhotosView({super.key, required this.onImagesSelected});
  final void Function(File? stampImage, File? logoImage) onImagesSelected;

  @override
  State<UploadPhotosView> createState() => _UploadPhotosViewState();
}

class _UploadPhotosViewState extends State<UploadPhotosView> {
  File? stampImage;
  File? boardImage;

  final picker = ImagePicker();

  Future<void> pickImage(bool isStamp) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isStamp) {
          stampImage = File(pickedFile.path);
        } else {
          boardImage = File(pickedFile.path);
        }
      });
            widget.onImagesSelected(stampImage, boardImage);

    }
  }



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ImageUploadBox(
          label: 'upload_stamp'.tr(),
          image: stampImage,
          onTap: () => pickImage(true),
        ),
        ImageUploadBox(
          label: 'upload_logo'.tr(),
          image: boardImage,
          onTap: () => pickImage(false),
        ),
      ],
    );
  }
}
