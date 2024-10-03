import 'package:get/get.dart';
import 'package:mobile/data/repositories/order/order_repository.dart';
import 'package:mobile/features/service/models/order_model.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/loaders.dart';

class OrderTotalController extends GetxController {
  OrderTotalController get instance => Get.find();

  OrderTotalController(this.orderId);

  final loading = false.obs;
  final int orderId;
  final orderDetails = [].obs;
  OrderRepository orderRepository = Get.put(OrderRepository());

  @override
  void onInit() {
    getOrderDetail();
    super.onInit();
  }

  Future<void> getOrderDetail() async {
    try {
      loading.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      final response =
          await orderRepository.getOrderDetailByOrderId(orderId.toString());
      if (response.success) {
        if (response.result?.data == null) {
          TLoaders.warningSnackBar(
              title: 'Not found', message: response.result?.message);
          return;
        } else {
          print('>>>>>>>>>');
          print(response.result?.data);
          orderDetails.value = response.result?.data;
        }
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }
}
