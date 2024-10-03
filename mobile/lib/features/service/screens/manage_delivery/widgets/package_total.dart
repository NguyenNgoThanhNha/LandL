import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/service/models/order_driver_model.dart';
import 'package:mobile/features/service/screens/order_total_detail/order_total_detail.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/formatters/formatter.dart';

class TPackageTotal extends StatelessWidget {
  const TPackageTotal({super.key, required this.order});

  final OrderTotalModel order;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: TColors.accent.withOpacity(0.5),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Order Code',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      color: Colors.grey, fontWeightDelta: 500),
                            ),
                            Text(
                              order.orderCode.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .apply(overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Status',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      color: Colors.grey, fontWeightDelta: 500),
                            ),
                            Text(
                              order.status,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .apply(overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        )
                      ]),
                  const SizedBox(
                    height: TSizes.spacebtwItems / 2,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total order',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      color: Colors.grey, fontWeightDelta: 500),
                            ),
                            Text(
                              order.orderCount.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .apply(overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Total Income',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      color: Colors.grey, fontWeightDelta: 500),
                            ),
                            Text(
                              TFormatter.formatCurrency(order.totalAmount),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .apply(overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        )
                      ]),
                ],
              ),
            ),
            TRoundedIcon(
              icon: Iconsax.arrow_right_34,
              color: TColors.primary,
              onPressed: () =>
                  Get.to(() => OrderTotalDetailScreen(orderId: order.orderId)),
            )
          ],
        ));
  }
}
