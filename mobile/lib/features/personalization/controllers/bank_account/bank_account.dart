import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/repositories/authentication/authentication_repository.dart';
import 'package:mobile/data/repositories/user/user_repository.dart';
import 'package:mobile/features/personalization/models/user_model.dart';
import 'package:mobile/features/personalization/screens/bank_account/bank_account.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class BankAccountController extends GetxController {
  BankAccountController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final loading = false.obs;
  final user = UserModel.empty().obs;

  final localStorage = GetStorage();
  final fullName = TextEditingController();
  final doe = TextEditingController();
  final number = TextEditingController();
  final bank = TextEditingController();
  final isHasAccount = false.obs;

  @override
  void dispose() {
    super.dispose();
    fullName.dispose();
    doe.dispose();
    number.dispose();
    bank.dispose();
  }

  @override
  void onInit() async {
    await getBankAccount();
    // TODO: implement onInit
    super.onInit();
  }

  final bankAccountFormKey = GlobalKey<FormState>();

  Future<void> createBankAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Account creating...', TImages.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!bankAccountFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      print("Loading...");

      final res = await userRepository.updateBankAccountInfo(
          fullName.text.trim(),
          bank.text.trim(),
          number.text.trim(),
          doe.text.trim());

      print("Loading 2.....");

      TFullScreenLoader.stopLoading();
      if (res.success) {
        await AuthenticationRepository.instance.checkUserFromBackend();
        TLoaders.successSnackBar(
            title: "Created success!",
            message: "You has only one account to banking");

        Get.to(() => const BankAccountScreen());
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'Create Bank Account Failed', message: res.result?.message);
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }

  Future<void> getBankAccount() async {
    try {
      loading.value = true;

      final response = await userRepository.fetchUserDetails();

      if (response != null) {
        user.value = response;
        print(user.value.stk);
        if (user.value.bank != null && user.value.stk != null) {
          isHasAccount.value = true;
          loading.value = false;
          print("here");
          return;
        }
      } else {
        isHasAccount.value = false;
      }
      isHasAccount.value = false;
      loading.value = false;
    } catch (e) {
      isHasAccount.value = false;
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }
}
