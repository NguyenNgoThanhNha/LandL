import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/features/personalization/models/user_model.dart';
import 'package:mobile/utils/http/http_client.dart';
import 'package:mobile/utils/http/response_props.dart';
import 'package:mobile/utils/http/upload_image.dart';

class UserRepository extends GetxController {
  UserRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel(
          userName: '', password: '', email: '', city: '', phoneNumber: '')
      .obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<UserModel?> fetchUserDetails() async {
    try {
      profileLoading.value = true;
      final response =
          await THttpClient.get<Map<String, dynamic>>('User/GetProfile');
      profileLoading.value = false;
      if (response.success) {
        return UserModel.fromJson(
            response.result?.data as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> uploadImageIdCard() async {
    try {} catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<ResponseProps> getIdCard() async {
    try {
      final res = await THttpClient.get('IdentityCard/GetIdentityCard');
      return res;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<ResponseProps> getLicenseCard() async {
    try {
      final res = await THttpClient.get('LicenseDriver/GetLicenseDriver');
      return res;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<ResponseProps> updateBankAccountInfo(
      String fullName, String bank, String accountNumber, String doe) async {
    try {
      final email = deviceStorage.read('email');
      print(email);
      final response = await THttpUpload.patchData('User/UpdateInfo?email=$email', {
        "fullName": fullName,
        "stk": accountNumber,
        "bank": bank,
        "expireDate": doe
      });
     return response;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
