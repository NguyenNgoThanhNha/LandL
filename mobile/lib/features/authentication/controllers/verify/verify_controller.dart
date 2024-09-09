import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/navigation_menu.dart';

class VerifyController extends GetxController {
  static VerifyController get instance => Get.find();

  final pin1 = TextEditingController();
  final pin2 = TextEditingController();
  final pin3 = TextEditingController();
  final pin4 = TextEditingController();
  final pin5 = TextEditingController();
  final pin6 = TextEditingController();

  Future<void> verify() async {
    Get.offAll(() => const NavigationMenu());
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
