import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/utils/http/http_client.dart';

class UserRepository extends GetxController {
  UserRepository get instance => Get.find();

  final deviceStorage = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    try {
      THttpClient.post('login', {email, password});
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}
