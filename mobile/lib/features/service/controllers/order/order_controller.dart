import 'package:get/get.dart';
import 'package:mobile/data/repositories/order/order_repository.dart';
import 'package:mobile/features/service/models/order_model.dart';
import 'package:mobile/features/service/screens/delivery_detail/delivery_detail.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class OrderController extends GetxController {
  OrderController get instance => Get.find();
  OrderRepository orderRepository = Get.put(OrderRepository());
  final status = "".obs;
  final order = {}.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> acceptOrder(String orderId, String orderDetailId) async {
    try {
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return null;
      }
      final response =
          await orderRepository.acceptOrder(orderId, orderDetailId);
      TFullScreenLoader.stopLoading();
      if (response.success) {
        print('<<<<<<<<<<<<<<<<<<<<');
        print(response.result?.data);
        order.value = response.result?.data;
        final orderRes = OrderModel.fromJson(response.result?.data);
        print("orderRes $orderRes");
        TLoaders.successSnackBar(
            title: "Accept Success!");
        Get.to(()=> DeliveryDetailScreen(orderModel: orderRes));
        // orderRepository.get
      } else {
        TLoaders.errorSnackBar(
            title: 'Accept Failed!', message: response.result?.message);
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }

  Future<void> updateOrderStatus(
      String orderDetailId, int status) async {
    try {
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return ;
      }
      final response =
          await orderRepository.updateStatusOrder(orderDetailId, status);
      TFullScreenLoader.stopLoading();
      if (response.success) {
        print('<<<<<<<<<<<<<<<<<<<<');
        print(response.result?.data);
        order.value = response.result?.data;
        final orderRes = OrderModel.fromJson(response.result?.data);
        print("orderRes $orderRes");
        TLoaders.successSnackBar(
            title: "Accept Success!", message: response.result?.message);
         Get.to(()=> DeliveryDetailScreen(orderModel: orderRes));
        // orderRepository.get
      } else {
        TLoaders.errorSnackBar(
            title: 'Accept Failed!', message: response.result?.message);
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
    return null;
  }
}
