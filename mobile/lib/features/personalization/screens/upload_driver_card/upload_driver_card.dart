import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/camera/camera.dart';
import 'package:mobile/features/personalization/controllers/upload_driver/upload_driver_card_controller.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
class UploadDriverCardScreen extends StatelessWidget {
  const UploadDriverCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadDriverCardController());

    return Scaffold(
      appBar:const TAppbar(
        showBackArrow: true,
        title: Text(TTexts.licenceCardsTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(children: [
          TCamera(
            title: "Upload Card Front",
            imageFile: controller.imageFront,
            onPressed: () => controller.uploadFrontImage(),
          ),
          const SizedBox(height: TSizes.defaultSpace),
          TCamera(
            title: "Upload Card Back",
            imageFile: controller.imageBack,
            onPressed: () => controller.uploadBackImage(),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.uploadImageIdCard(),
              child: const Text('Submit'),
            ),
          )
        ]),
      ),
    );
  }
}
