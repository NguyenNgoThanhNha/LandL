import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/service/models/order_model.dart';
import 'package:mobile/features/service/screens/delivery_detail/delivery_detail.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:mobile/utils/formatters/formatter.dart';

class TDeliveryPackage extends StatelessWidget {
  const TDeliveryPackage({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: TColors.accent.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const TRoundedIcon(
                  icon: Iconsax.truck_fast,
                  color: TColors.primary,
                  size: 30,
                ),
                const SizedBox(
                  width: TSizes.spacebtwItems / 2,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TLocationLine(
                        icon: Iconsax.location,
                        title: TTexts.pickupLocation,
                        iconColor: TColors.primary,
                        content: orderModel.deliveryInfoDetail.pickUpLocation,
                      ),
                      TLocationLine(
                        icon: Iconsax.level,
                        title: TTexts.deliveryLocation,
                        iconColor: Colors.green,
                        content: orderModel.deliveryInfoDetail.deliveryLocaTion,
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: TSizes.spacebtwItems / 2,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      TTexts.intendTime,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .apply(color: Colors.grey, fontWeightDelta: 500),
                    ),
                    Text(
                      TFormatter.formatDate(
                          orderModel.deliveryInfoDetail.orderDate),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                const SizedBox(
                  width: TSizes.spacebtwItems * 2,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => Get.to(() => DeliveryDetailScreen(
                              orderModel: orderModel,
                            )),
                        child: const Text('View')))
              ],
            )
          ],
        ));
  }
}
