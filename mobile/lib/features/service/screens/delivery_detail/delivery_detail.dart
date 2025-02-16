import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/service/controllers/order/order_controller.dart';
import 'package:mobile/features/service/models/order_model.dart';
import 'package:mobile/features/service/screens/map/map_goong.dart';
import 'package:mobile/features/service/screens/map/map_navigation.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:mobile/utils/formatters/formatter.dart';

class DeliveryDetailScreen extends StatelessWidget {
  const DeliveryDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController(id: id));

    return Scaffold(
        appBar: TAppbar(
          showBackArrow: true,
          title: Text(
            TTexts.deliveryDetail,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Obx(() {
              if (orderController.loading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: TColors.primary,
                  ),
                );
              }
              if (orderController.order.value.orderDetailId == 0) {
                return const Center(
                  child: Text('No data for this order'),
                );
              }
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TRoundedIcon(
                        icon: Iconsax.box,
                        color: TColors.primary,
                        backgroundColor: TColors.accent.withOpacity(0.6),
                        width: 65,
                        height: 65,
                        size: 40,
                        borderRadius: TSizes.spacebtwItems,
                      ),
                      const SizedBox(
                        width: TSizes.sm,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderController
                                        .order.value.productInfo.productName !=
                                    null
                                ? orderController
                                    .order.value.productInfo.productName!
                                : "Updating...",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            orderController
                                        .order.value.productInfo.totalDismension
                                        .trim() !=
                                    ''
                                ? "${orderController.order.value.productInfo.totalDismension} m"
                                : "Updating...",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(overflow: TextOverflow.ellipsis),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spacebtwSections,
                  ),
                  Row(
                    children: [
                      TDeliveryInfoItem(
                        title: TTexts.codeDelivery,
                        content:
                            orderController.order.value.orderDetailCode != null
                                ? orderController.order.value.orderDetailCode
                                    .toString()
                                : 'Updating...',
                        backgroundColor: TColors.accent.withOpacity(0.3),
                      ),
                      const SizedBox(
                        width: TSizes.spacebtwItems,
                      ),
                      TDeliveryInfoItem(
                        title: TTexts.intendTime,
                        content: TFormatter.formatDate(orderController
                            .order.value.deliveryInfoDetail.orderDate),
                        backgroundColor: TColors.accent.withOpacity(0.3),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spacebtwSections,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TLocationLine(
                        icon: Iconsax.location,
                        title: TTexts.pickupLocation,
                        iconColor: TColors.primary,
                        content: orderController
                            .order.value.deliveryInfoDetail.pickUpLocation,
                      ),
                      Transform.rotate(
                        angle: 90 * 3.1415927 / 180,
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: TSizes.sm * 1.2),
                          child: Icon(
                            Iconsax.more,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      TLocationLine(
                        icon: Iconsax.level,
                        title: TTexts.deliveryLocation,
                        iconColor: Colors.green,
                        content: orderController
                            .order.value.deliveryInfoDetail.deliveryLocaTion,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TDeliveryInfoItem(
                        title: TTexts.typePackage,
                        content: orderController
                                .order.value.productInfo.typeProduct ??
                            "",
                        crossAxisAlignment: CrossAxisAlignment.start,
                        padding: const EdgeInsets.all(TSizes.sm),
                      ),
                      const SizedBox(
                        width: TSizes.spacebtwItems,
                      ),
                      TDeliveryInfoItem(
                        title: TTexts.totalWeight,
                        content:
                            "${orderController.order.value.productInfo.weight} kg",
                        crossAxisAlignment: CrossAxisAlignment.start,
                        padding: EdgeInsets.all(TSizes.sm),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  Row(
                    children: [
                      TDeliveryInfoItem(
                        title: TTexts.senderContact,
                        content: orderController
                                .order.value.deliveryInfoDetail.senderPhone ??
                            "",
                        crossAxisAlignment: CrossAxisAlignment.start,
                        padding: const EdgeInsets.all(TSizes.sm),
                      ),
                      const SizedBox(
                        width: TSizes.spacebtwItems,
                      ),
                      TDeliveryInfoItem(
                        title: 'Status',
                        content: orderController.order.value.status,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        padding: const EdgeInsets.all(TSizes.sm),
                      )
                    ],
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: TRoundedContainer(
                        padding: const EdgeInsets.all(TSizes.sm),
                        backgroundColor: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fee',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      color: Colors.grey, fontWeightDelta: 500),
                            ),
                            Text(
                                TFormatter.formatCurrency(
                                    orderController.order.value.totalPrice),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                        fontSizeFactor: 1.5,
                                        fontWeightDelta: 700,
                                        color: TColors.primary)),
                          ],
                        ),
                      )),
                      TextButton(
                          onPressed: () => Get.to(() => 
                              // MapGoongScreen(
                              //   id: orderController.order.value.orderDetailId,
                              // )
                            MapGoongScreen(id: orderController.order.value.orderDetailId)
                          ),
                          child: const Text(
                            TTexts.viewMap,
                            style: TextStyle(
                              fontSize: 17,
                              color: TColors.primary,
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spacebtwItems * 6,
                  ),
                ],
              );
            }),
          ),
          Obx(() {
            if (orderController.order.value.orderDetailId != 0) {
              return DraggableScrollableSheet(
                initialChildSize: 0.15,
                minChildSize: 0.10,
                maxChildSize: 0.8,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: TColors.primaryBackground,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TActionOnOrder(
                                orderController: orderController,
                                orderModel: orderController.order.value),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          })
        ]));
  }
}

class TActionOnOrder extends StatelessWidget {
  const TActionOnOrder({
    super.key,
    required this.orderController,
    required this.orderModel,
  });

  final OrderController orderController;
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    if (orderModel.status == "Processing") {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: TColors.white),
              onPressed: () => Get.back(),
              child: const Text(
                TTexts.reject,
              ),
            ),
          ),
          const SizedBox(
            width: TSizes.spacebtwItems,
          ),
          Expanded(
              child: ElevatedButton(
            onPressed: () => orderController.acceptOrder(
                orderModel.orderId.toString(),
                orderModel.orderDetailId.toString()),
            child: const Text(
              TTexts.accept,
            ),
          ))
        ],
      );
    }
    if (orderModel.status == "Paid") {
      return Column(
        children: [
          Text(
            'You are on your way to pick up the goods',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: TSizes.spacebtwItems,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => orderController.updateOrderStatus(
                      orderModel.orderDetailId.toString(), 4),
                  child: const Text(
                    'On Route',
                  ),
                ),
              )
            ],
          )
        ],
      );
    }
    if (orderModel.status == "InRoute") {
      return Column(
        children: [
          Text(
            'You already received a package!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: TSizes.spacebtwItems,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => orderController.updateOrderStatus(
                      orderModel.orderDetailId.toString(), 5),
                  child: const Text(
                    'Start Delivery',
                  ),
                ),
              )
            ],
          )
        ],
      );
    }
    if (orderModel.status == "Received") {
      return Column(
        children: [
          Text(
            'You already take package for receiver!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: TSizes.spacebtwItems,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => orderController.updateOrderStatus(
                      orderModel.orderDetailId.toString(), 6),
                  child: const Text(
                    'Finish Delivery',
                  ),
                ),
              )
            ],
          )
        ],
      );
    }
    if (orderModel.status == "Delivered") {
      return Column(
        children: [
          Text(
            'Successfully!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: TSizes.spacebtwItems,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => orderController.updateOrderStatus(
                      orderModel.orderDetailId.toString(), 7),
                  child: const Text(
                    'Completed Order',
                  ),
                ),
              )
            ],
          )
        ],
      );
    }
    if (orderModel.status == "Completed") {
      return Column(
        children: [
          Text(
            'You already done!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      );
    }
    if (orderModel.status == "InProcess") {
      return Column(
        children: [
          Text(
            'Waiting customer paying!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      );
    }
    return const SizedBox();
  }
}

class TDeliveryInfoItem extends StatelessWidget {
  const TDeliveryInfoItem({
    super.key,
    this.backgroundColor = Colors.transparent,
    required this.title,
    required this.content,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = const EdgeInsets.symmetric(vertical: TSizes.sm),
  });

  final Color backgroundColor;
  final String title, content;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TRoundedContainer(
      padding: padding,
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .apply(color: Colors.grey, fontWeightDelta: 500),
          ),
          Text(content,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(fontSizeFactor: 1.25)),
        ],
      ),
    ));
  }
}

class TLocationLine extends StatelessWidget {
  const TLocationLine({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.content,
  });

  final IconData icon;
  final Color iconColor;
  final String title, content;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TRoundedIcon(
          icon: icon,
          color: iconColor,
          backgroundColor: Colors.transparent,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(color: Colors.grey, fontWeightDelta: 500),
              ),
              const SizedBox(
                height: TSizes.sm / 2,
              ),
              Text(
                content,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        )
      ],
    );
  }
}
