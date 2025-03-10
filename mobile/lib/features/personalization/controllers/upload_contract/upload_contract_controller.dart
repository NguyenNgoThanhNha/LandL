import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/features/personalization/screens/contract/contract.dart';
import 'package:mobile/features/personalization/screens/driver_card/driver_card_screen.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/http/scan_image.dart';
import 'package:mobile/utils/http/upload_image.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class UploadContractController extends GetxController {
  UploadContractController get instance => Get.find();
  final box = GetStorage();
  final imageFront = Rx<File?>(null);
  final imageBack = Rx<File?>(null);
  final imageFrontUploading = false.obs;
  final imageBackUploading = false.obs;

  Future<void> uploadFrontImage() async {
    await _pickAndUploadImage(imageFront, imageFrontUploading, true);
  }

  Future<void> uploadBackImage() async {
    await _pickAndUploadImage(imageBack, imageBackUploading, false);
  }

  Future<void> _pickAndUploadImage(
      Rx<File?> imageRx, RxBool uploadingStatus, bool isFront) async {
    try {
      final pickedImage = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 300,
          maxWidth: 400);

      if (pickedImage != null) {
        imageRx.value = File(pickedImage.path);
        TFullScreenLoader.openLoadingDialog(
            "Uploading information...", TImages.loading);
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          TFullScreenLoader.stopLoading();
          return;
        }
        final response = await THttpScan.scanIdCard(imageRx.value!);
        if (response?['errorCode'] != 0){
          imageRx.value = null;
          TFullScreenLoader.stopLoading();
          TLoaders.warningSnackBar(title: 'Image wrong',message: "Please upload other front image!");
          return;
        }
        if (isFront && response?['data'][0]['features'] != null){
          imageRx.value = null;
          TFullScreenLoader.stopLoading();
          TLoaders.warningSnackBar(title: 'Image wrong',message: "Please upload other front image!");
          return;
        }
        if (!isFront && response?['data'][0]['id'] != null){
          imageRx.value = null;
          TFullScreenLoader.stopLoading();
          TLoaders.warningSnackBar(title: 'Image wrong',message: "Please upload other back image!");
          return;
        }

        final result = await THttpUpload.patchData(
            'IdentityCard/UpdateIdentityCard', response?['data'][0]);
        TFullScreenLoader.stopLoading();
        if (!result.success) {
          imageRx.value = null;
          TLoaders.errorSnackBar(
              title: 'Upload Failed!', message: 'Please upload again!');
        } else {
          TLoaders.successSnackBar(title: 'Upload success', message: 'You can not change it later!');
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> uploadImageIdCard() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Uploading your id card", TImages.loading);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (imageFront.value == null || imageBack.value == null) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'Oh Snap!', message: 'Please update image again!');
        return;
      } else {
        if (imageFront.value!.existsSync() && imageBack.value!.existsSync()) {
          final frontImageBytes = await imageFront.value?.readAsBytes();
          final backImageBytes = await imageBack.value?.readAsBytes();

          if (!(frontImageBytes?[0] == 0x89 && frontImageBytes?[1] == 0x50) && // PNG header
              !(frontImageBytes?[0] == 0xFF && frontImageBytes?[1] == 0xD8)) { // JPEG header
            throw Exception("File is not in PNG or JPEG format.");
          }
          print('OK');
          if (!(backImageBytes?[0] == 0x89 && backImageBytes?[1] == 0x50) && // PNG header
              !(backImageBytes?[0] == 0xFF && backImageBytes?[1] == 0xD8)) { // JPEG header
            throw Exception("File is not in PNG or JPEG format.");
          }
          print('OK');

        }
        final response = await THttpUpload.patch(
            'IdentityCard/UpdateIdentityCard',
            imageFront.value!,
            imageBack.value!);
        TFullScreenLoader.stopLoading();
        if (!response.success) {
          TLoaders.errorSnackBar(title: 'Upload Failed', message: response.result?.message);
          return;
        } else {
          TLoaders.successSnackBar(title: 'Upload success', message: "Your information will be protected.");
          box.write('isHasIdCard', true);
          Get.to(()=> const DriverCardScreen());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void updateLicenceCard() {
    TLoaders.warningSnackBar(title: 'Feature is being updated!');
  }
}
