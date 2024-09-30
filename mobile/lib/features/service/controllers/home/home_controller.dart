import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  // variable
  final box = GetStorage();
  final hideBalance = true.obs;
  final directionTo = TextEditingController();
  final isSearch = false.obs;
  final isUpdateIdCard = false.obs;
  final isUpdateVehicle = false.obs;


  @override
  void onInit() {
    onLoadData();
    print(isUpdateVehicle.value);
    super.onInit();
  }

  Future<void> onSearch() async {
    try {
      isSearch.value = true;
    } catch (e) {}
  }
  void onLoadData () {
    isUpdateIdCard.value = box.read('isUpdateIdCard');
    isUpdateVehicle.value = box.read('isUpdateVehicle');
  }
}
