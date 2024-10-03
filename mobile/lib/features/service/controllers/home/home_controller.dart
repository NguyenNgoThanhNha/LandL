import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/data/repositories/order/order_repository.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/helpers/get_storage.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final orderRepository = Get.put(OrderRepository());

  // variable
  final box = GetStorage();
  final hideBalance = true.obs;
  final directionTo = TextEditingController();
  final isSearch = false.obs;
  final isUpdateIdCard = false.obs;
  final isUpdateVehicle = false.obs;
  final currentLocation = const LatLng(0, 0).obs;
  final currentAddress = ''.obs;
  final listOrder = [].obs;

  @override
  void onInit() {
    isSearch.value = true;
    isUpdateIdCard.value = box.read('isUpdateIdCard') ?? false;
    isUpdateVehicle.value = box.read('isUpdateVehicle') ?? false;
    currentLocation.value = getCurrentLatLngFromGetStorage() ?? LatLng(0, 0);
    currentAddress.value = getCurrentAddressFromGetStorage() ?? '';

    if (currentAddress.value.isNotEmpty) {
      directionTo.text = currentAddress.value;
    }
    print(isUpdateVehicle.value);
    print(directionTo.text);
    isSearch.value = false;

    super.onInit();
  }

  Future<void> onSearch() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Finding delivery near you...", TImages.loading);
      isSearch.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final response = await orderRepository.getAllOrder(
          directionTo.text,
          currentLocation.value.longitude.toString(),
          currentLocation.value.latitude.toString());
      TFullScreenLoader.stopLoading();
      print(">>>>>>>>>$response");
      if (response != null) {
        listOrder.value = response!;
        print(listOrder.value);
      } else {
        listOrder.value = [];
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
