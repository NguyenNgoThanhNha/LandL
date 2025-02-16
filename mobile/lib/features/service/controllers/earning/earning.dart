import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/data/repositories/authentication/authentication_repository.dart';
import 'package:mobile/data/repositories/transaction/transaction_repository.dart';
import 'package:mobile/features/service/screens/earnings/earnings.dart';
import 'package:mobile/utils/formatters/input_money.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class EarningController extends GetxController {
  EarningController get instance => Get.find();
  final quantity = MoneyInputController();

  final TransactionRepository transactionRepository =
      Get.put(TransactionRepository());
  final loading = false.obs;
  final description = TextEditingController();

  @override
  void dispose() {
    quantity.dispose();
    super.dispose();
  }

  Future<void> requestWithDraw() async {
    try {
      loading.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      print( quantity.text.trim().replaceAll(".", ""));
      final response = await transactionRepository.requestTransaction(
          quantity.text.trim().replaceAll(".", ""), description.text.trim());

      if (response.success) {
        TLoaders.successSnackBar(
            title: "Request success", message: response.result?.message ?? "");
        await AuthenticationRepository.instance.checkUserFromBackend();
      } else {
        TLoaders.errorSnackBar(
            title: 'Request failed', message: response.result?.message ?? "");
      }

      print(response);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }
}
