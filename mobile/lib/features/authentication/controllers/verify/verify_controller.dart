import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/widgets/success/success_screen.dart';
import 'package:mobile/data/repositories/authentication/authentication_repository.dart';
import 'package:mobile/features/authentication/screens/login/login.dart';
import 'package:mobile/navigation_menu.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class VerifyController extends GetxController {
  static VerifyController get instance => Get.find();

  final pin1 = TextEditingController();
  final pin2 = TextEditingController();
  final pin3 = TextEditingController();
  final pin4 = TextEditingController();
  final pin5 = TextEditingController();
  final pin6 = TextEditingController();
  late String email;

  VerifyController({required this.email});

  @override
  void onClose() {
    pin1.dispose();
    pin2.dispose();
    pin3.dispose();
    pin4.dispose();
    pin5.dispose();
    pin6.dispose();
    super.onClose();
  }

  Future<void> verify() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', TImages.loading);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (pin1.text.trim() == '' ||
          pin2.text.trim() == '' ||
          pin3.text.trim() == '' ||
          pin4.text.trim() == '' ||
          pin5.text.trim() == '' ||
          pin6.text.trim() == '') {
        TFullScreenLoader.stopLoading();

        TLoaders.warningSnackBar(
            title: 'Verify code wrong!',
            message: 'Please enter code was sent to your email');
        return;
      }

      final otpCode =
          "${pin1.text.trim()}${pin2.text.trim()}${pin3.text.trim()}${pin4.text.trim()}${pin5.text.trim()}${pin6.text.trim()}";
      final response =
          await AuthenticationRepository.instance.verify(email.trim(), otpCode);

      TFullScreenLoader.stopLoading();

      if (response.success == true) {
        Get.off(() => SuccessScreen(
            image: TImages.success,
            title: 'Your account successfully created!',
            subTitle:
                'Welcome to the freight delivery app! Easily manage your deliveries with speed and efficiency, ensuring every package arrives safely and on time.',
            onPressed: () => Get.offAll(() => const LoginScreen())));
      } else {
        TLoaders.errorSnackBar(
            title: 'Verify account failed', message: response.result?.message);
        return;
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> resend() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', TImages.loading);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      final response =
          await AuthenticationRepository.instance.resend(email.trim());
      TFullScreenLoader.stopLoading();
      if (response.success == true) {
        TLoaders.successSnackBar(
            title: 'Send otp success', message: "Please check your email.");
      } else {
        TLoaders.errorSnackBar(
            title: 'Send otp code failed', message: response.result?.message);
        return;
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

// setTimerForAutoRedirect() {
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     // await FirebaseAuth.instance.currentUser?.reload();
//     // final user = FirebaseAuth.instance.currentUser;
//     if (user?.emailVerified ?? false) {
//       timer.cancel();
//       Get.off(() =>
//           SuccessScreen(image: TImages.successIllustration,
//               title: 'Your account successfully created!',
//               subTitle: 'Welcome to the freight delivery app! Easily manage your deliveries with speed and efficiency, ensuring every package arrives safely and on time.',
//               onPressed: () =>
//                   AuthenticationRepository.instance.screenRedirect()));
//     }
//   });
// }
}
