import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ContractController extends GetxController {
  ContractController get instance => Get.find();
  final box = GetStorage();
  final isHasIdCard = false.obs;
  final isHasDriverCard = false.obs;

  @override
  void onInit() {
    loadingCard();
    super.onInit();
  }

  void loadingCard() {
    isHasIdCard.value = box.read("isHasIdCard") ?? false;
    isHasDriverCard.value = box.read("isHasDriverCard")?? false;
  }
}
