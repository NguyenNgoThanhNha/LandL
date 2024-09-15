import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/service/screens/map/map.dart';
import 'package:mobile/features/service/screens/map/map_goong.dart';
import 'package:mobile/features/service/screens/map/map_navigation.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class DeliveryDetailScreen extends StatelessWidget {
  const DeliveryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          TTexts.deliveryDetail,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TRoundedIcon(
                  icon: Iconsax.truck_fast,
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
                      'Trailer truck',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Text('76CF-08235'),
                    Text(
                      '3x1.5x1.2 (miles) - 5 tons',
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
                  content: 'LL37483WR',
                  backgroundColor: TColors.accent.withOpacity(0.3),
                ),
                const SizedBox(
                  width: TSizes.spacebtwItems,
                ),
                TDeliveryInfoItem(
                  title: TTexts.intendTime,
                  content: '15:00 PM Jun 24',
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
                const TLocationLine(
                  icon: Iconsax.location,
                  title: TTexts.pickupLocation,
                  iconColor: TColors.primary,
                  content: '32 Samwell Sq, Chevron32 ',
                ),
                Transform.rotate(
                  angle: 90 * 3.1415927 / 180,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: TSizes.sm * 1.2),
                    child: Icon(
                      Iconsax.more,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const TLocationLine(
                  icon: Iconsax.level,
                  title: TTexts.deliveryLocation,
                  iconColor: Colors.green,
                  content: '21b, Karimu Kotun Street, Victoria Island',
                )
              ],
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TDeliveryInfoItem(
                  title: TTexts.typePackage,
                  content: 'Electronics/Gadgets',
                  crossAxisAlignment: CrossAxisAlignment.start,
                  padding: EdgeInsets.all(TSizes.sm),
                ),
                SizedBox(
                  width: TSizes.spacebtwItems,
                ),
                TDeliveryInfoItem(
                  title: TTexts.totalWeight,
                  content: '2 tons',
                  crossAxisAlignment: CrossAxisAlignment.start,
                  padding: EdgeInsets.all(TSizes.sm),
                )
              ],
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            const Row(
              children: [
                TDeliveryInfoItem(
                  title: TTexts.senderContact,
                  content: '08123456789',
                  crossAxisAlignment: CrossAxisAlignment.start,
                  padding: EdgeInsets.all(TSizes.sm),
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
                            .apply(color: Colors.grey, fontWeightDelta: 500),
                      ),
                      Text('10.000.000 VND',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                              fontSizeFactor: 1.5,
                              fontWeightDelta: 700,
                              color: TColors.primary)),
                    ],
                  ),
                )),
                TextButton(
                    onPressed: () => Get.to(() => const MapGoongScreen()),
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
              height: TSizes.spacebtwItems,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
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
                  onPressed: () {},
                  child: const Text(
                    TTexts.accept,
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
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
                overflow: TextOverflow.visible,
              )
            ],
          ),
        )
      ],
    );
  }
}
