import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/helpers/helper_functions.dart';

class TCamera extends StatelessWidget {
  final String title;
  final  Rx<File?> imageFile;
  final VoidCallback? onPressed;

  const TCamera({
    super.key,
    required this.title,
    required this.imageFile,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          width: THelperFunctions.screenWidth() * 0.7,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Obx(() {
            if (imageFile.value == null) {
              return TRoundedIcon(
                icon: Iconsax.camera,
                onPressed: onPressed,  // Gọi hàm chụp ảnh
              );
            } else {
              return Image.file(imageFile.value!);
            }
          }),
        ),
        const SizedBox(
          height: TSizes.spacebtwSections,
        ),
        Text(title)
      ],
    );
  }
}
