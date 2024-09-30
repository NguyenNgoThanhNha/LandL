import 'package:get/get.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class DeliveryDetailController extends GetxController{
  DeliveryDetailController get instance => Get.find();

  final delivery = {};

  @override
  void onInit() {

    getDeliveryInfo();
    super.onInit();
  }

  Future<void> getDeliveryInfo () async {
    try {
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }



      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }

}