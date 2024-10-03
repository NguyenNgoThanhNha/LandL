import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/data/repositories/order/order_repository.dart';
import 'package:mobile/features/service/models/order_driver_model.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/loaders.dart';

class ManageDeliveryController extends GetxController {
  static ManageDeliveryController get instance => Get.find();
  final orderRepository = Get.put(OrderRepository());
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  final listOrder = [].obs;
  final listProcessingOrder = <OrderTotalModel>[].obs;
  final listCompletedOrder = <OrderTotalModel>[].obs;
  final listCancelOrder = <OrderTotalModel>[].obs;
  final loading = false.obs;

  @override
  void onInit() {
    getAllMyOrder();
    super.onInit();
  }

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void getAllMyOrder() async {
    try {
      loading.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      final response = await orderRepository.getAllMyOrder();

      print('>>>>>>>>>>>>>>>>>');
      if (response.success) {
        if (response.result?.data == null) {
          TLoaders.warningSnackBar(
              title: 'Not found', message: response.result?.message);
        } else {
          listOrder.value = response.result?.data;
          print('>>>>>>>>>>>>>>>>>');
          print(listOrder.value);
          final list = listOrder.value
              .map((json) => OrderTotalModel.fromJson(json))
              .toList();
          print('looafing...');
          if (list
              .where((order) => order.status != "Completed" && order.status != "Canceled")
              .toList()
              .isNotEmpty) {
            print('111111111');
            listProcessingOrder.value =
                list.where((order) =>order.status != "Completed" && order.status != "Canceled").toList();
          }
          if (list
              .where((order) => order.status == "Completed")
              .toList()
              .isNotEmpty) {
            print('2222222222');
            listCompletedOrder.value =
                list.where((order) => order.status == "Completed").toList();
          }
          if (list
              .where((order) => order.status == "Canceled")
              .toList()
              .isNotEmpty) {
            print('3333333333');
            listCancelOrder.value =
                list.where((order) => order.status == "Canceled").toList();
          }
        }
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
