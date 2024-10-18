import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/repositories/user/user_repository.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/loaders.dart';

class ContractController extends GetxController {
  ContractController get instance => Get.find();
  final box = GetStorage();
  final isHasIdCard = false.obs;
  final loading = false.obs;
  final isHasDriverCard = false.obs;
  final idCard = {}.obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    loadingCard();
    getInforId();
    super.onInit();
  }

  void loadingCard() {
    isHasIdCard.value = box.read("isHasIdCard") ?? false;
    isHasDriverCard.value = box.read("isHasDriverCard") ?? false;
  }

  Future<void> getInforId() async {
    try {
      loading.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {

        return;
      }
      final response = await userRepository.getIdCard();
      if (response.success) {
        idCard.value = response.result?.data;
        print(response.result?.data);
      }

      loading.value = false;
    } catch (e) {
      loading.value = false;

      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
