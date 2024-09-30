import 'dart:math';

import 'package:get/get.dart';
import 'package:mobile/data/repositories/truck/truck_repository.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class VehicleDetailController extends GetxController {
  VehicleDetailController get instance => Get.find();
  final truckRepository = TruckRepository().instance;
  RxList<dynamic> listType = <dynamic>[].obs;

  @override
  void onInit() {
    getAllType();
    super.onInit();
  }

  Future<void> updateTruck() async {
    TLoaders.warningSnackBar(title: 'Feature is being updated!');
  }

  Future<void> deleteTruck() async {
    TLoaders.warningSnackBar(title: 'Feature is being updated!');
  }

  String getTypeName(int id) {
    print(id);
    final rs = listType.value
        .firstWhere((item) => item['vehicleTypeId'] == id, orElse: () => null);
    return rs != null ? rs['vehicleTypeName'] : '';
  }

  Future<void> getAllType() async {
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }
    final response = await truckRepository.getAllTruckType();
    if (response.success) {
      listType.value = response.result?.data;
    }
  }
}
