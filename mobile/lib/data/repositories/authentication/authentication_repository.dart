import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/repositories/user/user_repository.dart';
import 'package:mobile/features/authentication/screens/login/login.dart';
import 'package:mobile/features/authentication/screens/onboarding/onboarding.dart';
import 'package:mobile/navigation_menu.dart';
import 'package:mobile/utils/http/http_client.dart';
import 'package:mobile/utils/http/response_props.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final deviceStorage = GetStorage();

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    checkIsFirstTime();
  }

  checkIsFirstTime() async {
    //local storage
    deviceStorage.writeIfNull('isFirstTime', true);
    if (deviceStorage.read('isFirstTime') == true) {
      Get.offAll(() => const OnboardingScreen());
    } else {
      checkUserFromBackend();
    }
  }

  Future<ResponseProps> login(String email, String password) async {
    try {
      return await THttpClient.post(
          'Auth/login-mobile', {"email": email, "password": password});
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<ResponseProps<void>> signUp(String email, String password,
      String fullName, String phone, String city) async {
    try {
      return THttpClient.post<void>('Auth/FirstStep', {
        "email": email,
        "password": password,
        "userName": fullName,
        "phone": phone,
        "typeAccount": "Driver",
        "city": city
      });
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<void> logout() async {
    try {
      deviceStorage.remove('token');
      deviceStorage.remove('refreshToken');
      Get.to(() => const LoginScreen());
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<ResponseProps<void>> verify(String email, String otp) async {
    try {
      return await THttpClient.post<void>(
          'Auth/SubmitOTP', {"email": email, "otp": otp});
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<ResponseProps<void>> resend(String email) async {
    try {
      return await THttpClient.post<void>('Auth/Resend-Otp?email=$email', {});
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<void> checkUserFromBackend() async {
    final token = deviceStorage.read('token');
    if (token != null) {
      final userRepository = Get.put(UserRepository());
      final user = await userRepository.instance.fetchUserDetails();
      print(user);

      if (user != null) {
        deviceStorage.write('username', user.userName);
        deviceStorage.write('email', user.email);
        deviceStorage.write('avatar', user.avatar);
        deviceStorage.write('driverId', user.userId);
        deviceStorage.write('balance', user.accountBalance);
        Get.offAll(() => const NavigationMenu());
      } else {
        await logout();
      }
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }
}
