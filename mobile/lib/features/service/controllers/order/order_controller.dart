import 'package:get/get.dart';
import 'package:mobile/data/repositories/order/order_repository.dart';
import 'package:mobile/features/service/models/order_model.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class OrderController extends GetxController {
  OrderController get instance => Get.find();
  OrderRepository orderRepository = Get.put(OrderRepository());
  final loading = false.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  final int id;

  OrderController({required this.id});

  @override
  void onInit() async {
    super.onInit();
    await getData();
  }

  Future<void> getData() async {
    try {
      loading.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(title: 'Network Error', message: 'Please check your internet connection.');
        loading.value = false;
        return;
      }
      final response = await orderRepository.getData(id);
      if (response != null) {
        order.value = response;
        update();
        loading.value = false;
        print(response.orderDetailId);
        print(order.value);
      }
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }

  Future<void> acceptOrder(String orderId, String orderDetailId) async {
    try {
      loading.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
      }
      final response =
          await orderRepository.acceptOrder(orderId, orderDetailId);
      loading.value = false;
      if (response.success) {
        order.value = OrderModel.fromJson(response.result?.data);

        TLoaders.successSnackBar(title: "Accept Success!", message: "Order status update success!");

        // Get.to(() => DeliveryDetailScreen(orderModel: orderRes));
      } else {
        TLoaders.errorSnackBar(
            title: 'Accept Failed!', message: response.result?.message);
      }
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }

  Future<void> updateOrderStatus(String orderDetailId, int status) async {
    try {
      loading.value = false;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      final response =
          await orderRepository.updateStatusOrder(orderDetailId, status);
      loading.value = false;
      if (response.success) {
        order.value = OrderModel.fromJson(response.result?.data);

        TLoaders.successSnackBar(title: "Update Success!", message: "Order status update success!");
        // Get.to(() => DeliveryDetailScreen(orderModel: orderRes));
      } else {
        TLoaders.errorSnackBar(
            title: 'Accept Failed!', message: response.result?.message);
      }
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }
}
