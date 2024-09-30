import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/repositories/authentication/authentication_repository.dart';
import 'package:mobile/navigation_menu.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //variable
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    print(localStorage.read('email'));
    if (localStorage.read('email') != null) {

      email.text = localStorage.read('email');
    }
    super.onInit();
  } // final userController = Get.put(UserController());

  Future<void> login() async {
    try {
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final res = await AuthenticationRepository.instance
          .login(email.text.trim(), password.text.trim());
      if (res.success == true) {
        localStorage.write('token', res.result?.data['accessToken']);
        localStorage.write('refreshToken', res.result!.data?["refreshToken"]);
        localStorage.write('email', email.text.trim());
        localStorage.write('isFirstTime', false);
        await AuthenticationRepository.instance.checkUserFromBackend();
        TFullScreenLoader.stopLoading();
        Get.offAll(() => const NavigationMenu());
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'Login Failed', message: res.result?.message);
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }
}
