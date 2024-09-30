import 'package:get/get.dart';
import 'package:mobile/features/service/models/order_model.dart';
import 'package:mobile/utils/http/http_client.dart';

class OrderDelivery extends GetxController {
  OrderDelivery get instance => Get.find();

  final delivery = {}.obs;
  final deliveryLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<List<OrderModel>?> getAllOrder() async {
    try {
      final response =
          await THttpClient.get<Map<String, dynamic>>('Order/GetAll');

      if (response.success) {
        List<dynamic> jsonList = response.result?.data as List<dynamic>;
        List<OrderModel> orderList = jsonList
            .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return orderList;
      } else {
        return null;
      }
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<OrderModel?> getOrderDetailByOrderId(String orderId) async {
    try {
      final response = await THttpClient.get(
          "Order/GetOrderDetailByOrderId?orderId=$orderId");
      if (response.success){
        return OrderModel.fromJson(response.result?.data);
      }
      return null;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
