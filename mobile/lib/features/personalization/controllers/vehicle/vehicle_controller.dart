import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/repositories/truck/truck_repository.dart';
import 'package:mobile/features/service/models/truck_model.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class VehicleController extends GetxController {
  VehicleController get instance => Get.find();
  final truck = Rxn<TruckModel>();
  final box = GetStorage();
  final truckRepository = Get.put(TruckRepository());

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTrucks();
      loadUpdateStatus();
    });
    super.onInit();
  }

  void loadUpdateStatus() {
    if (truck.value != null) {
      box.write('isUpdateVehicle', true);
    } else {
      box.write('isUpdateVehicle', false);
    }
  }

  void getTrucks() async {
    try {
      TFullScreenLoader.openLoadingDialog('Loading trucks...', TImages.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final response = await truckRepository.getAllTruck();
      truck.value = response;
      TFullScreenLoader.stopLoading();
      box.write('isUpdateVehicle', true);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }
}
