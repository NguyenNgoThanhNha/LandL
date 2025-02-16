import 'package:get/get.dart';
import 'package:mobile/utils/http/http_client.dart';
import 'package:mobile/utils/http/response_props.dart';

class TransactionRepository extends GetxController {
  TransactionRepository get instance => Get.find();

  Future<ResponseProps> requestTransaction(
      String amount, String description) async {
    try {
      return await THttpClient.post('User/withdraw-request',
          {"amount": amount, "description": description, "note": ""});
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
