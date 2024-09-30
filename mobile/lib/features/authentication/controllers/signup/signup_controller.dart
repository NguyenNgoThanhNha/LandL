import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/data/repositories/authentication/authentication_repository.dart';
import 'package:mobile/features/authentication/screens/verify/verify_otp.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //variable
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final fullName = TextEditingController();
  final city = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final confirmPassword = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    email.dispose();
    fullName.dispose();
    city.dispose();
    password.dispose();
    phoneNumber.dispose();
    confirmPassword.dispose();
    super.onClose();
  }

  void signup() async {
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
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Privacy policy check
      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must have to read and accept the Privacy Policy & Term of Use.');
        return;
      }
      if (password.text.trim() != confirmPassword.text.trim()) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Password is mismatched',
            message:
                'In order to create account, you must have to repeat right password to confirm.');
        return;
      }

      final response = await AuthenticationRepository.instance.signUp(
          email.text.trim(),
          password.text.trim(),
          fullName.text.trim(),
          phoneNumber.text.trim(),
          city.text.trim());
      TFullScreenLoader.stopLoading();
      if (response.success == true) {
        TLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your account has been created! Verify email to continue');

        Get.to(() => VerifyOtpScreen(email: email.text.trim()));
      } else {
        TLoaders.errorSnackBar(
            title: 'Register account failed',
            message: response.result?.message);
        return;
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
