import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/service/screens/delivery_detail/delivery_detail.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class TDeliveryPackage extends StatelessWidget {
  const TDeliveryPackage({
    super.key,
  });

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
            Text(
              'Electronics/Gadgets',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(overflow: TextOverflow.ellipsis),
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Receipient: ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: 'Paul Pogba',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(overflow: TextOverflow.ellipsis))
            ])),
            const SizedBox(
              height: TSizes.spacebtwItems / 2,
            ),
            Row(
              children: [
                const TRoundedIcon(
                  icon: Iconsax.truck_fast,
                  color: TColors.primary,
                  size: 30,
                ),
                const SizedBox(
                  width: TSizes.spacebtwItems,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Iconsax.location,
                          color: Colors.green,
                        ),
                        Text(
                          TTexts.dropOff,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    Text(
                      'Maryland bustop, Anthony Ikeja',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(overflow: TextOverflow.ellipsis),
                    )
                  ],
                ))
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
                          .titleMedium!
                          .apply(overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      '15:00 PM Jun 24',
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
                        onPressed: () => Get.to(() => const DeliveryDetailScreen()),
                        child: const Text('View')))
              ],
            )
          ],
        ));
  }
}
