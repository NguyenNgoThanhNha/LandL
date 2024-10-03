import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/service/controllers/order/order_controller.dart';
import 'package:mobile/features/service/models/order_model.dart';
import 'package:mobile/features/service/screens/map/map_goong.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:mobile/utils/formatters/formatter.dart';

class DeliveryDetailScreen extends StatelessWidget {
  const DeliveryDetailScreen({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());

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
            child: Column(
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
                          orderModel.productInfo.productName != null
                              ? orderModel.productInfo.productName!
                              : "Updating...",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          orderModel.productInfo.totalDismension.trim() != ''
                              ? "${orderModel.productInfo.totalDismension} m"
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
                      content: orderModel.orderDetailCode != null
                          ? orderModel.orderDetailCode.toString()
                          : 'Updating...',
                      backgroundColor: TColors.accent.withOpacity(0.3),
                    ),
                    const SizedBox(
                      width: TSizes.spacebtwItems,
                    ),
                    TDeliveryInfoItem(
                      title: TTexts.intendTime,
                      content: TFormatter.formatDate(
                          orderModel.deliveryInfoDetail.orderDate),
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
                      content: orderModel.deliveryInfoDetail.pickUpLocation,
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
                      content: orderModel.deliveryInfoDetail.deliveryLocaTion,
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
                      content: orderModel.productInfo.typeProduct ?? "",
                      crossAxisAlignment: CrossAxisAlignment.start,
                      padding: const EdgeInsets.all(TSizes.sm),
                    ),
                    const SizedBox(
                      width: TSizes.spacebtwItems,
                    ),
                    TDeliveryInfoItem(
                      title: TTexts.totalWeight,
                      content: "${orderModel.productInfo.weight} kg",
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
                      content: orderModel.deliveryInfoDetail.senderPhone ?? "",
                      crossAxisAlignment: CrossAxisAlignment.start,
                      padding: const EdgeInsets.all(TSizes.sm),
                    ),
                    const SizedBox(
                      width: TSizes.spacebtwItems,
                    ),
                    TDeliveryInfoItem(
                      title: 'Status',
                      content: orderModel.status,
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
                          Text(TFormatter.formatCurrency(orderModel.totalPrice),
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
                        onPressed: () => Get.to(() => MapGoongScreen(
                              orderModel: orderModel,
                            )),
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
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.10,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: TColors.primaryBackground,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TActionOnOrder(
                            orderController: orderController,
                            orderModel: orderModel),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ]));
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
