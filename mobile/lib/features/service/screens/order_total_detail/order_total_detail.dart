import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/features/service/controllers/order_total/order_total_controller.dart';
import 'package:mobile/features/service/models/order_model.dart';
import 'package:mobile/features/service/screens/home/widgets/delivery_package.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';

class OrderTotalDetailScreen extends StatelessWidget {
  const OrderTotalDetailScreen({super.key, required this.orderId});

  final int orderId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderTotalController(orderId));
    return Scaffold(
      appBar: TAppbar(
        title: Text('Order Details',
            style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(() {
          if (controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: TColors.primary,
              ),
            );
          }
          if (controller.orderDetails.value.isEmpty) {
            return const Text('No Delivery Suitable');
          }
          return ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.orderDetails.value.length,
            itemBuilder: (context, index) {
              final order =
                  OrderModel.fromJson(controller.orderDetails.value[index]);
              return TDeliveryPackage(
                orderModel: order,
              );
            },
          );
        }),
      ),
    );
  }
}
