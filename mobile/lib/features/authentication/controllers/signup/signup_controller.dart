import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/features/authentication/screens/verify/verify_otp.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //variable
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final fullName = TextEditingController();
  final city = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

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
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must have to read and accept the Privacy Policy & Term of Use.');
        return;
      }

      //register user in firebase auth
      // final userCredential = await AuthenticationRepository.instance
      //     .registerWithEmailAndPassword(
      //     email.text.trim(), password.text.trim());

      //save auth user in firebase firestore
      // final newUser = UserModel(
      //     id: userCredential.user!.uid,
      //     firstName: firstName.text.trim(),
      //     lastName: lastName.text.trim(),
      //     username: username.text.trim(),
      //     email: email.text.trim(),
      //     phoneNumber: phoneNumber.text.trim(),
      //     profilePicture: '');
      //
      // final userRepository = Get.put(UserRepository());
      // userRepository.saveUserRecord(newUser);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue');

      //Move to Verify Email Screen
      Get.to(() => VerifyOtpScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
