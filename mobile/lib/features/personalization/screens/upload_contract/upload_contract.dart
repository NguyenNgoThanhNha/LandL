import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/camera/camera.dart';
import 'package:mobile/features/personalization/controllers/upload_contract/upload_contract_controller.dart';
import 'package:mobile/utils/constants/sizes.dart';

class UploadContractScreen extends StatelessWidget {
  const UploadContractScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadContractController());

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(title),
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
