import 'package:get/get.dart';
import 'package:mobile/utils/http/http_client.dart';

class DeliveryRepository extends GetxController{
  DeliveryRepository get instance => Get.find();


  final delivery = {}.obs;
  final deliveryLoading = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<Map<String, dynamic>?> getDeliveryByCode(String code) async{
    try {
      deliveryLoading.value = true;
      final response =
      await THttpClient.get<Map<String, dynamic>>('User/GetProfile');
      deliveryLoading.value = false;
      if (response.success) {
        print(response.result?.data);
        return response.result?.data;
      } else {
        return null;
      }
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
  Future<Map<String, dynamic>?> getAllDeliveryNear(String address, String long, String lat) async{
    try {

      final response =
      await THttpClient.post('User/GetProfile', {
        "currentLocation": address,
        "longCurrent": long,
        "latCurrent": lat
      });

      if (response.success) {
        print(response.result?.data);
        return response.result?.data;
      } else {
        return null;
      }
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}