import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/utils/http/http_client.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print("11111111111111111");
      return await THttpClient.post(
          'Auth/login', {"email": email, "password": password});
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    try {
      return THttpClient.post('Auth/FirstStep', {email, password});
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}
