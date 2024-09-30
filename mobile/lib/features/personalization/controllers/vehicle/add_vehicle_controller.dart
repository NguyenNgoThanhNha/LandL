import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/repositories/truck/truck_repository.dart';
import 'package:mobile/features/personalization/screens/vehicle/vehicle.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class AddVehicleController extends GetxController {
  static AddVehicleController get instance => Get.find();
  final truckRepository = Get.put(TruckRepository());
  GlobalKey<FormState> vehicleKey = GlobalKey<FormState>();
  int? type = 1;
  final model = TextEditingController();
  final color = TextEditingController();
  final plate = TextEditingController();
  final loadCapacity = TextEditingController();
  final width = TextEditingController();
  final height = TextEditingController();
  final length = TextEditingController();
  final name = TextEditingController();
  final engineNumber = TextEditingController();
  final frameNumber = TextEditingController();
  final manufacturer = TextEditingController();

  RxList<dynamic> listType = <dynamic>[].obs;
  final box = GetStorage();

  @override
  void onClose() {
    loadCapacity.dispose();
    model.dispose();
    color.dispose();
    plate.dispose();
    width.dispose();
    height.dispose();
    length.dispose();
    manufacturer.dispose();
    name.dispose();
    engineNumber.dispose();
    frameNumber.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    getAllType();
    super.onInit();
  }

  Future<void> getAllType() async {
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }
    final response = await TruckRepository().instance.getAllTruckType();
    if (response.success) {
      listType.value = response.result?.data;
    }
  }

  void addVehicle() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', TImages.loading);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Form validation
      if (!vehicleKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final response = await TruckRepository().instance.createTruck(
          name.text.trim(),
          plate.text.trim(),
          color.text.trim(),
          manufacturer.text.trim(),
          frameNumber.text.trim(),
          engineNumber.text.trim(),
          model.text.trim(),
          loadCapacity.text.trim(),
          int.tryParse(length.text.trim()) ?? 0,
          int.tryParse(width.text.trim()) ?? 0,
          int.tryParse(height.text.trim()) ?? 0,
          type ?? 1);
      TFullScreenLoader.stopLoading();
      if (!response.success) {
        TLoaders.errorSnackBar(
            title: 'Created Failed!', message: response.result?.message);
        return;
      }

      box.write('isUpdateVehicle', true);
      TLoaders.successSnackBar(
          title: 'Created Success', message: response.result?.message);
      Get.offAll(()=> const VehicleScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
