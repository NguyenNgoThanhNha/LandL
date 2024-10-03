import 'package:get/get.dart';
import 'package:mobile/utils/http/http_client.dart';
import 'package:mobile/utils/http/response_props.dart';
import 'package:mobile/utils/popups/loaders.dart';

class OrderRepository extends GetxController {
  OrderRepository get instance => Get.find();

  final delivery = {}.obs;
  final deliveryLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<List<dynamic>?> getAllOrder(
      String address, String long, String lat) async {
    try {
      final response = await THttpClient.post('Order/GetOrderDriver',
          {"currentLocation": address, "longCurrent": long, "latCurrent": lat});

      if (response.success) {
        if (response.result?.data == null) {
          TLoaders.warningSnackBar(
              title: 'Not matching any delivery',
              message: response.result?.message);
          return null;
        }

        return response.result?.data;
      } else {
        return null;
      }
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }


  Future<ResponseProps> acceptOrder(
      String orderId, String orderDetailId) async {
    try {
      final response = await THttpClient.post("Order/accept-driver",
          {"orderId": orderId, "orderDetailId": orderDetailId});

      return response;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<ResponseProps> getAllMyOrder() async {
    try {
      final response = await THttpClient.get('Order/GetOrderByUserId');
      return response;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<ResponseProps> getOrderDetailByOrderId(String id) async {
    try {
      final response =
          await THttpClient.get('Order/GetOrderDetailByOrderId?orderId=$id');
      return response;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<ResponseProps> updateStatusOrder(String id, int status) async {
    try {
      final response =
          await THttpClient.put('Order/Update-Status-OrderDetail/$id', status);
      return response;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
